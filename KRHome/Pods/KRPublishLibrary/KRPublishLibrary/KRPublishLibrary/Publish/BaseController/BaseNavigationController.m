//
//  LXBaseNavigationController.m
//  Yml
//
//  Created by LX on 2017/6/12.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIView+Extension.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    bar.translucent = NO;
    [bar setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
// 侧滑返回
//    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        btn.size = btn.currentImage.size;
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
