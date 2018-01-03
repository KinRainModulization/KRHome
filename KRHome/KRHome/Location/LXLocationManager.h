//
//  LXLocation.h
//  KRHome
//
//  Created by LX on 2018/1/2.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXLocationManager : NSObject

- (void)beginUpdatingLocation;

- (void)requestLocationWithCompletionBlock:(void (^)(NSDictionary *location))completionBlock;

@end
