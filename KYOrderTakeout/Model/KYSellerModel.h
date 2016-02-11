//
//  KYSellerModel.h
//  University1.0
//
//  Created by 刘成 on 15/11/24.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface KYSellerModel : JSONModel

@property (assign, nonatomic) CGFloat discount;
@property (assign, nonatomic) BOOL hasBack;
@property (assign, nonatomic) BOOL hasBreakfast;
@property (assign, nonatomic) BOOL hasSnack;
@property (assign, nonatomic) BOOL hasVoucher;
@property (assign, nonatomic) NSInteger hotNums;
@property (assign, nonatomic) CGFloat moneyPeisong;
@property (assign, nonatomic) CGFloat moneyQisong;
@property (copy, nonatomic) NSString *picBanner;
@property (copy, nonatomic) NSString *picIcon;
@property (assign, nonatomic) NSInteger scorePingjia;
@property (assign, nonatomic) NSInteger sellerId;
@property (copy, nonatomic) NSString *sellerName;
@property (copy, nonatomic) NSString *textInfo;
@property (copy, nonatomic) NSString *textKey;
@property (assign, nonatomic) NSInteger timePeisong;
@property (assign, nonatomic) NSInteger volumeSales;

@end
