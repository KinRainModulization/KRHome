//
//  KRPicNavsView.h
//  KRHome
//
//  Created by LX on 2017/12/29.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DefaultPicStyle = 1,
    HorizontalLayoutStyle,
    VerticalLayoutStyle,
} CustomLayoutStyle;

@interface KRPicNavsView : UIView

- (void)customViewForStyle:(CustomLayoutStyle)style whitImageSource:(NSArray *)imageSource;

@end
