//
//  LLBomtomCompassMenu.m
//
//  Created by ganxiangle on 12-3-12.
//  Copyright (c) 2012年 ganxiangle@gmail.com. All rights reserved.
//

#import "LLBomtomCompassMenu.h"
#import <QuartzCore/QuartzCore.h>

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
#define VIEW_HEIGHT 148.0
#define VIEW_WEIGHT 296.0


@implementation LLBomtomCompassMenu
@synthesize delegate;

- (id)init
{
    self = [self initWithFrame: CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT)];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        _isRotationViewShow = YES;
        _isMenuShow = YES;
        [self initView];
    }
    return self;
}

- (void)dealloc
{
    [_innerView release];
    [_rotationView release];
    [super dealloc];
}

- (void)initView
{
    // The top large image view
    UIImageView *rotationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_large"]];
    rotationImageView.frame = CGRectMake(0.0, 0.0, VIEW_WEIGHT, 135);   
    rotationImageView.userInteractionEnabled = YES;
    [rotationImageView setUserInteractionEnabled:YES];
    
    _rotationView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT/2.0, VIEW_WEIGHT, VIEW_HEIGHT)];
    [_rotationView addSubview:rotationImageView];
    _rotationView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    [self addSubview:_rotationView];
    [_rotationView release];
    
    // The inner image view
    _innerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu_inner"]];
    _innerView.frame = CGRectMake(53.0, 49.0, 191.0, 86.0);
    [_innerView setUserInteractionEnabled:YES];
    [self addSubview:_innerView];
}

- (CGRect)getShowFrame
{
    return CGRectMake( (320.0 - VIEW_WEIGHT)/2.0, 460.0 - VIEW_HEIGHT, VIEW_WEIGHT, VIEW_HEIGHT);
}

- (CGRect)getHideFrame
{
    return CGRectMake( (320.0 - VIEW_WEIGHT)/2.0, 460.0, VIEW_WEIGHT, VIEW_HEIGHT);
}

- (void)addButtonsToFirstRoundWithImages:(NSArray *)images 
                       highlightedImages:(NSArray *)highlightedImages
{
    CGRect rects[5];
    rects[0] = CGRectMake(13, 55,  25, 25);
    rects[1] = CGRectMake(37, 22,  25, 25);
    rects[2] = CGRectMake(83, 6,   25, 25);
    rects[3] = CGRectMake(130, 22, 25, 25);
    rects[4] = CGRectMake(154, 55, 25, 25);    
    
    for (NSInteger i = 0; i < [images count] && i < 5; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = rects[i];
        [btn setShowsTouchWhenHighlighted:YES];
        btn.tag = kLLBomtomCompassMenuInnerBtnTag_1 + i;
        [btn addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[images objectAtIndex:i] isKindOfClass:[UIImage class]]) {
            [btn setImage:[images objectAtIndex:i] forState:UIControlStateNormal];
            [_innerView addSubview:btn];
            if (highlightedImages && [[highlightedImages objectAtIndex:i] isKindOfClass:[UIImage class]]) {
                [btn setImage:[highlightedImages objectAtIndex:i] forState:UIControlStateHighlighted];
            }
        }
    }
}

- (void)addButtonsToFirstRoundWithImages:(NSArray *)images
{
    [self addButtonsToFirstRoundWithImages:images highlightedImages:nil];
}

- (void)addButtonsToSecondRoundWithImages:(NSArray *)images highlightedImages:(NSArray *)highlightedImages
{
    CGRect rects[7];
    rects[0] = CGRectMake(14, 99,  25, 25);
    rects[1] = CGRectMake(39, 55,  25, 25);
    rects[2] = CGRectMake(80, 24,  25, 25);
    rects[3] = CGRectMake(136, 11, 25, 25);
    rects[4] = CGRectMake(191, 24, 25, 25);
    rects[5] = CGRectMake(231, 55, 25, 25);
    rects[6] = CGRectMake(254, 99, 25, 25);

    for (NSInteger i = 0; i < [images count] && i < 7; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = rects[i];
        [btn setShowsTouchWhenHighlighted:YES];
        btn.tag = kLLBomtomCompassMenuOutterBtnTag_1 + i;
        [btn addTarget:self 
                action:@selector(menuButtonClicked:) 
      forControlEvents:UIControlEventTouchUpInside];
        
        if ([[images objectAtIndex:i] isKindOfClass:[UIImage class]]) {
            [btn setImage:[images objectAtIndex:i] forState:UIControlStateNormal];
            [_rotationView addSubview:btn];
            
            if (highlightedImages && [[highlightedImages objectAtIndex:i] isKindOfClass:[UIImage class]]) {
                [btn setImage:[highlightedImages objectAtIndex:i] forState:UIControlStateHighlighted];
            }
        }
    }
}

