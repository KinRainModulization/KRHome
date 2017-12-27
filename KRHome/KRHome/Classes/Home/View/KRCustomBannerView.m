//
//  KRCustomBannerView.m
//  KRHome
//
//  Created by LX on 2017/12/27.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRCustomBannerView.h"

@implementation KRCustomBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
    }
    
    
    return self;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = self.bounds;
}

@end
