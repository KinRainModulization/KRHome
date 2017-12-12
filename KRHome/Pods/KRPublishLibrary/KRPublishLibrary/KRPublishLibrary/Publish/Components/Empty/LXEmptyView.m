//
//  LXEmptyView.m
//  Yml
//
//  Created by LX on 2017/10/13.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "LXEmptyView.h"
#import "Masonry.h"
#import "Macros.h"
#import "UILabel+Extension.h"

@interface LXEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation LXEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.hidden = YES;
    self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-100);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_imageView.mas_bottom).offset(20);
    }];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
    }];
}

- (void)showWithImageSource:(NSString *)imageStr title:(NSString *)title subTitle:(NSString *)subTitle {
    self.hidden = NO;
    _imageView.image = [UIImage imageNamed:imageStr];
    _titleLabel.text = title;
    _subTitleLabel.text = subTitle;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"box"]];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"" textColor:UIColorFromHex(0x999999) fontSize:18];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel labelWithText:@"" textColor:UIColorFromHex(0x9f9f9f) fontSize:10];
    }
    return _subTitleLabel;
}

@end
