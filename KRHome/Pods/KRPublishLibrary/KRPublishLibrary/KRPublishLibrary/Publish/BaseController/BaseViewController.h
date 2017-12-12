//
//  BaseViewController.h
//  Yml
//
//  Created by LX on 2017/10/9.
//  Copyright © 2017年 xi. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL hiddenNetworkErrorView;

- (void)showEmptyViewWithImageSource:(NSString *)imageStr title:(NSString *)title subTitle:(NSString *)subTitle;

@end
