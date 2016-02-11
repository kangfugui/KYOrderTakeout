//
//  KYServiceRequest.h
//  University1.0
//
//  Created by 刘成 on 15/11/11.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define kRootAddress @"http://221.232.0.15:8192/SchoolCommunity/control/BusinessServlet"
#define kRootAddress @"http://192.168.0.99:8192/SchoolCommunity/control/BusinessServlet"
//#define kRootAddress @"http://dev.54yoyo.com:8192/SchoolCommunity/control/BusinessServlet"

//#define kImageRoot @"http://dev.54yoyo.com:8192/SchoolCommunity/oss/systemFile/"
#define kImageRoot @"http://192.168.0.99:8192/SchoolCommunity/oss/systemFile/"
#define kFullImageURL(e) [NSString stringWithFormat:@"%@%@",kImageRoot,e]

FOUNDATION_EXPORT NSString *const API_RedBag;
FOUNDATION_EXPORT NSString *const API_Voucher;
FOUNDATION_EXPORT NSString *const API_PictureConfig;
FOUNDATION_EXPORT NSString *const API_OrderHistory;
FOUNDATION_EXPORT NSString *const API_StoreDetail;
FOUNDATION_EXPORT NSString *const API_HotStore;
FOUNDATION_EXPORT NSString *const API_TakeOut;
FOUNDATION_EXPORT NSString *const API_Order;

typedef void (^requestSuccessBlock) (id response);
typedef void (^requestErrorBlock) (id error);
typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface KYServiceRequest : NSObject

#pragma 监测网络的可链接性
+ (BOOL)netWorkReachabilityWithURLString:(NSString *) strUrl;

#pragma POST请求
+ (void)requestPOSTWithRequestAPI:(NSString *)api
                         isSecret:(BOOL)isSecret
                    withParameter:(NSDictionary *)parameter
                withResponseClass:(Class)resClass
                 withSuccessBlock:(requestSuccessBlock)block
                   withErrorBlock:(requestErrorBlock)errorBlock;

#pragma GET请求
//+ (void)RequestGETWithRequestURL:(NSString *)requestURLString
//                   withParameter:(NSDictionary *)parameter
//                withSuccessBlock:(requestSuccessBlock)block
//                  withErrorBlock:(requestErrorBlock)errorBlock;

@end
