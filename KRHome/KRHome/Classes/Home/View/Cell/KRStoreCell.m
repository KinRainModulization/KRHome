//
//  KRStoreCell.m
//  KRHome
//
//  Created by LX on 2017/12/29.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRStoreCell.h"

@interface KRStoreCell ()

@property (nonatomic, strong) UIImageView *storeImageView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *storeNameLabel;
@end

@implementation KRStoreCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    [self addSubview:self.storeImageView];
    [self addSubview:self.iconView];
    [self addSubview:self.storeNameLabel];
    
    [_storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.height.mas_equalTo(self.height-21);
    }];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(6);
        make.width.height.mas_equalTo(29);
        make.bottom.equalTo(self);
    }];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_iconView.mas_trailing).offset(10);
        make.bottom.equalTo(self);
    }];
}

- (UIImageView *)storeImageView {
    if (!_storeImageView) {
        _storeImageView = [[UIImageView alloc] init];
        _storeImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _storeImageView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor redColor];
        _iconView.layer.cornerRadius = 14.5;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [UILabel labelWithText:@"店铺名" textColor:FONT_COLOR_33 fontSize:13];
    }
    return _storeNameLabel;
}
@end
