//
//  NSString+Base64.m
//  CJSXY
//
//  Created by 王尧 on 13-10-17.
//  Copyright (c) 2013年 沈桢. All rights reserved.
//

#import "NSString+Base64.h"
#import "GTMBase64.h"

@implementation NSString (Base64)

- (NSString *)encodeToBase64{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *contentBaseStr = [GTMBase64 stringByEncodingData:data];
    return contentBaseStr;
}

- (NSString *)decodeBase64ToNormalString{
    NSData *data = [GTMBase64 decodeString:self];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

@end
