//
//  KYImageModel.h
//  University1.0
//
//  Created by 刘成 on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface KYImageModel : JSONModel

@property (assign, nonatomic) NSInteger fileUploadId;
@property (assign, nonatomic) NSInteger imgOrder;
@property (copy, nonatomic) NSString *imgUrl;
@property (copy, nonatomic) NSString *path;
@property (assign, nonatomic) NSInteger schoolId;
@property (assign, nonatomic) NSInteger typeId;
@property (copy, nonatomic) NSString *typeName;

@end
