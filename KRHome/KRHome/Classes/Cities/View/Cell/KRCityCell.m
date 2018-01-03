//
//  KRCityCell.m
//  KRHome
//
//  Created by LX on 2018/1/3.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRCityCell.h"

@interface KRCityCell ()

@property (nonatomic, strong) UILabel *cityLabel;

@end

@implementation KRCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.cityLabel];
        [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(12);
            make.centerY.equalTo(self);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = GRAY_LINE_COLOR;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(12);
            make.trailing.equalTo(self).offset(-12);
            make.bottom.equalTo(self);
            make.height.mas_offset(0.5);
        }];
        
    }
    return self;
}

- (void)setCity:(NSString *)city {
    _city = city;
    self.cityLabel.text = city;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [UILabel labelWithText:@"" textColor:FONT_COLOR_33 fontSize:14];
    }
    return _cityLabel;
}

@end
