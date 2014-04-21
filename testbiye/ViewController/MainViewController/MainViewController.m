//
//  MainViewController.m
//  testbiye
//
//  Created by qupengbin on 14-4-16.
//  Copyright (c) 2014年 qupengbin. All rights reserved.
//

#import "MainViewController.h"
#import "BuyViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()
{
    UIScrollView *_scrollView;
    UIButton *_touchBtn;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"MainView";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    _touchBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    _touchBtn.backgroundColor = [UIColor blackColor];
    _touchBtn.alpha = 0.3f;
    [_touchBtn addTarget:self action:@selector(touchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_touchBtn];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIButtonAction
- (void)touchBtnAction:(id)sender
{
    
}

- (void)buttonAction:(id)sender
{
    BuyViewController *buy = [[BuyViewController alloc] init];
    [self.navigationController pushViewController:buy animated:YES];
}

@end
