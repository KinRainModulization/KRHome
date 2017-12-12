//
//  LXAlertView.m
//  Yml
//
//  Created by LX on 2017/10/18.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "LXAlertView.h"
#import "Masonry.h"
#import "Macros.h"
#import "UILabel+Extension.h"

const static CGFloat kAlertViewDefaultWidth          = 280;
const static CGFloat kAlertViewDefaultButtonHeight   = 50;
const static CGFloat kAlertViewCornerRadius          = 2;

@interface LXAlertView ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation LXAlertView

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles handler:(void(^)(LXAlertView *alertView, NSInteger buttonIndex))handler {
    LXAlertView *alertView = [[LXAlertView alloc] initWithTitle:title message:message buttonTitles:buttonTitles];
    alertView.buttonClickBlock = handler;
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles {
    if (self = [super init]) {
        _title = title;
        _message = message;
        _buttonTitles = buttonTitles;
        [self createContainerView];
    }
    return [self init];
}

- (UIView *)createContainerView {
    CGSize containerViewSize = CGSizeMake(280, _title ? 150 : 135);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - containerViewSize.width) / 2, (SCREEN_HEIGHT - containerViewSize.height) / 2, containerViewSize.width, containerViewSize.height)];
    _containerView.backgroundColor = [UIColor whiteColor];
    
    _containerView.layer.cornerRadius = kAlertViewCornerRadius;
    _containerView.layer.shadowRadius = kAlertViewCornerRadius + 5;
    _containerView.layer.shadowOpacity = 0.1f;
    _containerView.layer.shadowOffset = CGSizeMake(0 - (kAlertViewCornerRadius + 5) / 2, 0 - (kAlertViewCornerRadius + 5) / 2);
    _containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    _containerView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_containerView.bounds cornerRadius:_containerView.layer.cornerRadius].CGPath;

    // 顶部绿色线条
    UIView *greenLineView = [[UIView alloc] init];
    greenLineView.backgroundColor = RGB(87, 225, 214);
    [_containerView addSubview:greenLineView];
    // 标题
    UILabel *titleView = [[UILabel alloc] init];
    if (_title.length) {
        titleView.text = _title;
        titleView.font = [UIFont boldSystemFontOfSize:18];
        titleView.textColor = [UIColor blackColor];
        titleView.textAlignment = NSTextAlignmentCenter;
        [_containerView addSubview:titleView];
    }
    // 文本
    UILabel *messageView = [UILabel labelWithText:_message textColor:RGB(51, 51, 51) fontSize:15];
    messageView.numberOfLines = 0;
    if (!_title) {
        messageView.font = [UIFont boldSystemFontOfSize:15];
    }
    [_containerView addSubview:messageView];
    // 分隔线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGB(229, 229, 229);
    [_containerView addSubview:lineView];
    // 选项按钮
    UIView *btnContainerView = [[UIView alloc] init];
    [_containerView addSubview:btnContainerView];
    [self addButtonsToView:btnContainerView];
    
    // 添加约束
    [greenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.trailing.equalTo(_containerView);
        make.height.equalTo(@2);
    }];
    if (_title) {
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_containerView).offset(20);
            make.left.trailing.equalTo(_containerView);
            make.height.equalTo(@17);
        }];
    }
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title ? titleView.mas_bottom : _containerView);
        make.left.equalTo(_containerView).offset(20);
        make.trailing.equalTo(_containerView).offset(-20);
        make.bottom.equalTo(lineView.mas_top);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.trailing.equalTo(_containerView);
        make.bottom.equalTo(btnContainerView.mas_top);
        make.height.equalTo(@0.5);
    }];
    [btnContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.trailing.bottom.equalTo(_containerView);
        make.height.equalTo(@50);
    }];
    
    return _containerView;
}

- (void)addButtonsToView: (UIView *)container {
    if (!_buttonTitles) return;
    
    NSInteger buttonCount = [_buttonTitles count];
    CGFloat buttonW = kAlertViewDefaultWidth / buttonCount;
    
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, kAlertViewDefaultButtonHeight);
        [button setTitle:_buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:buttonCount != 1 && i == 0 ? RGB(102, 102, 102) : RGB(48, 217, 196) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        [container addSubview:button];
        if (i > 0) { //分隔线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * buttonW, 0, 0.5, kAlertViewDefaultButtonHeight)];
            lineView.backgroundColor = RGB(229, 229, 229);
            [container addSubview:lineView];
        }
    }
}

- (void)buttonClick:(id)sender {
    [self dismiss];
    if (_buttonClickBlock) {
        _buttonClickBlock(self, [sender tag]);
    }
}

- (void)show {
    // layer光栅化，提高性能
    _containerView.layer.shouldRasterize = YES;
    _containerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.backgroundColor = RGBA(0, 0, 0, 0);
    
    [self addSubview:_containerView];
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    _containerView.layer.opacity = 0.5f;
    //    _containerView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0); // 由大变小的动画
    
    [UIView animateWithDuration:0.1f delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.backgroundColor = RGBA(0, 0, 0, 0.1f);
                         _containerView.layer.opacity = 1.0f;
                         //                         _containerView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:nil
     ];
    
}

- (void)dismiss {
    CATransform3D currentTransform = _containerView.layer.transform;
    _containerView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         _containerView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         _containerView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }
     ];
}

@end
