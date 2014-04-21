//
//  MHImageView.m
//  iBaby-iPhone
//
//  Created by jing jiang on 11/1/12.
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import "MHImageView.h"
@interface MHImageView()

@property (nonatomic, strong) UITapGestureRecognizer        *tap;
@end

@implementation MHImageView

#pragma mark - init & dealloc


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _autoresizesToImage = NO;
        _fitHeight = NO;
        _fitWidth = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        self.defaultMode = self.contentMode;
        [self addGestureRecognizer:self.tap];
    }
    return self;
}

- (void)awakeFromNib {
    _autoresizesToImage = NO;
    _fitHeight = NO;
    _fitWidth = NO;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    [self addGestureRecognizer:self.tap];
}


- (void)dealloc {
    [self removeGestureRecognizer:self.tap];
 }

- (void)handleTapGesture:(UIGestureRecognizer *)recognizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidClicked:)]) {
        [self.delegate imageViewDidClicked:self];
    }
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    [super setContentMode:contentMode];
    self.defaultMode = contentMode;
}
#pragma mark - draw

- (void)drawRect:(CGRect)rect
{
    if (nil != _image) {
       
        if (_fitWidth) {
            [self.image drawInRect:rect fitWidth:YES];
        }
        else if(_fitHeight) {
            [self.image drawInRect:rect fitWidth:NO];
        }
        else {
             [self.image drawInRect:rect contentMode:self.contentMode];
        }
        
    } else if(nil != _defaultImage) {
        //CGSize s = _defaultImage.size;
        //if (s.width > self.frame.size.width)
        {
            [self.defaultImage drawInRect:rect contentMode:self.defaultMode];
        }
       // else {
       //     [self.defaultImage drawInRect:rect contentMode:UIViewContentModeCenter];
       // }
    }
    else {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextFillRect(context, rect);
    }
}

#pragma mark - network delegate
- (void)notifyRequestFinished:(MHNetworkOperation *) op
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (nil == op ||op.isCancelled) {
            return ;
        }
        NSData *d = op.responseData;
        UIImage *imgae = [UIImage imageWithData:d];
        if (nil == imgae) {
            
            if ([_delegate respondsToSelector:@selector(imageView:didFailLoadWithError:)]) {
                [_delegate imageView:self didFailLoadWithError:nil];
            }

        }
        
        [self setImage:imgae];
        
        self.operation = nil;
        
        
        if ([_delegate respondsToSelector:@selector(imageView:didLoadImage:)]) {
            [_delegate imageView:self didLoadImage:imgae];
        }
    });
    
}
- (void)notifyRequestFailed:(NSError *)error :(MHNetworkOperation *) op
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.operation = nil;
    if ([_delegate respondsToSelector:@selector(imageView:didFailLoadWithError:)]) {
        [_delegate imageView:self didFailLoadWithError:error];
    }
    });
}

#pragma mark -
- (void)unsetImage
{
    [self stopLoading];
    self.image = nil;
    _urlPath = nil;
}

- (void)setImage:(UIImage*)image {
    if (image != _image) {
        _image = nil;
        _image = image;
        
        
        CGRect frame = self.frame;
        if (_autoresizesToImage) {
            self.width = image.size.width;
            self.height = image.size.height;
            
        } else {
            // Logical flow:
            // If no width or height have been specified, then autoresize to the image.
            if (!frame.size.width && !frame.size.height) {
                self.width = image.size.width;
                self.height = image.size.height;
                
                // If a width was specified, but no height, then resize the image with the correct aspect
                // ratio.
                
            } else if (frame.size.width && !frame.size.height) {
                self.height = floor((image.size.height/image.size.width) * frame.size.width);
                
                // If a height was specified, but no width, then resize the image with the correct aspect
                // ratio.
                
            } else if (frame.size.height && !frame.size.width) {
                self.width = floor((image.size.width/image.size.height) * frame.size.height);
            }
            
            // If both were specified, leave the frame as is.
        }
        
        if (nil == _defaultImage || image != _defaultImage) {
            // Only send the notification if there's no default image or this is a new image.
            
        }
    }
    
    [self setNeedsDisplay];
    
    
}


- (void)setDefaultImage:(UIImage*)theDefaultImage {
    if (_defaultImage != theDefaultImage) {
        _defaultImage = nil;
        _defaultImage = theDefaultImage;
    }
    if (nil == _urlPath || 0 == _urlPath.length) {
        //no url path set yet, so use it as the current image
        self.image = _defaultImage;
    }
}


- (void)setUrlPath:(NSString*)urlPath {
    [self unsetImage];
    // Check for no changes.
    if (nil != _image && nil != _urlPath && [urlPath isEqualToString:_urlPath]) {
        return;
    }
    
    if (![urlPath isKindOfClass:[NSString class]]) {
        return;
    }
    [self stopLoading];
    
    {
        NSString* urlPathCopy = [urlPath copy];

        _urlPath = urlPathCopy;
    }
    
    if (nil == _urlPath || 0 == _urlPath.length) {
        // Setting the url path to an empty/nil path, so let's restore the default image.
        self.image = _defaultImage;
        
    } else {
        [self reload];
    }
}


- (void)reload {
    if (nil == _operation && nil != _urlPath) {
        if ([_delegate respondsToSelector:@selector(imageViewDidStartLoad:)]) {
            [_delegate imageViewDidStartLoad:self];
        }
        
        [self.operation cancel];
        self.operation = nil;
        
        self.operation = (MHNetworkOperation *)[[MHImageNetworkEngin sharedEngine] operationWithURLString:_urlPath];
        if (nil == self.operation) {
            return;
        }
        self.operation.shouldNotCacheResponse = [self shouldNotCache];
        __weak id blockSelf = self;
        __weak MHNetworkOperation *bop = self.operation;

        
        [self.operation addCompletionHandler:^(MKNetworkOperation *completedOperation){
            [blockSelf notifyRequestFinished:bop];
        }
                                errorHandler:^(MKNetworkOperation* completedOperation,NSError *error) {
                        [blockSelf notifyRequestFailed:error :bop];
                    }];
        
         [[MHImageNetworkEngin sharedEngine] enqueueOperation:self.operation forceReload:NO];
        
    }
}
- (BOOL)shouldNotCache {
    return NO;
}

- (void)stopLoading {
    [self.operation cancel];
    self.operation = nil;
}



- (BOOL)isLoading {
    return !!_operation;
}


- (BOOL)isLoaded {
    return nil != _image && _image != _defaultImage;
}
/*
#pragma mark - touched

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidClicked:)]) {
        [self.delegate imageViewDidClicked:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesCancelled");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
}
 */
@end
