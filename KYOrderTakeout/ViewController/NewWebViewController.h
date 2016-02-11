//
//  NewWebViewController.h
//  University1.0
//
//  Created by zhouzhe on 15/6/2.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WebViewJavascriptBridge.h"

@interface NewWebViewController : UIViewController
//@property (nonatomic, strong)WebViewJavascriptBridge *javascriptBridge;
@property (nonatomic, copy)NSString *stringUrl;
@property (nonatomic, copy)NSString *stringIP;
@property (nonatomic, copy)NSString *webType;

//-(void)newWithClose;

@end
