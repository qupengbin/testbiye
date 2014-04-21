//
//  NSObject+KeyVset.m
//  SQL_Base
//
//  Created by 王尧 on 13-3-12.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "NSObject+KeyVset.h"

@implementation NSObject (KeyVset)
/**
 ** @Desc   TODO:将结果集转换成对象
 ** @author 王尧
 ** @param  (NSDictionary *)rs 数据库中一条纪录的结果集合或者某个数据字典  (NSObject *)object 需要转换的目标对象
 ** @return N/A
 ** @since
 */
+ (void)getObjectFromResultSet:(NSDictionary *)rs object:(NSObject *)object
{
    for (NSString *key in [rs allKeys]) {
        [rs objectEnumerator];
        if ([key isEqualToString:@"id"]) {
            @try {
                id value = [rs objectForKey:key];
                
                if (![value isKindOfClass:[NSString class]]) {
                    [object setValue:[rs objectForKey:key] forKey:@"index"];
                }
                if (!value || [value isEqualToString:@"null"]) {
                    continue;
                }
                [object setValue:[rs objectForKey:key] forKey:@"index"];
            }
            @catch (NSException *exception) {
//                NSLog(@"exception Catched Name:%@",[exception name]);
            }
            @finally {
                
            }
            
        }else{
            @try {
                id value = [rs objectForKey:key];
                
                if (![value isKindOfClass:[NSString class]]) {
                    [object setValue:[rs objectForKey:key] forKey:key];
                }
                
                if (!value || [value isEqualToString:@"null"]) {
                    continue;
                }
                [object setValue:[rs objectForKey:key] forKey:key];
            }
            @catch (NSException *exception) {
//                NSLog(@"exception Catched Name:%@",[exception name]);
            }
            @finally {
                
            }
        }
    }
}
@end
