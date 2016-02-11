//
//  TKAddAddressViewModel.h
//  University1.0
//
//  Created by yoyo on 15/11/27.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface TKAddAddressViewModel : JSONModel

@property(nonatomic, strong) NSNumber   *addrId;
@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *pointX;

@property(nonatomic, copy) NSString *pointY;

@property(nonatomic, strong) NSNumber *typeAddr;


@end
