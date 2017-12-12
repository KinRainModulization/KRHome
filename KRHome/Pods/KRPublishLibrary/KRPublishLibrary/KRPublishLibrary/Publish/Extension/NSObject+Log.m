
#import <UIKit/UIKit.h>
#import "NSObject+Log.h"
#import <objc/runtime.h>
@implementation NSObject (Log)
+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([NSObject class], @selector(description)), class_getInstanceMethod([NSObject class], @selector(pkxDescription)));
}

- (NSString *)pkxDescription{
    Class class = [self class];
  
    NSMutableString *resultStr = [NSMutableString stringWithFormat:@"%@ = {\n",[self pkxDescription]];
    while (class != [NSObject class]) {

        if (![[NSBundle bundleForClass:class] isEqual:[NSBundle mainBundle]])return [self pkxDescription];
        unsigned int count = 0;

        Ivar *vars = class_copyIvarList(class, &count);
        for (int index = 0; index < count; index ++) {
            Ivar var = vars[index];
            const char *name = ivar_getName(var);
            NSString *varName = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:varName];
            
            [resultStr appendFormat:@"\t%@ = %@;\n", varName, value];
        }
        free(vars);
        class = class_getSuperclass(class);
    }
    [resultStr appendString:@"}\n"];
    return resultStr;
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}
@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
