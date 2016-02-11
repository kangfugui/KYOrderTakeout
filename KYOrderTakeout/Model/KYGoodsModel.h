//
//  KYGoodsModel.h
//  University1.0
//
//  Created by 刘成 on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface KYGoodsModel : JSONModel

@property (assign, nonatomic) NSInteger goodsId;
@property (copy, nonatomic) NSString *goodsName;
@property (assign, nonatomic) NSInteger offShelve;
@property (copy, nonatomic) NSString *picIcon;
@property (assign, nonatomic) CGFloat priceDiscount;    //折扣价
@property (assign, nonatomic) CGFloat priceSelling;     //售价
@property (assign, nonatomic) NSInteger sellerId;       //商家ID
@property (assign, nonatomic) NSInteger sortId;         //
@property (copy, nonatomic) NSString *sortName;         //种类名称
@property (copy, nonatomic) NSString *textKey;          //
@property (assign, nonatomic) NSInteger volumeSales;    //个数

//以下属性只在客户端使用，与服务端返回数据无关
@property (assign, nonatomic) NSInteger buyCount;       //个数

- (NSDictionary *)postDictionary;

@end
