//
//  MHNetworkOperation.h
//  iBaby-iPhone
//
//  Created by jing jiang on 11/1/12.
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import "MKNetworkOperation.h"
#import "MHUrl.h"

@interface MHNetworkOperation : MKNetworkOperation

@property (nonatomic, assign) OpeartionRequestTag tag;
@property (nonatomic, strong) NSString            *uuid;
@property (nonatomic, assign) NSTimeInterval     requestTime;
@property (nonatomic, assign) NSTimeInterval     otherTime;
@end
