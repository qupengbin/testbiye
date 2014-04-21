//
//  BabyIconView.h
//  iBaby-iPhone
//
//  Created by jing jiang on 11/9/12.
//  Copyright (c) 2012 imohoo.com. All rights reserved.
//

#import "MHImageView.h"
/*
 * 用户头像圆形icon图片
 *
 */
@interface RoundImageView : MHImageView

@end

@protocol UserPhotoIconDelegate;
@interface UserPhotoIconView : UIView
{
   
}
@property (nonatomic, readonly) UILabel        *iconlbl;
@property (nonatomic, readonly) RoundImageView *iconView;
@property (nonatomic, readonly) UIImageView    *imgvCover;
@property (nonatomic, assign) id<UserPhotoIconDelegate> delegate;
@property (nonatomic, assign) BOOL disableCover;
- (void)setInset:(NSInteger)inset;
@end

@protocol UserPhotoIconDelegate <NSObject>

- (void)userPhotoViewTouched:(UserPhotoIconView *)view;

@end