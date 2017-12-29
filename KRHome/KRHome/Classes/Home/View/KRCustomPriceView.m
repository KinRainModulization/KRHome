//
//  KRCustomPriceView.m
//  KRHome
//
//  Created by LX on 2017/12/29.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRCustomPriceView.h"

@implementation KRCustomPriceView

+ (instancetype)customPriceViewWithPrice:(NSString *)price integerFontSize:(CGFloat)integerSize decimalFontSize:(CGFloat)decimalSize {
    
    KRCustomPriceView *contentView = [[KRCustomPriceView alloc] init];
    NSArray *priceArray = [price componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
    UILabel *dollarSignLabel = [UILabel labelWithText:@"￥" textColor:RGB(255, 0, 54) fontSize:decimalSize];
    UILabel *integerLabel = [UILabel labelWithText:[NSString stringWithFormat:@"%@.",priceArray[0]] textColor:RGB(255, 0, 54) fontSize:integerSize];
    UILabel *decimalLabel = [UILabel labelWithText:priceArray[1] textColor:RGB(255, 0, 54) fontSize:decimalSize];
    
    [contentView addSubview:dollarSignLabel];
    [contentView addSubview:integerLabel];
    [contentView addSubview:decimalLabel];
    
    dollarSignLabel.x = 0;
    dollarSignLabel.y = integerLabel.height-dollarSignLabel.height;
    integerLabel.x = dollarSignLabel.width;
    integerLabel.y = 0;
    decimalLabel.x = integerLabel.x + integerLabel.width;
    decimalLabel.y = integerLabel.height-decimalLabel.height;
    contentView.size = CGSizeMake(dollarSignLabel.width+integerLabel.width+decimalLabel.width, integerLabel.height);
    return contentView;
}

@end
