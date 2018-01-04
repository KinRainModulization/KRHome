//
//  KRHomeController.m
//  KRHome
//
//  Created by LX on 2017/12/12.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRHomeController.h"
#import <KRPublishLibrary/LXProgressHUD.h>
#import "KRHomeNavBar.h"
#import "KRContainerTableView.h"
#import "KRHomeHeaderView.h"
#import "SPPageMenu.h"
#import "KRProjectController.h"
#import "GeoManager.h"
#import "KRCitiesController.h"


#define kUserInfo @"UserInfo"
#define kCurrentCityKey @"CurrentCity"
#define kSubViewH SCREEN_HEIGHT - NAV_BAR_HEIGHT - kPageMenuH
#define kHeaderViewH round(HomeBannerHeight + HomePicNavsHeight + HomeStoresHeight + HomeMargin * 3)
static const CGFloat kPageMenuH = 50;
static NSString *kPageScrollCellIdentifier = @"kPageScrollCellIdentifier";

@interface KRHomeController () <UITableViewDelegate, UITableViewDataSource, SPPageMenuDelegate>

@property (nonatomic, strong) NSArray *pageArray;

@property (nonatomic, strong) KRHomeNavBar *navBar;

@property (nonatomic, strong) KRContainerTableView *containerTableView;

@property (nonatomic, strong) KRHomeHeaderView *headerView;

@property (nonatomic, strong) UIScrollView *pageScrollView;

@property (nonatomic, strong) SPPageMenu *pageMenuView;

@property (nonatomic, strong) UIScrollView *childVCScrollView;

@property (nonatomic, strong) NSDictionary *city;
@end

@implementation KRHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[GeoManager sharedInstance] configure:@"49722449b155b0607f20176277f556bc"];

    [self prepareUI];
    
    [self locateCity];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subTableViewDidScroll:) name:HOME_SUB_TABLEVIEW_SCROLL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeCity:) name:HOME_CHANGE_CITY object:nil];
}

- (void)prepareUI {
    // navBar
    self.navigationItem.titleView = self.navBar;
    WEAK_SELF;
    self.navBar.citySelectBlock = ^{
        [weakSelf handleCitySelect];
    };
    
    [self.view addSubview:self.containerTableView];
    self.containerTableView.tableHeaderView = self.headerView;
    
    for (int i = 0; i < self.pageArray.count; i++) {
        KRProjectController *vc = [[KRProjectController alloc] init];
        [self addChildViewController:vc];
    }
    [self.pageScrollView addSubview:self.childViewControllers[0].view];
}

- (void)locateCity {
    // 请求已开通城市列表
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSDictionary *defaultCity = @{@"code":@"500100",@"city":@"沈阳"};
        NSArray *servingCities = @[@{@"code":@"100010",@"city":@"北京"},@{@"code":@"20000",@"city":@"广州"}];
        
        [[GeoManager sharedInstance] requestLocationWithReGeocode:YES completionBlock:^(NSDictionary *location, NSError *error) {
            NSDictionary *currentCity = [PublicTools getDataFromUserDefaultsWithKey:kCurrentCityKey];
            
            if (error) {
                if ([error.userInfo[@"info"] isEqualToString:@"AuthorizationStatusDenied"]) {//不允许定位
                    self.city = currentCity ? currentCity : defaultCity;
                    [self alertWithTitle:@"您还未开启定位" Message:@"美丽从定位开始，请在设置>轻雨>定位服务中开启" leftText:@"暂不" rightText:@"去设置" handler:^(UIAlertAction *action) {
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                }
                return;
            }
            
            NSString *locatedCity = [location[@"city"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
            NSDictionary *servingCity = nil;
            for (NSDictionary *city in servingCities) {
                if ([locatedCity isEqualToString:city[@"city"]]) {
                    servingCity = city;
                }
            }
            
            // 首次加载
            if (!currentCity) {
                self.city = servingCity ? servingCity : defaultCity;
                if (!servingCity) {
                    [self alertWithTitle:@"定位城市未开通服务" Message:[NSString stringWithFormat:@"定位城市“%@”暂未开通服务，请选择其他服务城市进行浏览",locatedCity] leftText:nil rightText:@"我知道了" handler:nil];
                }
                return;
            }
            
            // ?
            self.city = currentCity;
            
            // 城市变更且开通服务
            if (![currentCity[@"city"] isEqualToString:locatedCity] && servingCity) {
                [self alertWithTitle:@"切换定位城市" Message:[NSString stringWithFormat:@"定位城市已变更为“%@”，是否切换至“%@”？",locatedCity,locatedCity] leftText:@"否" rightText:@"是" handler:^(UIAlertAction *action) {
                    self.city = servingCity;
                }];
                MLog(@"城市变更且开通服务 = %@",self.city);
            }
        }];
    });

}

- (void)loadData {
    NSDictionary *params = @{@"uid":@"",
                             @"token":@""};
    [PublicTools setData:params toUserDefaultsKey:kUserInfo];
    [[NetworkTool sharedNetworkTool] POST:@"?method=msg.readNum" parameters:nil success:^(id data) {
        NSLog(@"%@",data);
    } failure:^(NSError *error) {
        NSLog(@"==>%@",error);
    }];
    if ([PublicTools checkNetwork]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.hiddenNetworkErrorView = YES;
        });
    }
}

