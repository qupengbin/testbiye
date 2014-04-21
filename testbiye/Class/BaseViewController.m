//
//  BaseViewController.m
//  PChat
//
//  Created by Jing Jiang-iMohooWork on 3/4/14.
//  Copyright (c) 2014 imohoo.com. All rights reserved.
//

#import "BaseViewController.h"
#import "MHDeviceTool.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed =  YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	if ([MHDeviceTool isiOS7]) {
        self.automaticallyAdjustsScrollViewInsets = NO; //automaticallyAdjustsScrollViewInsets，当设置为YES时（默认YES），如果视图里面存在唯一一个UIScrollView或其子类View，那么它会自动设置相应的内边距，这样可以让scroll占据整个视图，又不会让导航栏遮盖，如以下例子：
        self.extendedLayoutIncludesOpaqueBars = NO; //这个属性指定了当Bar使用了不透明图片时，视图是否延伸至Bar所在区域，默认值时NO。
        //所以我们如果自定义了导航栏的背景图片，那么视图会从导航栏以下开始，不会延伸到导航栏区域。
        self.edgesForExtendedLayout = UIRectEdgeNone; //edgesForExtendedLayout是一个类型为UIExtendedEdge的属性，指定边缘要延伸的方向。
        //因为iOS7鼓励全屏布局，它的默认值很自然地是UIRectEdgeAll，四周边缘均延伸，就是说，如果即使视图中上有navigationBar，下有tabBar，那么视图仍会延伸覆盖到四周的区域。
        self.modalPresentationCapturesStatusBarAppearance = NO;

        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;


        [self setNeedsStatusBarAppearanceUpdate];
        
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
        
        //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        //self.navigationController.interactivePopGestureRecognizer.delegate = self;
    } else {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)showHubInSelfView:(BOOL)reservedNav
{
    if (self.hub) {
        [self.hub removeFromSuperview];
        self.hub = nil;
    }
    self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES reservedNav:reservedNav];
    self.hub.removeFromSuperViewOnHide = YES;
    if([[UIScreen mainScreen]bounds].size.height == 568) {
    }
    else {
        self.hub.yOffset -= 20;
    }
}

- (void)showInfoTip:(NSString *)tip {
    [self showHubInSelfView:NO];
    self.hub.mode = MBProgressHUDModeText;
    self.hub.labelText = tip;
    [self.hub hide:NO afterDelay:1.5];
}
- (void)hideHub {
    [self.hub removeFromSuperview];
    self.hub = nil;
}

/*
- (NSString *)errorResponsText:(NSError *)error
{
    if ([error code] < 0) {
        return @"网络不佳，请稍后重试";
    }
    else if([error code] == kResultErrorNeedRelogin)
    {
        return @"授权失败需要重新登陆";
    }
    
    NSString *errorText = [[error userInfo] objectForKey:kResultErrorDesKey];
    if (nil == errorText) {
        errorText = @"服务端接口未描述的错误";
    }
    
    return errorText;
}
*/

- (BOOL)isReloginError:(NSError *)error
{
    return YES;
}

- (UIBarButtonItem *)backItem {
     
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"comm_back.png"]  ;
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    //backBtn.backgroundColor = [UIColor redColor];
    //backBtn.contentMode = UIViewContentModeLeft;
    backBtn.frame = CGRectMake(0, 0,
                               40,
                               40);
    if ([MHDeviceTool isiOS7]) {
        //ios7下 位置向左移10像素
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                   -30,
                                                   0,
                                                   0);
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    
    
    
    
    
    self.navigationItem.leftBarButtonItem  = backButton;
    
    return backButton;
}

- (UIBarButtonItem *)leftItem:(UIImage *)image sel:(SEL)sel {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    //rightButton.backgroundColor = [UIColor redColor];
    leftButton.frame = CGRectMake(0, 0,
                                   40,
                                   40);

    if ([MHDeviceTool isiOS7]) {
        //ios7下 位置向左移10像素
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                       -30,
                                                       0,
                                                       0);
    }

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton] ;

    /*
     if ([MHDeviceTool isiOS7]) {
     //ios7下 位置向左移10像素
     backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
     }
     */

    self.navigationItem.leftBarButtonItem  = leftItem;

    return leftItem;
}


- (UIBarButtonItem *)rightItem:(UIImage *)image sel:(SEL)sel {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    //rightButton.backgroundColor = [UIColor redColor];
     rightButton.frame = CGRectMake(0, 0,
                               40,
                               40);
 
    if ([MHDeviceTool isiOS7]) {
        //ios7下 位置向左移10像素
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                       0,
                                                       0,
                                                       -30);
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton] ;
    
    /*
     if ([MHDeviceTool isiOS7]) {
     //ios7下 位置向左移10像素
     backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
     }
     */
    
    self.navigationItem.rightBarButtonItem  = rightItem;
    
    return rightItem;
}
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -MBProgressHUD delegate

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    self.hub = nil;
}

@end
