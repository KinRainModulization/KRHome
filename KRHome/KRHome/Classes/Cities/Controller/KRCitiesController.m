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

static NSString *kCityCellIdentifier = @"kCityCellIdentifier";
static const CGFloat kCitiesHeaderHeight = 148;

@interface KRCitiesController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) UITableView *citiesTableView;
@property (nonatomic, strong) KRCitiesHeaderView *citiesHeaderView;
@end

@interface KRCitiesController ()

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
}

#pragma mark - Table view data source

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
    }
    return _citiesHeaderView;
}
@end
