//
//  MHNetworkEngine.h
//  iBaby-iPhone
//
//  Created by jing jiang on 10/11/12.
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "MHNetworkOperation.h"

@interface MHNetworkEngine : MKNetworkEngine

+ (MHNetworkEngine*)sharedEngine;
@property (nonatomic, assign) NetworkStatus netStatus;

@end

@interface MHImageNetworkEngin : MKNetworkEngine
+ (MHImageNetworkEngin *)sharedEngine;
@end