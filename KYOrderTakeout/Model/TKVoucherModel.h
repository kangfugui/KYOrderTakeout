//
//  TKVoucherModel.h
//  University1.0
//
//  Created by yoyo on 15/11/26.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface TKVoucherModel : JSONModel

@property(nonatomic, copy) NSString *money;
@property(nonatomic, strong) NSNumber *moneyLimited;

@property(nonatomic, strong) NSNumber *myVoucherId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSNumber *sellerId;
@property(nonatomic, copy) NSString *timeCreate;
@property(nonatomic, copy) NSString *timeEnd;
@property(nonatomic, copy) NSString *timeUsed;

@property(nonatomic, strong)NSNumber *typeVoucher;

@property(nonatomic, strong) NSNumber *userId;
@property(nonatomic, strong) NSNumber *voucherId;

@end
