//
//  UIButton+Extension.m
//  QuickBooks
//
//  Created by 希 on 16/7/12.
//  Copyright © 2016年 shijiabao. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
/**
 *  自定义button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withTarget:(id)target withAction:(SEL)action {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 *  文左图右按钮
 *
 *  @param imageName 图片
 *  @param spacing   图片与文字间距
 */
+ (UIButton *)buttonWithImage:(NSString *)imageName withSpacing:(CGFloat)spacing withTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withTarget:(id)target withAction:(SEL)action {
    UIButton *button = [self buttonWithTitle:title withFontSize:size withTitleColor:color withTarget:target withAction:action];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button sizeToFit];
    CGFloat imageWidth = button.imageView.bounds.size.width;
    CGFloat titleWidth = button.titleLabel.bounds.size.width;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth+spacing, 0, -(titleWidth+spacing));
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);

    return button;
}
/**
 *  圆角按钮
 */
+ (UIButton *)buttonWithCornerRadius:(CGFloat)cornerRadius withTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withBackgroundColor:(UIColor *)bgColor withTarget:(id)target withAction:(SEL)action {
    UIButton * button = [self buttonWithTitle:title withFontSize:size withTitleColor:color withTarget:target withAction:action];
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    [button setBackgroundColor:bgColor];
    return button;
}
/**
 *  圆角边框按钮
 */
+ (UIButton *)buttonWithCornerRadius:(CGFloat)cornerRadius withBorderColor:(UIColor *)borderColor withTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withBackgroundColor:(UIColor *)bgColor withTarget:(id)target withAction:(SEL)action {
    UIButton * button = [self buttonWithCornerRadius:cornerRadius withTitle:title withFontSize:size withTitleColor:color withBackgroundColor:bgColor withTarget:target withAction:action];
    button.layer.borderWidth = 1;
    button.layer.borderColor = borderColor.CGColor;
    return button;
}

@end
