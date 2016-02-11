//
//  KYProgressAnimationHUD.h
//  test
//
//  Created by 康洋 on 15/12/1.
//  Copyright © 2015年 KangYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYProgressAnimationHUD : UIView

+ (void)showDefaultAnimation;
+ (void)showWithImages:(NSArray<UIImage *> *)images;
+ (void)dismiss;

@end
