//
//  KRHomeHeaderView.m
//  KRHome
//
//  Created by LX on 2017/12/26.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRHomeHeaderView.h"
#import "NewPagedFlowView.h"
#import "KRCustomBannerView.h"
#import "EllipsePageControl.h"

@interface KRHomeHeaderView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (nonatomic, strong) NewPagedFlowView *pageFlowView;

@property (nonatomic, strong) EllipsePageControl *pageControl;

@property (nonatomic, strong) NSArray *bannerArray;

@end

@implementation KRHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 375 * 169 + 24)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    
    pageFlowView.orginPageCount = self.bannerArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    
    EllipsePageControl *pageControl = [[EllipsePageControl alloc] init];
    pageControl.frame = CGRectMake(0, pageFlowView.height-6,SCREEN_WIDTH, 4);
    pageControl.numberOfPages = self.bannerArray.count;
    self.pageControl = pageControl;
    
    [pageFlowView addSubview:pageControl];
    [pageFlowView reloadData];
    [self addSubview:pageFlowView];
    
    self.pageFlowView = pageFlowView;
}

#pragma mark - NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    self.pageControl.currentPage = pageNumber;
    NSLog(@"CustomViewController 滚动到了第%ld页",pageNumber);
}

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 50, (SCREEN_WIDTH - 50) / 324 * 169);
}

#pragma mark - NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.bannerArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    KRCustomBannerView *bannerView = (KRCustomBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[KRCustomBannerView alloc] init];
    }
    
    //在这里下载网络图片
    //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    
//    bannerView.mainImageView.image = self.bannerArray[index];
    bannerView.mainImageView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    bannerView.mainImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    bannerView.mainImageView.layer.shadowOffset = CGSizeMake(0,11);
    bannerView.mainImageView.layer.shadowOpacity = 0.1;
    return bannerView;
}

#pragma mark - 懒加载
- (NSArray *)bannerArray {
    if (_bannerArray == nil) {
        _bannerArray = @[@"1",@"1",@"1",@"1",@"1"];
    }
    return _bannerArray;
}

- (void)dealloc {
    MLog(@"dealloc-pageFlowView");
    [self.pageFlowView stopTimer];
}

@end
