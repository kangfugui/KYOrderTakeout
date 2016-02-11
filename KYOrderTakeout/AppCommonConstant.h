//
//  AppCommonConstant.h
//  DeveplopFrameWorkV1.0
//
//  Created by kaiyitech on 14-12-2.
//  Copyright (c) 2014年 kaiyitech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCommonConstant : NSObject

//全局变量声明


//当前网络是否可用
@property (nonatomic) BOOL isNetWorkReach;

//加密的KEY
@property (nonatomic,strong) NSString *desKey;

//登录的用户名
@property (strong,nonatomic) NSString *loginCode;

//登录的token值
@property (strong,nonatomic) NSString *loginToken;

//用户手机号码
@property (strong,nonatomic) NSString *userMobile;

//用户ID
@property (strong,nonatomic) NSString *userId;

//用户名称
@property (strong,nonatomic) NSString *userName;

//用户所在的公司ID
@property (strong,nonatomic) NSString *companyId;

//推送token
@property (strong,nonatomic) NSString *pushToken;


//本地缓存变量声明(NSUserDefaults)

//是否是第一次使用当前版本的App
@property (nonatomic) BOOL isFirstUseCurVersionApp;


//创建单例模式
+(AppCommonConstant *) sharedCommonConstant;

@end
