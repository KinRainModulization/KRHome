//
//  LXProgressHUD.m
//  Yml
//
//  Created by LX on 2017/10/19.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "LXProgressHUD.h"
#import "MBProgressHUD.h"

#define HUDManager [LXProgressHUD shareInstance].hud
#define kDefaultTimeInterval 0.75

typedef NS_ENUM(NSInteger,HUDMode){
    HUDModeOnlyText,              //文字
    HUDModeLoading,               //加载菊花
    HUDModeCustomAnimation,       //自定义加载动画
    HUDModeCustomerImage          //自定义图片+文字
};

@interface LXProgressHUD ()

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) NSMutableArray *animaImages;

@end

@implementation LXProgressHUD

+ (instancetype)shareInstance {
    static LXProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LXProgressHUD alloc] init];
    });
    return instance;
}

+ (void)showLoading:(UIView *)view {
    [self show:@"" inView:view mode:HUDModeLoading customView:nil];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    [self show:message inView:view mode:HUDModeOnlyText customView:nil];
}

+ (void)showMessage:(NSString *)message image:(NSString *)imageName toView:(UIView *)view {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:message inView:view mode:HUDModeCustomerImage customView:imageView];
}

+ (void)showAnimaLoading:(UIView *)view {
    NSArray *imageArray = [LXProgressHUD shareInstance].animaImages;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.animationImages = imageArray;
    [imageView setAnimationRepeatCount:0];
    [imageView setAnimationDuration:(imageArray.count + 1) * 0.06];
    [imageView startAnimating];
    [self show:@"数据加载中" inView:view mode:HUDModeCustomAnimation customView:imageView];
}

+ (void)hide {
    if (HUDManager != nil) {
        [HUDManager hideAnimated:YES];
    }
}

+ (void)show:(NSString *)message inView:(UIView *)view mode:(HUDMode)mode customView:(UIImageView *)customView {
    if (HUDManager != nil) {
        [HUDManager hideAnimated:YES];
        HUDManager = nil;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.text = message;
    HUDManager = hud;
    
    switch (mode) {
        case HUDModeOnlyText:
            HUDManager.mode = MBProgressHUDModeText;
            [HUDManager hideAnimated:YES afterDelay:kDefaultTimeInterval];
            break;
            
        case HUDModeLoading:
            HUDManager.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case HUDModeCustomerImage:
            HUDManager.mode = MBProgressHUDModeCustomView;
            HUDManager.customView = customView;
            [HUDManager hideAnimated:YES afterDelay:1.0];
            break;
            
        case HUDModeCustomAnimation:
            //这里设置动画的背景色
            HUDManager.mode = MBProgressHUDModeCustomView;
            HUDManager.customView = customView;
            break;
            
        default:
            break;
    }
}

- (NSMutableArray *)animaImages {
    if (!_animaImages) {
        _animaImages = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 30; i++) {
            [_animaImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]]];
        }
    }
    return _animaImages;
}

@end
