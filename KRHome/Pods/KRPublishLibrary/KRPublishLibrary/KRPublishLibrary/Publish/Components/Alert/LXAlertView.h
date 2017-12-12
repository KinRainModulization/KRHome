//
//  LXAlertView.h
//  Yml
//
//  Created by LX on 2017/10/18.
//  Copyright © 2017年 xi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXAlertView;

typedef NS_ENUM(NSInteger, LXAlertButtonStyle) {
    LXAlertActionButtonCancel = 0,
    LXAlertActionButtonDefault,
};

typedef void (^buttonClickBlock)(LXAlertView *alertView, NSInteger buttonIndex);

@interface LXAlertView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, copy) buttonClickBlock buttonClickBlock;

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles handler:(void (^)(LXAlertView *alertView, NSInteger buttonIndex))handler;

- (void)show;

- (void)dismiss;

@end
