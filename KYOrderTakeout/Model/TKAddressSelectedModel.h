//
//  TKAddressSelectedModel.h
//  University1.0
//
//  Created by yoyo on 15/11/26.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface TKAddressSelectedModel : JSONModel

@property(nonatomic, strong) NSNumber *addrId;

@property(nonatomic, copy) NSString *address;

@property(nonatomic, copy) NSString *mobile;

@property(nonatomic, strong) NSNumber *myAddrId;

@property(nonatomic, copy) NSString *useTime;

@property(nonatomic, strong) NSNumber *userId;

@property(nonatomic, copy) NSString *userName;

@end
