//
//  BaseViewController.h
//  PChat
//
//  Created by Jing Jiang-iMohooWork on 3/4/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MHNavViewController.h"

/**
 *  controller 基类，用于通用的操作
 */
@interface BaseViewController : UIViewController<MBProgressHUDDelegate>


@property (retain, nonatomic) MBProgressHUD         *hub;

- (void)showHubInSelfView:(BOOL)reservedNav;
- (void)showInfoTip:(NSString *)tip;
- (void)hideHub;

- (UIBarButtonItem *)backItem;
- (UIBarButtonItem *)rightItem:(UIImage *)image sel:(SEL)sel;
- (UIBarButtonItem *)leftItem:(UIImage *)image sel:(SEL)sel;
- (void)backAction:(id)sender;
@end
