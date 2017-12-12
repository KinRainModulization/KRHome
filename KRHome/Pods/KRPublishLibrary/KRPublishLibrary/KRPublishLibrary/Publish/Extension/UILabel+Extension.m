//
//  UILabel+Extension.m
//  Yml
//
//  Created by LX on 2017/10/10.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize {
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = text;
    label.textColor = color;
    [label sizeToFit];
    return label;
}
@end
