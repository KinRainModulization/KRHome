//
//  KRHomeController.m
//  KRHome
//
//  Created by LX on 2017/12/12.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRHomeController.h"
#import <LXProgressHUD.h>

#define kUserInfo @"kUserInfo"

@interface KRHomeController ()

@end

@implementation KRHomeController

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试";
    NSDictionary *params = @{@"uid":@"",
                             @"token":@""};
    [PublicTools setData:params toUserDefaultsKey:kUserInfo];
    
    [[NetworkTool sharedNetworkTool] POST:@"?method=msg.readNum" parameters:nil success:^(id data) {
        MLog(@"%@",data);
    } failure:^(NSError *error) {
        MLog(@"==>%@",error);
    }];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 100, 100);
    [button setTitle:@"跳转商品详情页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *loginBtn = [UIButton buttonWithTitle:@"登陆" withFontSize:15 withTitleColor:[UIColor redColor] withTarget:self withAction:@selector(loginButtonClick)];
    loginBtn.frame = CGRectMake(0, 200, 100, 100);
    [self.view addSubview:loginBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    
}

- (void)loadData {
    if ([PublicTools checkNetwork]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.hiddenNetworkErrorView = YES;
        });
    }
}

- (void)loginButtonClick {
    [LXProgressHUD showMessage:@"登录" toView:self.view];
}

- (void)buttonClick {
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
    //    [HUDTool showMessage:@"弹弹弹弹弹" toView:self.view];
}

- (void)push {
    //    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    //    [alertController addAction:cancelAction];
    //    [alertController addAction:okAction];
    //    [self presentViewController:alertController animated:YES completion:nil];
    
    //    LXAlertView *alertView = [LXAlertView alertViewWithTitle:nil message:@"文本" buttonTitles:@[@"取消",@"确定"] handler:^(LXAlertView *alertView, NSInteger buttonIndex) {
    //        if (buttonIndex == 1) {
    //            [self.navigationController pushViewController:[[LXCommunityController alloc] init] animated:YES];
    //        }
    //    }];
    //    [alertView show];
    
    // 动画加载
    [LXProgressHUD showLoading:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LXProgressHUD hide];
    });
    
}

@end
