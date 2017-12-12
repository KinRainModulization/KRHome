//
//  LXNetworkErrorView.h
//  Yml
//
//  Created by LX on 2017/10/10.
//  Copyright © 2017年 xi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXNetworkErrorView : UIView

@property (nonatomic, copy) void (^reloadDataBlock)(void);

@property (nonatomic, copy) void (^networkSolutionBlock)(void);

@end
