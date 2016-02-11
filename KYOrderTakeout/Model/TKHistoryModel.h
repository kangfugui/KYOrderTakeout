//
//  TKHistoryModel.h
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface TKHistoryModel : JSONModel

@property(nonatomic ,copy) NSString *sellerId;

@property(nonatomic ,copy) NSString *sellerCode;
@property(nonatomic ,copy) NSString *sellerName;
@property(nonatomic ,strong) NSNumber *sellerType;

@property(nonatomic ,copy) NSString *sellerTel;

@property(nonatomic ,copy) NSString *sellerIntro;

@property(nonatomic ,copy) NSString *createTime;

@property(nonatomic ,strong) NSNumber *schoolId;

@property(nonatomic ,strong) NSNumber *userId;




@end
