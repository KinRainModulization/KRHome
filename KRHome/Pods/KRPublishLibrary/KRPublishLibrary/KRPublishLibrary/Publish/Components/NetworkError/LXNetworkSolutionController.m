//
//  LXSolutionController.m
//  Yml
//
//  Created by LX on 2017/10/12.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "LXNetworkSolutionController.h"
#import "Macros.h"
#import "UIView+Extension.h"

@interface LXNetworkSolutionController ()

@end

@implementation LXNetworkSolutionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"解决方案";
    self.view.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    UIScrollView *containerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    UIImageView *contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"network_solution"]];
    contentImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 375 * 1237);
    containerView.contentSize = contentImageView.size;
    [containerView addSubview:contentImageView];
    [self.view addSubview:containerView];
}

@end
