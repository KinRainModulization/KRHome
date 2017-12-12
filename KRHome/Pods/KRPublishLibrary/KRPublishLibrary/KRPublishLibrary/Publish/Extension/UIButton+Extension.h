//
//  UIButton+Extension.h
//  QuickBooks
//
//  Created by 希 on 16/7/12.
//  Copyright © 2016年 xi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

+ (UIButton *)buttonWithTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withTarget:(id)target withAction:(SEL)action;
/**
 *  文左图右按钮
 *
 *  @param imageName 图片
 *  @param spacing   图片与文字间距
 */
+ (UIButton *)buttonWithImage:(NSString *)imageName withSpacing:(CGFloat)spacing withTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withTarget:(id)target withAction:(SEL)action;
/**
 *  圆角按钮
 */
+ (UIButton *)buttonWithCornerRadius:(CGFloat)cornerRadius withTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withBackgroundColor:(UIColor *)bgColor withTarget:(id)target withAction:(SEL)action;
/**
 *  圆角边框按钮
 */
+ (UIButton *)buttonWithCornerRadius:(CGFloat)cornerRadius withBorderColor:(UIColor *)borderColor withTitle:(NSString *)title withFontSize:(CGFloat)size withTitleColor:(UIColor *)color withBackgroundColor:(UIColor *)bgColor withTarget:(id)target withAction:(SEL)action;
@end
