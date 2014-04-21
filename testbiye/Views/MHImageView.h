//
//  MHImageView.h
//  iBaby-iPhone
//
//  Created by jing jiang on 11/1/12.
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHNetworkEngine.h"
#import "UIImageAdditions.h"
#import "UIViewAdditions.h"

@protocol MHImageViewDelegate;
@interface MHImageView : UIView

@property (nonatomic, strong)   NSString      * urlPath;
@property (nonatomic, strong)   UIImage       * defaultImage;
@property (nonatomic, strong)   UIImage       * image;

@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, readonly) BOOL isLoaded;
@property (nonatomic, assign)   BOOL autoresizesToImage;
@property (nonatomic, assign)   BOOL fitWidth;
@property (nonatomic, assign)   BOOL fitHeight;
@property (nonatomic, assign) UIViewContentMode defaultMode;
@property (nonatomic, weak)     id<MHImageViewDelegate>  delegate;
@property (nonatomic, strong)   MHNetworkOperation      *operation;

- (void)unsetImage;
- (void)reload;
- (void)stopLoading;
- (BOOL)shouldNotCache;
@end


@protocol MHImageViewDelegate <NSObject>
@optional

- (void)imageViewDidStartLoad:(MHImageView*)imageView;
- (void)imageViewDidClicked:(MHImageView *)imageView;
- (void)imageView:(MHImageView*)imageView didLoadImage:(UIImage*)image;
- (void)imageView:(MHImageView*)imageView didFailLoadWithError:(NSError*)error;

@end