//
//  TKOrderConfirmationModel.h
//  University1.0
//
//  Created by yoyo on 15/11/26.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"
#import "TKRedPacketModel.h"
#import "TKVoucherModel.h"

@class TKVoucherModel,TKRedPacketModel;
@interface TKOrderConfirmationModel : JSONModel

@property(nonatomic, strong) NSNumber *addrId;

@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *mobile;
@property(nonatomic, strong) NSNumber *myAddrId;
@property(nonatomic, strong) TKRedPacketModel *redPacket;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, strong) TKVoucherModel *voucher;

@end
