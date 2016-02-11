//
//  TKImageModel.h
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "JSONModel.h"

@interface TKImageModel : JSONModel

@property(nonatomic, weak)NSString *imgUrl;

@property(nonatomic, weak) NSString *typeName;

@property(nonatomic, weak)NSString *fileUploadId;

@property(nonatomic, weak)NSString *path;

@property(nonatomic, strong)NSNumber *schoolId;

@property(nonatomic, strong)NSNumber *imgOrder;

@property(nonatomic, strong)NSNumber *typeId;


@end
