//
//  KRPicNavsView.m
//  KRHome
//
//  Created by LX on 2017/12/29.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRPicNavsView.h"

@implementation KRPicNavsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)customViewForStyle:(CustomLayoutStyle)style whitImageSource:(NSArray *)imageSource {
    if (style == DefaultPicStyle) {
        CGFloat imageW = SCREEN_WIDTH * 0.5 - 0.5;
        CGFloat imageH = self.height * 0.5 - 0.5;
        CGFloat margin = 1;
        for (int i = 0; i < 4; i++) {
            NSInteger row = i / 2;
            NSInteger column = i % 2;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(row*(imageW+margin), column*(imageH+margin), imageW, imageH)];
            imageView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:imageView];
        }
    }
    else if (style == HorizontalLayoutStyle) {
        
    }
}

@end
