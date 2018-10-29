//
//  AppDelegate.m
//  NASAImage
//
//  Created by GuoDong on 2018/10/25.
//  Copyright © 2018 GuoDong. All rights reserved.
//

#import "AppDelegate.h"
#import "SplashView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    SplashView *splashView = [[SplashView alloc] init];
    [splashView setupWithWindow:window];
    [splashView show:4];
    return YES;
}

@end
