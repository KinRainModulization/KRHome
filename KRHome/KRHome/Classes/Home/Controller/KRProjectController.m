//
//  KRProjectController.m
//  KRHome
//
//  Created by LX on 2017/12/26.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRProjectController.h"
#import "KRProductCell.h"

#define kSubViewH SCREEN_HEIGHT - NAV_BAR_HEIGHT - kPageMenuH

static const CGFloat kPageMenuH = 50;
static NSString *kProductCellIdentifier = @"kProductCellIdentifier";

@interface KRProjectController ()

@end

@implementation KRProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    MLog(@"viewDidLoad");
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_BAR_HEIGHT-kPageMenuH);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 140;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[KRProductCell class] forCellReuseIdentifier:kProductCellIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageTitleViewToTop) name:@"HomeHeaderViewToTopNotification" object:nil];
    
//    [self.tableView reloadData];
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kSubViewH);
//}

#pragma mark - Notification

- (void)pageTitleViewToTop {
    self.tableView.contentOffset = CGPointZero;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeSubTableViewDidScrollNotification" object:scrollView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProductCellIdentifier forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (cell == nil) {
//        cell = [[KRProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kProductCellIdentifier];
//    }
    return cell;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
