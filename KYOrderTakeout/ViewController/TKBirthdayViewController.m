//
//  TKBirthdayViewController.m
//  University1.0
//
//  Created by yoyo on 15/12/1.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "TKBirthdayViewController.h"
#import "ServerConfig.h"
#import "Masonry.h"
#import "WebViewJavascriptBridge.h"
@interface TKBirthdayViewController ()<UIWebViewDelegate>

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, assign) NSTimeInterval interval;

@property(nonatomic, weak) UIWebView *webView;

@property(nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation TKBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self layoutSubView];
    [self requestData];
    //r如果采用webview关闭页面，那么就不需要添加定时器
//    [self addTimer];
}


-(void)layoutSubView
{

    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    webView.scrollView.showsHorizontalScrollIndicator  = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    [webView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:webView];
    self.webView = webView;

    
    
    __block __typeof(self) weakSelf = self;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"跳过" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:0.5]];
    [button setFont:[UIFont systemFontOfSize:15]];
    [button addTarget:self action:@selector(dismissBirthdayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view   insertSubview:button aboveSubview:webView];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view.mas_top).offset(25);
//        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
}

-(void)requestData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@",KHttp ,KIP_Head,SERVER_ROOT_WEB, @"/find/show.html"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    _bridge  = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"---------------web交互原生");
        NSString *dataString = [NSString stringWithFormat:@"%@",data];
//        NSData *StrData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *error = nil;
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:StrData options:NSJSONReadingMutableLeaves error:&error];
//        NSString *method = [jsonDict objectForKey:@"method"];
//        
//        if ([method isEqualToString:@"close"]) {
//            [self dismissBirthdayClick];
//        }
        
        NSString *searchStr = @"close";
        NSRange range = [dataString rangeOfString:searchStr];
        if (range.length != 0) {
             [self dismissBirthdayClick];
        }
        
    }];
    
}

-(void)addTimer
{
    self.interval = 5;
   NSTimer *timer =  [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(dismissBirthdayClick) userInfo:nil repeats:NO];
    self.timer = timer;
}


-(void)dismissBirthdayClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)dealloc
{
    [self.timer invalidate];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"---------开始加载请求");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSLog(@"-------请求加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
//    NSLog(@"-------------请求错误");
}


@end
