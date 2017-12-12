//
//  PublicTools.h
//  Yml
//
//  Created by LX on 2017/9/28.
//  Copyright © 2017年 xi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicTools : NSObject

+ (void)setData:(id)data toUserDefaultsKey:(NSString *)key;
+ (id)getDataFromUserDefaultsWithKey:(NSString *)key;
+ (id)getUserInfo;

+ (BOOL)checkPhone:(NSString *)phone;
+ (BOOL)checkEmoji:(NSString *)string;
+ (BOOL)checkNetwork;

@end