- (void)alertWithTitle:(NSString *)title Message:(NSString *)message leftText:(NSString *)leftText rightText:(NSString *)rightText handler:(void (^ __nullable)(UIAlertAction *action))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (leftText.length) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftText style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
    }
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:rightText style:UIAlertActionStyleDefault handler:handler];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Action

- (void)handleCitySelect {
    [self.navigationController pushViewController:[[KRCitiesController alloc] init] animated:YES];
}

#pragma mark - Notification

- (void)subTableViewDidScroll:(NSNotification *)notification {
    UIScrollView *scrollView = notification.object;
    self.childVCScrollView = scrollView;
    if (self.containerTableView.contentOffset.y < kHeaderViewH) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }
    else {
        //        self.tableView.contentOffset = CGPointMake(0, HeaderViewH);
        scrollView.showsVerticalScrollIndicator = YES;
    }
}

- (void)handleChangeCity:(NSNotification *)notification {
    MLog(@"notification=%@",notification.userInfo);
    self.city = notification.userInfo;
}

#pragma mark - UITableViewDataSource / Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.containerTableView == scrollView) {
        if (self.childVCScrollView && _childVCScrollView.contentOffset.y > 0) {
            self.containerTableView.contentOffset = CGPointMake(0, kHeaderViewH);
        }
        CGFloat offSetY = scrollView.contentOffset.y;
        
        if (offSetY < kHeaderViewH) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeHeaderViewToTopNotification" object:nil];
        }
    }
    else if (scrollView == self.pageScrollView) {
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPageScrollCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kPageScrollCellIdentifier];
    }
    // 添加悬浮菜单
    [cell.contentView addSubview:self.pageMenuView];
    [cell.contentView addSubview:self.pageScrollView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT;
}

#pragma mark - SPPageMenuDelegate

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (!self.childViewControllers.count) { return;}
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.pageScrollView setContentOffset:CGPointMake(_pageScrollView.frame.size.width * toIndex, 0) animated:NO];
    } else {
        [self.pageScrollView setContentOffset:CGPointMake(_pageScrollView.frame.size.width * toIndex, 0) animated:YES];
    }
    
    KRProjectController *targetViewController = self.childViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(SCREEN_WIDTH*toIndex, 0, SCREEN_WIDTH, kSubViewH);
    UIScrollView *s = targetViewController.view;
    CGPoint contentOffset = s.contentOffset;
    if (contentOffset.y >= kHeaderViewH) {
        contentOffset.y = kHeaderViewH;
    }
    s.contentOffset = contentOffset;
    [self.pageScrollView addSubview:targetViewController.view];
}

#pragma mark - Setter/Getter

- (void)setCity:(NSDictionary *)city {
    _city = city;
    [PublicTools setData:city toUserDefaultsKey:kCurrentCityKey];
    self.navBar.cityName = city[@"city"];
    MLog(@"重新加载数据");
}

- (KRHomeNavBar *)navBar {
    if (!_navBar) {
        NSDictionary *currentCity = [PublicTools getDataFromUserDefaultsWithKey:kCurrentCityKey];
        NSString *title = currentCity ? currentCity[@"city"] : @"定位中...";
        _navBar = [[KRHomeNavBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT) withTitle:title];
    }
    return _navBar;
}

- (KRContainerTableView *)containerTableView {
    if (!_containerTableView) {
        _containerTableView = [[KRContainerTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _containerTableView.dataSource = self;
        _containerTableView.delegate = self;
        _containerTableView.showsVerticalScrollIndicator = NO;
    }
    return _containerTableView;
}

- (KRHomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[KRHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewH)];
    }
    return _headerView;
}

- (UIScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] init];
        _pageScrollView.frame = CGRectMake(0, kPageMenuH, SCREEN_WIDTH, kSubViewH);
        _pageScrollView.delegate = self;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.pageArray.count, 0);
        _pageScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    }
    return _pageScrollView;
}

- (SPPageMenu *)pageMenuView {
    if (!_pageMenuView) {
        _pageMenuView = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kPageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
        [_pageMenuView setItems:self.pageArray selectedItemIndex:0];
        _pageMenuView.delegate = self;
        _pageMenuView.itemTitleFont = [UIFont systemFontOfSize:14];
        _pageMenuView.selectedItemTitleColor = FONT_COLOR_33;
        _pageMenuView.unSelectedItemTitleColor = FONT_COLOR_99;
        _pageMenuView.tracker.backgroundColor = GLOBAL_COLOR;
        _pageMenuView.permutationWay = SPPageMenuPermutationWayScrollAdaptContent;
        _pageMenuView.bridgeScrollView = self.pageScrollView;
        _pageMenuView.dividingLine.backgroundColor = [UIColor whiteColor];
    }
    return _pageMenuView;
}

- (NSArray *)pageArray {
    if (!_pageArray) {
        _pageArray = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6"];
    }
    return _pageArray;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
