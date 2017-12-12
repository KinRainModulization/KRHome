//
//  Target_KRHome.m
//  KRHome
//
//  Created by LX on 2017/12/12.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "Target_KRHome.h"
#import "KRHomeController.h"

@implementation Target_KRHome

- (UIViewController *)Action_HomeViewController:(NSDictionary *)params {
    KRHomeController *homeVC = [[KRHomeController alloc] init];
//    homeVC.goodsId = params[@"goodsId"];
//    homeVC.goodsName = params[@"goodsName"];
    return homeVC;
}

@end
