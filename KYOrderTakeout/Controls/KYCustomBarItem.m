//
//  KYCustomBarItem.m
//  University1.0
//
//  Created by 刘成 on 15/11/10.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYCustomBarItem.h"

@implementation KYCustomBarItem

+ (instancetype)backBarWithTarget:(id)target andAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    KYCustomBarItem *item = [[KYCustomBarItem alloc] initWithCustomView:button];
    
    return item;
}

@end
