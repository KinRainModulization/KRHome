//
//  KRHomeNavBar.h
//  KRHome
//
//  Created by LX on 2018/1/2.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRHomeNavBar : UIView

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) void (^citySelectBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

@end
