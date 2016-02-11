//
//  TKRedPacketModel.h
//  University1.0
//
//  Created by yoyo on 15/11/26.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface TKRedPacketModel : JSONModel

@property(nonatomic, copy) NSString *money;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, strong) NSNumber *redPacketId;

//@property(nonatomic, copy) NSString *timeCreate;

@property(nonatomic, copy) NSString *timeUsed;

@property(nonatomic, strong) NSNumber *typeRedpackets;

@property(nonatomic, strong) NSNumber *userId;

@end
