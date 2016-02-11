//
//  KYTimeModel.h
//  University1.0
//
//  Created by 刘成 on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface KYTimeModel : JSONModel

@property (assign, nonatomic) NSInteger date;
@property (assign, nonatomic) NSInteger day;
@property (assign, nonatomic) NSInteger hours;
@property (assign, nonatomic) NSInteger minutes;
@property (assign, nonatomic) NSInteger seconds;
@property (assign, nonatomic) NSInteger time;
@property (copy, nonatomic) NSString *timezoneOffset;
@property (assign, nonatomic) NSInteger year;

@end
