//
//  HHViewController.m
//  test
//
//  Created by Eric on 12-2-16.
//  Copyright (c) 2012年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#import "HHViewController.h"
//#import "HHFullScreenViewController.h"
@implementation HHViewController
@synthesize youkuMenuView;

- (void)dealloc
{
    [youkuMenuView release];
    [super dealloc]; 
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    UIView *gestureView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:gestureView];
    UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureActionCallBack:)];
    gestureRec.numberOfTapsRequired = 1;
    gestureRec.numberOfTouchesRequired = 1;
    [gestureView addGestureRecognizer:gestureRec];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"hidemenu.png"];
    button.frame = CGRectMake(0.0,self.view.frame.size.height - 18, 320,17);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMeun:) forControlEvents:UIControlEventTouchUpInside];

    button.tag = 111;
    [self.view addSubview:button];
    button.hidden = YES;
    
    youkuMenuView = [[HHYoukuMenuView alloc]initWithFrame:[HHYoukuMenuView getFrame]];
    [self.view addSubview:youkuMenuView];
    
    [youkuMenuView release];
    
}

- (void)gestureActionCallBack:(UIGestureRecognizer *)gesture
{
    [self hideMenu];
}

- (void)showMeun:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.hidden = YES;
    
    [youkuMenuView showOrHideMenu];
}

- (void)hideMenu
{
    [youkuMenuView showOrHideMenu];
    [self performSelector:@selector(showMeunButton) withObject:self afterDelay:1.0];
}

- (void)showMeunButton
{
    UIView *button = [self.view viewWithTag:111];
    button.hidden = NO;
}

@end