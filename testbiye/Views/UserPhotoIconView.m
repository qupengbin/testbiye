//
//  BabyIconView.m
//  iBaby-iPhone
//
//  Created by jing jiang on 11/9/12.
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import "UserPhotoIconView.h"
#import "MHFileTool.h"
@implementation RoundImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    if (nil != self.image) {
        [self.image drawInRect:rect contentMode:self.contentMode];
        
    } else {
        [self.defaultImage drawInRect:rect contentMode:self.contentMode];
    }
    
    CGContextRestoreGState(context);
}

- (BOOL)cacheToMemory {
    return NO;
}

@end

@implementation UserPhotoIconView
- (void)initSubViews {
    _disableCover = NO;
    _iconView = [[RoundImageView alloc] initWithFrame:CGRectInset(self.bounds, 2, 2)];
    _iconView.userInteractionEnabled = NO;
    _iconView.backgroundColor = [UIColor clearColor];
    
    _imgvCover = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgvCover.image = [MHFileTool imageWithResourcesName:@"event_bottom_yuan.png"];
    
    _iconlbl = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    _iconlbl.textColor = RGBCOLOR(235, 83, 102);
    _iconlbl.font = [UIFont systemFontOfSize:34];
    _iconlbl.textAlignment = NSTextAlignmentCenter;
    _iconlbl.backgroundColor = [UIColor clearColor];

    
    [self addSubview:_imgvCover];
    [self addSubview:_iconView];
    [self addSubview:_iconlbl];
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDisableCover:(BOOL)disableCover {
    _disableCover = disableCover;
    if (_disableCover) {
        _imgvCover.hidden = YES;
    }
    else {
        _imgvCover.hidden = NO;
    }
}
//- (void)dealloc {
//    [_iconView release]; _iconView = nil;
//    [_imgvCover release]; _imgvCover = nil;
//    [super dealloc];
//}

- (void)awakeFromNib {
    [self initSubViews];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setInset:(NSInteger)inset {
    _iconView.frame = CGRectInset(self.bounds, inset,inset);
}
#pragma mark - touches

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate) {
        [self.delegate userPhotoViewTouched:self];
    }
}

@end