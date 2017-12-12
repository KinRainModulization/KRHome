//
//  NSString+Extension.m
//  Yml
//
//  Created by LX on 2017/9/30.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "NSString+Extension.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    NSInteger length = CC_MD5_DIGEST_LENGTH;
    unsigned char result[length];
    
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:length];
    
    for(int i = 0; i < length; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    
    return [ret lowercaseString];
    
}
@end
