//
//  AppDelegate.m
//  KRHome
//
//  Created by LX on 2017/12/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "AppDelegate.h"
#import "KRHomeController.h"
#import <BaseNavigationController.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BaseNavigationController *navController = [[BaseNavigationController alloc]initWithRootViewController:[[KRHomeController alloc] init]];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
