//
//  HHViewController.h
//  test
//
//  Created by Eric on 12-2-16.
//  Copyright (c) 2012年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HHFullScreenViewController.h"
#import "HHYoukuMenuView.h"
@interface HHViewController : UIViewController
{
    HHYoukuMenuView *youkuMenuView;
}
@property (nonatomic, retain) HHYoukuMenuView *youkuMenuView;
@end
