//
//  KRProjectController.m
//  KRHome
//
//  Created by LX on 2017/12/26.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRProjectController.h"

#define kSubViewH SCREEN_HEIGHT - NAV_BAR_HEIGHT - kPageMenuH

static const CGFloat kPageMenuH = 50;
static NSString *kProjectCellIdentifier = @"kProjectCellIdentifier";

@interface KRProjectController ()

@end

@implementation KRProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    MLog(@"viewDidLoad");
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_BAR_HEIGHT-kPageMenuH);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kProjectCellIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageTitleViewToTop) name:@"HomeHeaderViewToTopNotification" object:nil];
    
//    [self.tableView reloadData];
    
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProjectCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kProjectCellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
