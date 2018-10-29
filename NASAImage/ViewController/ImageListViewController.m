//
//  ImageListViewController.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/25.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "ImageListViewController.h"
#import "ImageTableViewCell.h"
#import "ImageModelManager.h"
#import "ImageViewController.h"
#import "ImageTransitioningDelegate.h"
#import "ImageProcessManager.h"

@interface ImageListViewController () <UITableViewDataSource, UITableViewDelegate, ImageTableViewCellDelegate>
@property (nonatomic, strong) ImageModelManager *imageModelManager;
@property (nonatomic, strong) NSArray *imageModels;
@end

static NSString * const kImageCellId = @"imagecell";

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    [self loadImages];
}

- (void)setupSubViews{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:kImageCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadImages {
    self.imageModelManager = [[ImageModelManager alloc] initWithRSSURL:@"https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"];
    self.imageModels = [self.imageModelManager getImageModels];
    [self.tableView reloadData];
    [[ImageProcessManager sharedInstance] preloadImagesWithModels:self.imageModels];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageModels.count / 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = kImageCellId;
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    [cell setupWithmodelA:[self.imageModels objectAtIndex:indexPath.row*2]  modelB:[self.imageModels objectAtIndex:(indexPath.row*2+1)] rowindex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

#pragma mark - ImageTableViewCellDelegate

- (void)imageTableViewCell:(ImageTableViewCell *)cell didTapIndex:(NSInteger)idx withCellFrame:(CGRect)cellFrame {
    ImageViewController *imageVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"imageVC"];
    NASAImageModel * model = [self.imageModels objectAtIndex:idx];
    imageVC.imageModel = model;
    ImageTransitioningDelegate * imagetransitioningDelegate = [[ImageTransitioningDelegate alloc] init];
    imagetransitioningDelegate.isPresented = YES;
    imagetransitioningDelegate.cellFrame = cellFrame;
    imagetransitioningDelegate.imgURL = model.imageURL;
    imageVC.imageTransitioningDelegate = imagetransitioningDelegate;
    imageVC.modalPresentationStyle = UIModalPresentationCustom;
    imageVC.transitioningDelegate = imagetransitioningDelegate;
    [self presentViewController:imageVC animated:YES completion:nil];
}

@end
