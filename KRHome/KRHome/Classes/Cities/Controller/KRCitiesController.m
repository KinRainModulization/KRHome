//
//  KRCitiesController.m
//  KRHome
//
//  Created by LX on 2018/1/3.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRCitiesController.h"
#import "KRCityCell.h"
#import "KRCitiesHeaderView.h"
#import "GeoManager.h"

#define kCurrentCityKey @"CurrentCity"

static NSString *kCityCellIdentifier = @"kCityCellIdentifier";
static const CGFloat kCitiesHeaderHeight = 148;

@interface KRCitiesController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) UITableView *citiesTableView;
@property (nonatomic, strong) KRCitiesHeaderView *citiesHeaderView;
@property (nonatomic, assign) LocationStatus locationStatus;
@property (nonatomic, strong) NSDictionary *currentCity;
@property (nonatomic, strong) NSDictionary *locatedCity;

@end

@implementation KRCitiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cities = @[
                    @{@"head":@"B",@"cities":@[@{@"city":@"北京",@"cityCode":@"100010"}]},
                    @{@"head":@"G",@"cities":@[
                                                @{@"city":@"贵阳",@"cityCode":@"300010"},
                                                @{@"city":@"广州",@"cityCode":@"400010"},
                                                ]},
                    @{@"head":@"S",@"cities":@[@{@"city":@"沈阳",@"cityCode":@"800010"},]},
                    ];
    
    self.title = @"选择服务城市";
    
    [self.view addSubview:self.citiesTableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self locate];
}

- (void)locate {
    self.locationStatus = LocationCityStatusDefault;

    [[GeoManager sharedInstance] requestLocationWithReGeocode:YES completionBlock:^(NSDictionary *location, NSError *error) {
        if (error) {
            if ([error.userInfo[@"info"] isEqualToString:@"AuthorizationStatusDenied"]) {//不允许定位
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您还未开启定位" message:@"美丽从定位开始，请在设置>轻雨>定位服务中开启" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            self.locationStatus = LocationCityStatusFailure;
            return;
        }
        
        NSString *locatedCity = [location[@"city"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
        NSDictionary *servingCity = nil;
        for (NSDictionary *citySectionData in self.cities) {
            for (NSDictionary *city in citySectionData[@"cities"]) {
                if ([locatedCity isEqualToString:city[@"city"]]) {
                    servingCity = city;
                }
            }
        }
        
        self.locatedCity = servingCity ? servingCity : @{@"city":location[@"city"],@"cityCode":location[@"adcode"]};
        
        if (servingCity) {
            self.locationStatus = LocationCityStatusServing;
            if (![self.currentCity[@"city"] isEqualToString:servingCity[@"city"]]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self reloadHomeDataWithCity:servingCity];
                });
            }
        }
        else {
            self.locationStatus = LocationCityStatusNotServing;
        }
    }];
}

- (void)reloadHomeDataWithCity:(NSDictionary *)city {
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:HOME_CHANGE_CITY object:nil userInfo:city];
}

#pragma mark - Action

- (void)handleLocateCityClick {
    if (_locationStatus == LocationCityStatusFailure) {
        [self locate];
    }
    else if (_locationStatus == LocationCityStatusServing) {
        [self reloadHomeDataWithCity:self.locatedCity];
    }
    
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionData = self.cities[indexPath.section][@"cities"];
    [self reloadHomeDataWithCity:sectionData[indexPath.row]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cities.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionData = self.cities[section][@"cities"];
    return sectionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRCityCell *cell = [tableView dequeueReusableCellWithIdentifier:kCityCellIdentifier forIndexPath:indexPath];
    NSArray *sectionData = self.cities[indexPath.section][@"cities"];
    cell.city = sectionData[indexPath.row][@"city"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    if (section == 0) {
        [contentView addSubview:self.citiesHeaderView];
        WEAK_SELF;
        self.citiesHeaderView.locateCityBlock = ^{
            [weakSelf handleLocateCityClick];
        };
    }
    UILabel *cityHeaderLabel = [UILabel labelWithText:self.cities[section][@"head"] textColor:GLOBAL_COLOR fontSize:16];
    cityHeaderLabel.font = [UIFont boldSystemFontOfSize:16];
    cityHeaderLabel.frame = CGRectMake(12, section == 0 ? kCitiesHeaderHeight : 0, SCREEN_WIDTH-12, 47);
    [contentView addSubview:cityHeaderLabel];
    return contentView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? kCitiesHeaderHeight+47 : 47;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - Setter/Getter

- (void)setLocationStatus:(LocationStatus)locationStatus {
    _locationStatus = locationStatus;
    [self.citiesHeaderView locateCity:_locatedCity ? _locatedCity[@"city"] : nil withLocationStatus:locationStatus];
}

- (NSDictionary *)currentCity {
    if (!_currentCity) {
        _currentCity = [PublicTools getDataFromUserDefaultsWithKey:kCurrentCityKey];
    }
    return _currentCity;
}

- (UITableView *)citiesTableView {
    if (!_citiesTableView) {
        _citiesTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _citiesTableView.delegate = self;
        _citiesTableView.dataSource = self;
        _citiesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _citiesTableView.rowHeight = 40;
        _citiesTableView.backgroundColor = [UIColor whiteColor];
        [_citiesTableView registerClass:[KRCityCell class] forCellReuseIdentifier:kCityCellIdentifier];
    }
    return _citiesTableView;
}

- (KRCitiesHeaderView *)citiesHeaderView {
    if (!_citiesHeaderView) {
        _citiesHeaderView = [[KRCitiesHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kCitiesHeaderHeight)];
        _citiesHeaderView.currentCity = self.currentCity[@"city"];
    }
    return _citiesHeaderView;
}
@end
