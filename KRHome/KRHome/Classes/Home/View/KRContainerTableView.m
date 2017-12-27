//
//  KRContainerTableView.m
//  KRHome
//
//  Created by LX on 2017/12/26.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRContainerTableView.h"

@implementation KRContainerTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end
