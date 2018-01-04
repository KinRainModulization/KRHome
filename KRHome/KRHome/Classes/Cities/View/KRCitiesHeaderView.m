//
//  KRCitiesHeaderView.m
//  KRHome
//
//  Created by LX on 2018/1/3.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRCitiesHeaderView.h"

@interface KRCitiesHeaderView ()

@property (nonatomic, strong) UILabel *currentCityLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *locateCityBtn;

@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation KRCitiesHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGB(250, 250, 250);
    
    [self addSubview:self.currentCityLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.locateCityBtn];
    [self addSubview:self.subtitleLabel];
    [self addSubview:lineView];
    
    [_currentCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(24);
        make.leading.equalTo(self).offset(12);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_currentCityLabel.mas_bottom).offset(28);
        make.leading.equalTo(_currentCityLabel);
    }];
    [_locateCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(15);
        make.leading.equalTo(_currentCityLabel);
        make.width.mas_equalTo(_locateCityBtn.width+40);
        make.height.mas_equalTo(30);
    }];
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_locateCityBtn);
        make.leading.equalTo(_locateCityBtn.mas_trailing).offset(15);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_offset(10);
    }];
}

- (void)locateCityBtnClick {
    self.locateCityBlock();
}

- (void)locateCity:(NSString *)city withLocationStatus:(LocationStatus)status {
    NSString *contentStr = city;
    NSString *subtitle = nil;
    UIImage *iconView = nil;
    if (status == LocationCityStatusDefault) {
        contentStr = @"定位中...";
    }
    else if (status == LocationCityStatusServing) {
        iconView = [UIImage imageNamed:@"ic_unlocated"];
    }
    else if (status == LocationCityStatusNotServing) {
        iconView = [UIImage imageNamed:@"ic_located"];
        subtitle = @"暂未开通服务，敬请期待";
        [self.locateCityBtn setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
        self.locateCityBtn.userInteractionEnabled = NO;
    }
    else {
        contentStr = @"重试";
        subtitle = @"定位失败，点击重试";
        iconView = [UIImage imageNamed:@"ic_unlocated"];
    }
    
    [self.locateCityBtn setTitle:contentStr forState:UIControlStateNormal];
    [self.locateCityBtn setImage:iconView forState:UIControlStateNormal];
    self.locateCityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self.locateCityBtn sizeToFit];
    [_locateCityBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_locateCityBtn.width+40);
    }];

    self.subtitleLabel.text = subtitle;
}

- (void)setCurrentCity:(NSString *)currentCity {
    _currentCity = currentCity;
    self.currentCityLabel.text = [NSString stringWithFormat:@"当前：%@",currentCity];
}

- (UILabel *)currentCityLabel {
    if (!_currentCityLabel) {
        _currentCityLabel = [UILabel labelWithText:@"当前：" textColor:RGB(143, 222, 239) fontSize:14];
    }
    return _currentCityLabel;
}

- (UIButton *)locateCityBtn {
    if (!_locateCityBtn) {
        _locateCityBtn = [UIButton buttonWithCornerRadius:15 title:@"" fontSize:12 titleColor:GLOBAL_COLOR backgroundColor:RGB(245, 245, 245) target:self action:@selector(locateCityBtnClick)];
    }
    return _locateCityBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"定位城市" textColor:FONT_COLOR_99 fontSize:12];
        _titleLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel labelWithText:@"" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _subtitleLabel;
}

@end
