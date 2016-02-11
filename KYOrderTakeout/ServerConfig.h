//
//  ServerConfig.h
//  DeveplopFrameWorkV1.0
//
//  Created by kaiyitech on 14-10-18.
//  Copyright (c) 2014年 kaiyitech. All rights reserved.
//

#ifndef DeveplopFrameWorkV1_0_ServerConfig_h
#define DeveplopFrameWorkV1_0_ServerConfig_h

#define KHttp @"http://"
//#define KIP_Head @"120.24.179.213:8080"
//#define KIP_Head @"192.168.31.107:8080"
//#define KIP_Head @"192.168.31.169:8080"
#define KIP_Head @"192.168.0.99:8192"


//#define KIP_Head @"dev.54yoyo.com:8192"

//#define KIP_Head @"221.232.0.15:8192"



#define SERVER_ROOT_WEB @"/SchoolCommunityWeb/"

#define SERVER_ROOT  @"/SchoolCommunity/"

#define KBUSINESS  @"/SchoolCommunity/control/BusinessServlet"
#define KLONGIN    @"/SchoolCommunity/sys/loginServlet"

#define KFildName @"IP"
#define KIP       [ArchiveAccessFile UnarchivedSuccessFileName:KFildName]



#define UMAppKey @"507fcab25270157b37000010"

#define kFullWebViewURL(e) [NSString stringWithFormat:@"%@%@%@%@",KHttp,KIP_Head,SERVER_ROOT_WEB,e]

#define toString(e) [NSString stringWithFormat:@"%@",e]


//广告
#define imageDict @"imageDcit"

#ifdef DEBUG
#define ATLog(...) NSLog(__VA_ARGS__)
#else
#define ATLog(...)
#endif

#endif




