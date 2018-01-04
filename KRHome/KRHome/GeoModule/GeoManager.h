//
//  GeoManager.h
//  KRHome
//
//  Created by LX on 2018/1/2.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoManager : NSObject

+ (instancetype)sharedInstance;

- (void)configure:(NSString *)apiKey;

- (void)requestLocationWithReGeocode:(BOOL)withReGeocode completionBlock:(void (^)(NSDictionary *location, NSError *error))locationBlock;

@end
