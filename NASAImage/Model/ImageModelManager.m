//
//  ImageModelManager.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/26.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "ImageModelManager.h"

@interface ImageModelManager () <NSXMLParserDelegate>
@property (nonatomic, copy) NSString *rssUrl;
@property (nonatomic, copy) NSString *currentString;
@property (nonatomic, copy) NSArray *elementToParse;
@property (nonatomic, assign) BOOL parseFlag;
@property (nonatomic, strong) NSMutableArray * images;
@property (nonatomic, strong) NASAImageModel * currentImage;
@end

@implementation ImageModelManager

- (instancetype)initWithRSSURL:(NSString *)url{
    if (self = [super init]) {
        self.rssUrl = url;
        self.elementToParse = [[NSArray alloc] initWithObjects:@"title",@"description",nil];
    }
    return self;
}

- (NSArray *)getImageModels {
    NSURL *url = [NSURL URLWithString:self.rssUrl];
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"获取数据失败");
    }
    
    NSXMLParser * xmlParse = [[NSXMLParser alloc]initWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    xmlParse.delegate = self;
    BOOL parseSuccess = [xmlParse parse];
    if (!parseSuccess) {
        NSLog(@"解析失败");
    }
    
    return self.images;
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.images = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"item"])
    {
        self.currentImage = [[NASAImageModel alloc] init];
    }else if ([elementName isEqualToString:@"enclosure"])
    {
        self.currentImage.imageURL = [attributeDict objectForKey:@"url"];
    }
    self.parseFlag = [self.elementToParse containsObject:elementName];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.parseFlag) {
        self.currentString = [[NSString alloc] initWithString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        [self.images addObject:self.currentImage];
        self.currentImage = nil;
    }
    if (self.parseFlag) {
        if ([elementName isEqualToString:@"title"]) {
            self.currentImage.title = self.currentString;
        }
        if ([elementName isEqualToString:@"description"]) {
            self.currentImage.des = self.currentString;
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

@end
