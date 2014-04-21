//
//  NSString+Base64.h
//  CJSXY
//
//  Created by 王尧 on 13-10-17.
//  Copyright (c) 2013年 沈桢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

- (NSString *)encodeToBase64;
- (NSString *)decodeBase64ToNormalString;

@end
