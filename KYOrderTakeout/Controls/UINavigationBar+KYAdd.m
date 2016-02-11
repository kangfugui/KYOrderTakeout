//
//  UINavigationBar+KYAdd.m
//  KYOrderTakeout
//
//  Created by KangYang on 16/2/4.
//  Copyright © 2016年 KangYang. All rights reserved.
//

#import "UINavigationBar+KYAdd.h"

@implementation UINavigationBar (KYAdd)

- (void)customNavigationBar
{
    self.barTintColor = [UIColor colorWithRed:0.965 green:0.792 blue:0.271 alpha:1];
    self.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSFontAttributeName: [UIFont boldSystemFontOfSize:18]};
}

@end