- (void)addButtonsToSecondRoundWithImages:(NSArray *)images 
{
    [self addButtonsToSecondRoundWithImages:images highlightedImages:nil];
}

- (void)addButtonToCenterWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(83, 55, 25, 25);
    [btn setShowsTouchWhenHighlighted:YES];
    btn.tag = kLLBomtomCompassMenuCenterBtnTag;
    [btn addTarget:self 
            action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
        [_innerView addSubview:btn];
        
        if (highlightedImage) {
            [btn setImage:highlightedImage forState:UIControlStateHighlighted];
        }
    }    
}

- (void)menuButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    /* when the center button clicked */
    if (button.tag == kLLBomtomCompassMenuCenterBtnTag) {
        button.userInteractionEnabled = NO;
        [self rotationAnimation];
    } 

    if (self.delegate && [self.delegate respondsToSelector:@selector(dd)]) {
        [self.delegate LLBomtomCompassMenu:self buttonClickedWithTag:button.tag];
    }
    
    NSLog(@"menu tag %d clicked", button.tag);
}

/* start the outter round rotation */
- (void)rotationAnimation
{
    [UIView beginAnimations:@"present-countdown" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(rotationAnimationDidStop)];
    
    CGFloat angle = _isRotationViewShow ? 180.0 : 0.0;
    _rotationView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(angle), 
                                                              0.0, 0.0, 1.0);
    
    [self rotationAnimationWillStart];
    [UIView commitAnimations];
}

/* When the rotation start, notify the delegate using this method */
- (void)rotationAnimationWillStart
{
    if (_isRotationViewShow && 
        self.delegate && 
        [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuWillHideRotationAnimation:)]) 
    {        
        [self.delegate LLBomtomCompassMenuWillHideRotationAnimation:self];
        
    } else if (!_isRotationViewShow && 
               self.delegate && 
               [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuWillShowRotationAnimation:)] ) 
    {        
        [self.delegate LLBomtomCompassMenuWillShowRotationAnimation:self];
    }
}

/* When the rotation end, notify the delegate using this method */
- (void)rotationAnimationDidStop
{
    UIButton *menuButton =  (UIButton *)[self viewWithTag:kLLBomtomCompassMenuCenterBtnTag];
    menuButton.userInteractionEnabled = YES;
    
    if (_isRotationViewShow && 
        self.delegate && 
        [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuDidHideRotationAnimation:)]) 
    {        
        [self.delegate LLBomtomCompassMenuDidHideRotationAnimation:self];
        
    } else if (!_isRotationViewShow && 
               self.delegate && 
               [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuDidShowRotationAnimation:)] ) 
    {        
        [self.delegate LLBomtomCompassMenuDidShowRotationAnimation:self];
    }
    
    
    _isRotationViewShow = !_isRotationViewShow;
}

/* show or hide the menu in up and down direction */
- (void)showOrHideMenu
{
    [UIView beginAnimations:@"present-countdown" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(showOrHideMenuAnimationDidStop)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (_isMenuShow) 
    {
        self.frame = [self getHideFrame];
    }
    else
    {
        self.frame = [self getShowFrame];
    }
    [self showOrHideMenuAnimationWillStart];
    [UIView commitAnimations];
}

/* notify the delegate when the show/hide annimation will be start */
- (void)showOrHideMenuAnimationWillStart
{
    if (_isMenuShow && 
        self.delegate && 
        [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuWillHide:)]) {   
        
        [self.delegate LLBomtomCompassMenuWillHide:self];
        
    } else if (!_isMenuShow && 
               self.delegate && 
               [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuWillShow:)]) {
        [self.delegate LLBomtomCompassMenuWillShow:self];
    }
}

/* notify the delegate when the show/hide annimation will be ended */
- (void)showOrHideMenuAnimationDidStop
{    
    if (_isMenuShow && 
        self.delegate && 
        [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuDidHide:)]) {   
        
        [self.delegate LLBomtomCompassMenuDidHide:self];
        
    } else if (!_isMenuShow && 
               self.delegate && 
               [self.delegate respondsToSelector:@selector(LLBomtomCompassMenuDidShow:)]) {
        [self.delegate LLBomtomCompassMenuDidShow:self];
    }
    
    _isMenuShow = !_isMenuShow;
}

- (BOOL)isMenuShow
{
    return _isMenuShow;
}

@end

