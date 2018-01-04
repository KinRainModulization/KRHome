//
//  KRHomeHeaderView.m
//  KRHome
//
//  Created by LX on 2017/12/26.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRHomeHeaderView.h"
#import "KRCustomBannerView.h"
#import <NewPagedFlowView.h>
#import <EllipsePageControl.h>
#import "KRPicNavsView.h"
#import "KRStoreCell.h"

static NSString * kStoreCellIdentifier = @"kStoreCellIdentifier";
static const CGFloat kStoreHeaderHeight = 50;

@interface KRHomeHeaderView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NewPagedFlowView *pageFlowView;

@property (nonatomic, strong) EllipsePageControl *pageControl;

@property (nonatomic, strong) KRPicNavsView *picNavsView;

@property (nonatomic, strong) UICollectionView *storesView;

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
    self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HomeBannerHeight)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    pageFlowView.orginPageCount = self.bannerArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    self.pageFlowView = pageFlowView;

    EllipsePageControl *pageControl = [[EllipsePageControl alloc] init];
    pageControl.frame = CGRectMake(0, pageFlowView.height-6,SCREEN_WIDTH, 4);
    pageControl.numberOfPages = self.bannerArray.count;
    self.pageControl = pageControl;
    
    [pageFlowView addSubview:pageControl];
    [pageFlowView reloadData];
    [self addSubview:pageFlowView];
    
    KRPicNavsView *picNavsView = [[KRPicNavsView alloc] initWithFrame:CGRectMake(0, HomeBannerHeight+HomeMargin, SCREEN_WIDTH, HomePicNavsHeight)];
    [picNavsView customViewForStyle:DefaultPicStyle whitImageSource:nil];
    [self addSubview:picNavsView];
    
    
    UIView *storeHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, picNavsView.y+HomePicNavsHeight+HomeMargin, SCREEN_WIDTH, kStoreHeaderHeight)];
    storeHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel labelWithText:@"附近优质商家" textColor:FONT_COLOR_33 fontSize:16];
    titleLabel.x = 12;
    titleLabel.centerY = storeHeaderView.height*0.5;
    [storeHeaderView addSubview:titleLabel];
    
    UIButton *moreBtn =[UIButton buttonWithImage:@"arrow_right_blue" spacing:1.5 title:@"更多" fontSize:13 titleColor:RGB(102, 219, 247) target:self action:@selector(moreBtnClick)];
    moreBtn.x = SCREEN_WIDTH-12-moreBtn.width;
    moreBtn.centerY = titleLabel.centerY;
    [storeHeaderView addSubview:moreBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kStoreHeaderHeight-0.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = GRAY_LINE_COLOR;
    [storeHeaderView addSubview:lineView];

    [self addSubview:storeHeaderView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH*0.6, HomeStoresHeight-kStoreHeaderHeight-15*2);
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(15, 12, 15, 0);
    UICollectionView *storesView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, storeHeaderView.y+kStoreHeaderHeight, SCREEN_WIDTH, HomeStoresHeight-kStoreHeaderHeight) collectionViewLayout:layout];
    [storesView registerClass:[KRStoreCell class] forCellWithReuseIdentifier:kStoreCellIdentifier];
    storesView.delegate = self;
    storesView.dataSource = self;
    storesView.backgroundColor = [UIColor whiteColor];
    storesView.showsHorizontalScrollIndicator = NO;
    storesView.bounces = NO;
    self.storesView = storesView;
    [self addSubview:storesView];
}

#pragma mark - Action

- (void)moreBtnClick {
    MLog(@"moreBtnClick");
}

#pragma mark - NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    self.pageControl.currentPage = pageNumber;
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

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KRStoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStoreCellIdentifier forIndexPath:indexPath];
    return cell;
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
