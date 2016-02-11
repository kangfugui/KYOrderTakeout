//
//  KYGoodsModel.m
//  University1.0
//
//  Created by 刘成 on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYGoodsModel.h"

@implementation KYGoodsModel

- (NSDictionary *)postDictionary
{
    return @{@"goodsId" : @(self.goodsId),
             @"goodsName" : self.goodsName,
             @"price" : [NSString stringWithFormat:@"%.1f",self.priceDiscount],
             @"nums" : @(self.buyCount)};
}

@end
