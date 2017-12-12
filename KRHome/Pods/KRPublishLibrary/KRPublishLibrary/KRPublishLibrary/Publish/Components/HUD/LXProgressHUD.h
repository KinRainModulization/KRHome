//
//  LXProgressHUD.h
//  Yml
//
//  Created by LX on 2017/10/19.
//  Copyright © 2017年 xi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXProgressHUD : NSObject

+ (void)showLoading:(UIView *)view;

+ (void)showAnimaLoading:(UIView *)view;

+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showMessage:(NSString *)message image:(NSString *)imageName toView:(UIView *)view;

+ (void)hide;

@end
