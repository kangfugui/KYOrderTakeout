//
//  KYGoodsListModel.m
//  University1.0
//
//  Created by 刘成 on 15/11/25.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "KYGoodsListModel.h"

@implementation KYGoodsListModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.goodsList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
