//
//  LXNetworkTool.m
//  
//
//  Created by 希 on 16/6/28.
//  Copyright © 2016年 xi. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"
#import "PublicTools.h"
#import "NSString+Extension.h"
#import "Macros.h"

#define STATE_SUCCESS 1
#define STATE_FAILURE 0

@interface NetworkTool ()
@property (nonatomic, strong) AFHTTPSessionManager *afnManager;
@end

@implementation NetworkTool

LXSingleton_m(NetworkTool)

- (NSDictionary *)paramsSigned:(NSDictionary *)params {
    NSNumber *time = @([[NSDate date] timeIntervalSince1970]);
    NSMutableDictionary *outputParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:time,@"time", nil];
    if (params) {
        [outputParams addEntriesFromDictionary:params];
    }
    if ([PublicTools getUserInfo]) {
        [outputParams addEntriesFromDictionary:[PublicTools getUserInfo]];
    }
    NSMutableDictionary *paramsToSign = [NSMutableDictionary dictionaryWithDictionary:outputParams];
    [paramsToSign setObject:SIGN_KEY forKey:@"app_key"];
    
    NSArray *arrayOfKeys = [[paramsToSign allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *key1, NSString *key2){
        return [key1 compare:key2];
    }];
    NSString *signStr = @"";
    NSInteger index = 0;
    for (NSString *key in arrayOfKeys) {
        index++;
        NSString *str = [NSString stringWithFormat:@"%@=%@%@",key,paramsToSign[key],index==paramsToSign.count ? @"" : @"&"];
        signStr = [signStr stringByAppendingString:str];
    }
    [outputParams setObject:[signStr md5] forKey:@"sign"];
    return outputParams;
}

- (void)GET:(NSString *)URLString withParameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure {
    [self.afnManager GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id data))success failure:(void (^)(NSError * error))failure {
    MLog(@"%@%@",BASE_URL,URLString);
    NSDictionary *params = [self paramsSigned:parameters];
    [self.afnManager POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if ([responseObject[@"state"] intValue] == STATE_FAILURE) {
            return;
        }
        success(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MLog(@"error=%@",error);
    }];
}

#pragma mark - Setter/Getter

- (AFHTTPSessionManager *)afnManager {
    if (_afnManager == nil) {
        NSURL *baseURL = [NSURL URLWithString:BASE_URL];
        _afnManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
        _afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }
    return _afnManager;
}

@end
