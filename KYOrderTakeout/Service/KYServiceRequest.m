//
//  KYServiceRequest.m
//  University1.0
//
//  Created by 刘成 on 15/11/11.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYServiceRequest.h"
#import "AppCommonConstant.h"
#import "AFNetworking.h"
#import "JSONModelLib.h"

NSString *const API_RedBag = @"shop.red.web";
NSString *const API_Voucher = @"shop.voucher.web";
NSString *const API_PictureConfig = @"base.pictureconfig.web";
NSString *const API_OrderHistory = @"shop.order.web";
NSString *const API_StoreDetail = @"shop.seller.web";
NSString *const API_HotStore = @"shop.seller.web";
NSString *const API_TakeOut = @"takeout.main.web";
NSString *const API_Order = @"takeout.order.web";

@implementation KYServiceRequest

+ (BOOL)netWorkReachabilityWithURLString:(NSString *)strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        switch (status)
        {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}

//+ (void)RequestGETWithRequestURL:(NSString *)requestURLString
//                   withParameter:(NSDictionary *)parameter
//                withSuccessBlock:(requestSuccessBlock)block
//                  withErrorBlock:(requestErrorBlock)errorBlock
//{
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    
//    AFHTTPRequestOperation *op = [manager GET:requestURLString
//                                   parameters:parameter
//                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@", dic);
//        
//        block(dic);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        errorBlock(error);
//    }];
//    
//    op.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [op start];
//}

+ (void)requestPOSTWithRequestAPI:(NSString *)api
                         isSecret:(BOOL)isSecret
                    withParameter:(NSDictionary *)parameter
                withResponseClass:(__unsafe_unretained Class)resClass
                 withSuccessBlock:(requestSuccessBlock)block
                   withErrorBlock:(requestErrorBlock)errorBlock
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    
    d[@"bid"] = [formatter stringFromDate:[NSDate date]];
    d[@"uid"] = @"";
    d[@"cid"] = @"";
    d[@"sid"] = api;
    d[@"stat"] = @"0";
    d[@"rmk"] = @"";
    d[@"ver"] = @"1";
    d[@"token"] = @"";
    d[@"biz"] = parameter;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:d
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *param = @{@"d":json,@"tok":@"",@"e":(isSecret ? @"DES" : @"PLAIN")};
    
    NSError *error = nil;
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"
                     forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST"
                                                                      URLString:kRootAddress
                                                                     parameters:param
                                                                          error:&error];
    if (error) return;
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        NSDictionary *biz = dict[@"biz"];
        NSInteger code = [biz[@"returnCode"] integerValue];
        
        if (code == 1)
        {
            id data = biz[@"data"];
            
            if (resClass)
            {
                if ([data isKindOfClass:[NSArray class]])
                {
                    NSArray *arrModel = [resClass arrayOfModelsFromDictionaries:data];
                    block(arrModel);
                }
                else if ([data isKindOfClass:[NSDictionary class]])
                {
                    id model = [[resClass alloc] initWithDictionary:data error:nil];
                    block(model);
                }
            }
            else
            {
                block(data);
            }
        }
        else
        {
            errorBlock(dict);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        
    }];
    
    [manager.operationQueue addOperation:operation];
}

@end
