//
//  KYOrderHistoryModel.h
//  University1.0
//
//  Created by 刘成 on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"
#import "KYTimeModel.h"

@interface KYOrderHistoryModel : JSONModel

@property (copy, nonatomic) NSString *address;
//@property (strong, nonatomic) KYTimeModel *createTime;
@property (assign, nonatomic) CGFloat arrivalCost;
@property (assign, nonatomic) NSInteger arrivalTime;
@property (assign, nonatomic) NSInteger employeeId;
@property (assign, nonatomic) BOOL isAdmin;
@property (assign, nonatomic) BOOL isDel;
@property (assign, nonatomic) BOOL isEvening;
@property (assign, nonatomic) BOOL isFree;
@property (assign, nonatomic) BOOL isMorning;
@property (copy, nonatomic) NSString *picUrl;
@property (assign, nonatomic) CGFloat replyRank;
@property (assign, nonatomic) NSInteger salesVolume;
@property (assign, nonatomic) NSInteger schoolId;
@property (assign, nonatomic) NSInteger sellerCode;
@property (assign, nonatomic) NSInteger sellerDetailId;
@property (assign, nonatomic) NSInteger sellerId;
@property (copy, nonatomic) NSString *sellerIntro;
@property (copy, nonatomic) NSString *sellerName;
@property (copy, nonatomic) NSString *sellerTel;
@property (assign, nonatomic) NSInteger sellerType;
@property (assign, nonatomic) NSInteger userId;

@end
