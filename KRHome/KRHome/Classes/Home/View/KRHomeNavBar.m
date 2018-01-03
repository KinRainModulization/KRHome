//
//  KRHomeNavBar.m
//  KRHome
//
//  Created by LX on 2018/1/2.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRHomeNavBar.h"

static const CGFloat kNavBarButtonSpacing = 6.5;

@interface KRHomeNavBar ()
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIButton *cityBtn;
@end

@implementation KRHomeNavBar

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint newPoint = [_cityBtn convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(_cityBtn.bounds, newPoint)) {
            view = _cityBtn;
        }
    }
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    if (self = [super initWithFrame:frame]) {

        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qylogo"]];
        [self addSubview:logoView];
        [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(-logoView.width*0.5);
            make.centerY.equalTo(self);
        }];
        _logoView = logoView;
        
        UIButton *cityBtn = [UIButton buttonWithImage:@"arrow_down" spacing:kNavBarButtonSpacing title:title fontSize:12 titleColor:FONT_COLOR_33 target:self action:@selector(cityBtnClick)];
        [self addSubview:cityBtn];
        [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(logoView.mas_trailing).offset(7);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(cityBtn.width);
        }];
        _cityBtn = cityBtn;
    }
    return self;
}

- (void)setCityName:(NSString *)cityName {
    _cityName = cityName;
    [_cityBtn setTitle:cityName forState:UIControlStateNormal];
    [_cityBtn sizeToFit];
    CGFloat imageWidth = _cityBtn.imageView.bounds.size.width;
    CGFloat titleWidth = _cityBtn.titleLabel.bounds.size.width;
    _cityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth+kNavBarButtonSpacing, 0, -(titleWidth+kNavBarButtonSpacing));
    _cityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    [_cityBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_cityBtn.width);
    }];
}

- (void)cityBtnClick {
    self.citySelectBlock();
}

@end
