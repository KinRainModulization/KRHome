//
//  LXNetworkErrorView.m
//  Yml
//
//  Created by LX on 2017/10/10.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "LXNetworkErrorView.h"
#import "Masonry.h"
#import "Macros.h"
#import "UILabel+Extension.h"
#import "UIButton+Extension.h"

@interface LXNetworkErrorView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIButton *checkNetworkBtn;
@property (nonatomic, strong) UIButton *reloadBtn;

@end

@implementation LXNetworkErrorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.backgroundColor = GLOBAL_BACKGROUND_COLOR;

    [self addSubview:self.containerView];
    [self.containerView addSubview:self.errorImageView];
    [self.containerView addSubview:self.topLabel];
    [self.containerView addSubview:self.checkNetworkBtn];
    [self.containerView addSubview:self.reloadBtn];
    
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    _errorImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _checkNetworkBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _reloadBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self);
    }];
    [_errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView);
        make.centerY.equalTo(_containerView).offset(-150);
    }];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView);
        make.top.equalTo(_errorImageView.mas_bottom).offset(16);
    }];
    [_checkNetworkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView);
        make.top.equalTo(_topLabel.mas_bottom).offset(8);
    }];
    [_reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView);
        make.top.equalTo(_checkNetworkBtn.mas_bottom).offset(28);
        make.width.equalTo(@103);
        make.height.equalTo(@34);
    }];
}

#pragma mark - Action

- (void)reloadButtonClick {
    MLog(@"reloadButtonDidClick");
    self.reloadDataBlock();
}

- (void)checkNetworkButtonClick {
    MLog(@"checkNetworkButtonClick");
    self.networkSolutionBlock();
}

#pragma mark - Setter/Getter

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIImageView *)errorImageView {
    if (!_errorImageView) {
        _errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"network_error"]];
    }
    return _errorImageView;
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [UILabel labelWithText:@"网络无法连接,请检查您的网络" textColor:UIColorFromHex(0x666666) fontSize:18];
    }
    return _topLabel;
}

- (UIButton *)checkNetworkBtn {
    if (!_checkNetworkBtn) {
        _checkNetworkBtn = [UIButton buttonWithTitle:@"查看解决方案>" withFontSize:16 withTitleColor:[UIColor blueColor] withTarget:self withAction:@selector(checkNetworkButtonClick)];
    }
    return _checkNetworkBtn;
}

- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithTitle:@"重新加载" withFontSize:15 withTitleColor:UIColorFromHex(0x666666) withTarget:self withAction:@selector(reloadButtonClick)];
        _reloadBtn.backgroundColor = UIColorFromHex(0xf0f0f0);
        _reloadBtn.layer.borderColor = UIColorFromHex(0xe2e2e2).CGColor;
        _reloadBtn.layer.borderWidth = 0.5;
        _reloadBtn.layer.cornerRadius = 3;
    }
    return _reloadBtn;
}

@end
