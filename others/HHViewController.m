//
//  HHViewController.m
//  test
//
//  Created by Eric on 12-2-16.
//  Copyright (c) 2012年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#import "HHViewController.h"
#import "LLBomtomCompassMenu.h"
//#import "HHFullScreenViewController.h"
@implementation HHViewController
@synthesize menu;

- (void)dealloc
{
    [menu release];
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
    
    //youkuMenuView = [[HHYoukuMenuView alloc]initWithFrame:[HHYoukuMenuView getFrame]];
    
    self.menu = [[LLBomtomCompassMenu alloc] initAboveOfView:[[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 1)]];
    [menu addButtonsToFirstRoundWithImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"mcartoon"], [NSNull null], [UIImage imageNamed:@"menter"], [NSNull null], [UIImage imageNamed:@"mmovie"], nil]];
    
    [menu addButtonsToSecondRoundWithImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"mmusic"], 
                                             [UIImage imageNamed:@"mmyi"], [UIImage imageNamed:@"mmyi"],
                                             [UIImage imageNamed:@"mmyi"], [UIImage imageNamed:@"mmyi"],
                                             [UIImage imageNamed:@"mmyi"], [UIImage imageNamed:@"mmyi"], nil] bindingToInnerMenuItemByTag:kLLBomtomCompassMenuInnerBtnTag_1];
    
    [menu addButtonsToSecondRoundWithImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"mcartoon"], 
                                             [UIImage imageNamed:@"mcartoon"], [UIImage imageNamed:@"mmyi"],
                                             [UIImage imageNamed:@"mcartoon"], [NSNull null],
                                             [UIImage imageNamed:@"mcartoon"], [UIImage imageNamed:@"mcartoon"], nil] bindingToInnerMenuItemByTag:kLLBomtomCompassMenuInnerBtnTag_3];
    
    [menu addButtonToCenterWithImage:[UIImage imageNamed:@"mvideo"] highlightedImage:nil];
    [self.view addSubview:menu];
}

- (void)gestureActionCallBack:(UIGestureRecognizer *)gesture
{
    [self hideMenu];
}

- (void)showMeun:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.hidden = YES;
    
    [self.menu showOrHideMenu];
}

- (void)hideMenu
{
    [self.menu showOrHideMenu];
    [self performSelector:@selector(showMeunButton) withObject:self afterDelay:1.0];
}

- (void)showMeunButton
{
    UIView *button = [self.view viewWithTag:111];
    button.hidden = NO;
}

@end
