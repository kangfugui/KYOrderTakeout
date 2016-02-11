//
//  KYProgressAnimationHUD.m
//  test
//
//  Created by 康洋 on 15/12/1.
//  Copyright © 2015年 KangYang. All rights reserved.
//

#import "KYProgressAnimationHUD.h"

@interface KYProgressAnimationHUD ()

@property (strong, nonatomic) UIImageView *animationView;

@end

@implementation KYProgressAnimationHUD

#pragma mark - public method

+ (void)showDefaultAnimation
{
    NSArray<UIImage *> *images = @[[UIImage imageNamed:@"frame_animation_0"],
                                   [UIImage imageNamed:@"frame_animation_1"],
                                   [UIImage imageNamed:@"frame_animation_2"],
                                   [UIImage imageNamed:@"frame_animation_3"]];
    [self showWithImages:images];
}

+ (void)showWithImages:(NSArray<UIImage *> *)images
{
    [[self shareView] _showWithImages:images];
}

+ (void)dismiss
{
    [[self shareView] _stopAnimation];
    
    [UIView animateWithDuration:0.2 animations:^ {
        [self shareView].alpha = 0.0;
    } completion:^(BOOL finished) {
        [[self shareView] removeFromSuperview];
    }];
}

#pragma mark - private method

+ (KYProgressAnimationHUD *)shareView
{
    static KYProgressAnimationHUD *shareView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
        shareView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    });
    
    return shareView;
}

- (void)_showWithImages:(NSArray<UIImage *> *)images
{
    if (!self.superview) {
        NSEnumerator *frontToBackWindows = [[UIApplication sharedApplication].windows reverseObjectEnumerator];
        
        for (UIWindow *window in frontToBackWindows) {
            BOOL windowOnMainScreen = window.screen == [UIScreen mainScreen];
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self];
                break;
            }
        }
    } else {
        [self.superview bringSubviewToFront:self];
    }
    
    self.alpha = 0.0;
    
    if (!self.animationView.superview){
        [self addSubview:self.animationView];
    }
    
    self.animationView.frame = CGRectMake(0, 0, images.firstObject.size.width, images.firstObject.size.height);
    self.animationView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.animationView.animationImages = images;
    self.animationView.animationRepeatCount = NSIntegerMax;
    self.animationView.animationDuration = 0.4;
    
    if (!self.animationView.isAnimating){
        [self.animationView startAnimating];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)_stopAnimation
{
    if (self.animationView.isAnimating) {
        [self.animationView stopAnimating];
    }
}

#pragma mark - getters and setters

- (UIImageView *)animationView
{
    if (!_animationView) {
        _animationView = [[UIImageView alloc] init];
    }
    return _animationView;
}

@end
