//
//  KYGoodsListModel.h
//  University1.0
//
//  Created by 刘成 on 15/11/25.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KYGoodsModel;

@interface KYGoodsListModel : NSObject

@property (assign, nonatomic) NSInteger sortId;
@property (copy, nonatomic) NSString *sortName;
@property (strong, nonatomic) NSMutableArray<KYGoodsModel *> *goodsList;

@end
