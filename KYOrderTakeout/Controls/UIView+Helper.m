//
//  UIView+Helper.m
//  University1.0
//
//  Created by 刘成 on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

- (void)removeAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
}

@end
