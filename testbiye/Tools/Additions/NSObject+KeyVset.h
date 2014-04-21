//
//  NSObject+KeyVset.h
//  SQL_Base
//
//  Created by 王尧 on 13-3-12.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyVset)
/**
 ** @Desc   TODO:将结果集转换成对象
 ** @author 王尧
 ** @param  (FMResultSet *)rs 数据库中一条纪录的结果集合 (NSObject *)object 需要转换的对象
 ** @return N/A
 ** @since  1.0
 */
+ (void)getObjectFromResultSet:(NSDictionary *)rs object:(NSObject *)object;
@end
