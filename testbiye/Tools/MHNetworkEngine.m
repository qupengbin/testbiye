//
//  MHNetworkEngine.m
//  iBaby-iPhone
//
//  Created by jing jiang on 10/11/12.
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import "MHNetworkEngine.h"
#import "MHNetworkOperation.h"

#define MHNETWORKCACHE_DIRECTORY        @"MHCache"
#define MHNETWORKIMAGECACHE_DIRECTORY   @"MHImageCache"

@implementation MHNetworkEngine

+ (MHNetworkEngine*)sharedEngine
{
    static MHNetworkEngine *_sharedEngine = nil;
    if (nil == _sharedEngine) {
         static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedEngine = [[MHNetworkEngine alloc] initWithHostName:kBaseURL];
            [_sharedEngine registerOperationSubclass:[MHNetworkOperation class]];
            [_sharedEngine useCache];
            
            __weak MHNetworkEngine *weakE = _sharedEngine;
            
            
            
            _sharedEngine.reachabilityChangedHandler = ^(NetworkStatus ns) {
                weakE.netStatus = ns;
            };
        });
    }
    return _sharedEngine;
}
-(NSString*) cacheDirectoryName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:MHNETWORKCACHE_DIRECTORY];
    return cacheDirectoryName;
}
-(int) cacheMemoryCost {
    
    return 0;
}
@end


@implementation MHImageNetworkEngin


+ (MHImageNetworkEngin*)sharedEngine
{
    static MHImageNetworkEngin *_sharedEngine = nil;
    if (nil == _sharedEngine) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedEngine = [[MHImageNetworkEngin alloc] initWithHostName:kBaseURL];
            [_sharedEngine registerOperationSubclass:[MHNetworkOperation class]];
             [_sharedEngine useCache];
        });
    }
    return _sharedEngine;
}
-(NSString*) cacheDirectoryName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:MHNETWORKIMAGECACHE_DIRECTORY];
    return cacheDirectoryName;
}

-(int) cacheMemoryCost {
    
    return 3;
}
@end