//
//  NewWebViewController.m
//  University1.0
//
//  Created by zhouzhe on 15/6/2.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "NewWebViewController.h"
//#import "HomePageViewController.h"
//#import "Constant.h"
//#import "ServerConfig.h"
//#import "ArchiveAccessFile.h"
//#import <AddressBook/AddressBook.h>
//#import "Order.h"
//#import "ContactsViewController.h"
//#import "GroupListViewController.h"
//#import "DataSigner.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import <AddressBookUI/AddressBookUI.h>
//#import "NJKWebViewProgress.h"
////#import <SVProgressHUD/SVProgressHUD.h>
//#import "SVProgressHUD.h"
//#import "SVProgressHUD.h"
//#import "LoginRequest.h"
//#import "UIImageView+EMWebCache.h"
//#import "AppDelegate.h"
//#import "ChatViewController.h"
//#import "UMSocial.h"
//#import <AudioToolbox/AudioToolbox.h>
//#import "KYFoodIndexViewController.h"
//#import "EMSDWebImageManager.h"
//#import "UIImage+EMGIF.h"
//#import "UIImage+EMWebP.h"
//
//typedef NS_ENUM(NSInteger, UMSocialURLType) {
//    UMSocialURLTypeDefault,   //默认
//    UMSocialURLTypeImage,     //消息图片类型
//
//    UMSocialURLTypeWeb,       //消息网页类型
//    UMSocialURLTypeMusic,     //消息音乐类型
//    UMSocialURLTypeVideo,     //消息视频类型
//};



//@interface NewWebViewController ()<ABPeoplePickerNavigationControllerDelegate,ABNewPersonViewControllerDelegate,UIWebViewDelegate,NJKWebViewProgressDelegate,UMSocialUIDelegate>
//{
//    NSString *newUrl;
////    NSString *_newNumber;
//    NSString *_orderId;
//    NJKWebViewProgress *_progressProxy;
//    BOOL isPay;
//
//}
//@property (nonatomic, strong)UIWebView *webView;
////@property (nonatomic, strong)NewWebViewController *newWebViewController;
//@property (nonatomic, strong) ABPeoplePickerNavigationController *peoplePicker;
//@property (nonatomic, strong) UIProgressView *progressView;
//@property (nonatomic, strong) NSDictionary *paramDict;
//@property (nonatomic, strong) NSDictionary *dataDict;
//@property (nonatomic, strong) NSDictionary *friendName;
//@property (nonatomic, copy) NSString *theNumber;
//@property (nonatomic, copy) NSString *shakeParam;
//
//@property (nonatomic, strong) UITapGestureRecognizer *tap;     // 点按手势
//
//@property (assign, nonatomic) BOOL showNavigationBarWhenPush;
//
//@end



@implementation NewWebViewController

//- (UIProgressView *)progressView
//{
//    if (_progressView == nil)
//    {
//        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
//        _progressView.frame = self.view.frame;
//        _progressView.progressTintColor =[UIColor colorWithRed:255/255.0 green:200/255.0 blue:1/255.0 alpha:1.0];
//        _progressView.trackTintColor = [UIColor whiteColor];
//    }
//    return _progressView;
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AppDelegateUniversityPlay" object:nil];
//    if (self.showNavigationBarWhenPush)
//    {
//        self.showNavigationBarWhenPush = NO;
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
//
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    _friendName = [ArchiveAccessFile UnarchivedSuccessFileName:kFriendsName];
//    [self restoreContentWithType:NO];
//    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, AppHeight/13)];
//    [imageView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:200/255.0 blue:1/255.0 alpha:1.0]];
//    [self.view addSubview:imageView];
//    [self.view addSubview:self.progressView];
//
//    [self addChilds];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadWebWithInfoDict:) name:@"NSNotificationCenter_NewWebView_reload" object:nil];
}
//
//
//-(void)dealloc
//{
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotificationCenter_NewWebView_reload" object:nil];
//}
//
//-(void)addChilds
//{
//    [[self navigationController] setNavigationBarHidden:YES animated:NO];
//    
//    _webView = [[UIWebView alloc] init];
//    _progressProxy = [[NJKWebViewProgress alloc] init];
//    _progressProxy.webViewProxyDelegate = self;
//    _progressProxy.progressDelegate = self;
//    
//    CGFloat webViewY = self.navigationController.navigationBar.frame.size.height;
//    CGFloat webViewHeight = self.view.frame.size.height - webViewY/2;
//    CGFloat webViewWidth = self.view.frame.size.width;
//    
//    [_webView setFrame:CGRectMake(0, webViewY/3+5, webViewWidth,webViewHeight+5)];
//    [self.view addSubview:_webView];
//      for (id subview in _webView.subviews)
//        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
//        {
//            ((UIScrollView *)subview).bounces = NO;
//        }
//    
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_stringUrl]
//                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                        timeoutInterval:5.0];
//    [self.webView loadRequest:request];
//    
//    __weak __typeof(self) weakSelf = self;
//    
//    self.javascriptBridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:_progressProxy handler:^(id data, WVJBResponseCallback responseCallback)
//    {
//        responseCallback(@"Response for message from ObjC");
//        
//
//
////        [_dataDict setValue:data forKey:@"data"];
//        
//        NSString *dataString = [NSString stringWithFormat:@"%@",data];
//        NSData * Sdata = [dataString dataUsingEncoding:NSUTF8StringEncoding];
//        NSError* error ;
//        NSDictionary* jsonDict = [NSJSONSerialization
//                                 JSONObjectWithData:Sdata
//                                 options:kNilOptions
//                                 error:&error];
//        
//        
//        
////        NSLog(@"------------打印出从javascript中传过来的数据-------------%@",data);
//        
//
//        if (!jsonDict) return;
//
//        NSString *paramURL = [jsonDict objectForKey:@"param"];
//
//        if (weakSelf.stringIP == nil) weakSelf.stringIP = KIP_Head;
//        
//        NSString *url = [NSString stringWithFormat:@"%@%@%@%@",KHttp,weakSelf.stringIP,SERVER_ROOT_WEB,paramURL];
//        NSString *encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        NSString *method = [jsonDict objectForKey:@"method"];
//
//        if ([method isEqualToString:@""]) return;
//
//        if ([method isEqualToString:@"close"])
//        {
//            if ([jsonDict[@"param"] isKindOfClass:[NSArray class]])
//            {
//                NSDictionary *param = [jsonDict[@"param"] firstObject];
//                
//                if ([param[@"func"] isEqualToString:@"redPacketReturn"])
//                {
//                    NSDictionary *redPocket = [param[@"param"] firstObject];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pickerRedPocketNotification"
//                                                                        object:nil
//                                                                      userInfo:redPocket];
//                }
//                else if ([param[@"func"] isEqualToString:@"voucherReturn"])
//                {
//                    NSDictionary *voucher = [param[@"param"] firstObject];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pickerVoucherNotification"
//                                                                        object:nil
//                                                                      userInfo:voucher];
//                    
//                }else if([param[@"func"] isEqualToString:@"takeoutBuy"])
//                {
//                    NSDictionary *goShop  = [param[@"param"] firstObject];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToSellerNotifacation" object:nil userInfo:goShop];
//                }
//            }
//           
//            [weakSelf newWithClose];
//            [weakSelf restoreContentWithType:YES];
//            if ([jsonDict objectForKey:@"param"][0] != nil)
//            {
//                weakSelf.paramDict = [jsonDict objectForKey:@"param"][0];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationCenter_NewWebView_reload" object:weakSelf.paramDict];
//            }
//            [weakSelf jsClick];
//            
//        }
//        else if([method isEqualToString:@"call"]){
//            
//        [weakSelf callWithNumber:[jsonDict objectForKey:@"param"]];
//        
//        }else if([method isEqualToString:@"copy"]){
//            
//            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//            [pasteboard setString:[jsonDict objectForKey:@"param"]];
//            
//        }else if([method isEqualToString:@"url"]){
//            
//            NSURL* url = [[NSURL alloc] initWithString:[jsonDict objectForKey:@"param"]];
//            [[ UIApplication sharedApplication]openURL:url];
//            
//        }else if([method isEqualToString:@"addPerson"]){
//   
//            [weakSelf peopleWithNumber:[jsonDict objectForKey:@"param"] ];
//
//        }else if([method isEqualToString:@"editPerson"]){
//            
//            weakSelf.theNumber = [jsonDict objectForKey:@"param"];
//            weakSelf.peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
//            weakSelf.peoplePicker.peoplePickerDelegate = weakSelf;
//            [weakSelf presentViewController:weakSelf.peoplePicker animated:YES completion:nil];
//
//        }else if ([method isEqualToString:@"saveImg"]){
//            
//            [weakSelf savedWithImageUrl:jsonDict[@"param"]];
//            
//        }else if ([method isEqualToString:@"pay"]){
//            
//            [weakSelf merchandiseWithMoneyDict:[jsonDict objectForKey:@"param"]];
//        
//        }else if ([method isEqualToString:@"shareFriend"]){
//            
//            [weakSelf pushContractVCWithDict:[jsonDict objectForKey:@"param"][0]];
//            
//        }else if ([method isEqualToString:@"shareGroup"]){
//            
//            [weakSelf pushGroupVCWithDict:[jsonDict objectForKey:@"param"][0]];
//        }else if ([method isEqualToString:@"reload"]){
//            
//            [weakSelf reloadWebView];
//        }else if ([method isEqualToString:@"addFriend"]){
//            [weakSelf addFriendWithName:jsonDict[@"param"]];
//        }else if ([method isEqualToString:@"deleteFriend"]){
//            [weakSelf deleteFriendWithName:jsonDict[@"param"]];
//        }
//        else if ([method isEqualToString:@"UMShare"])
//        {
//            [weakSelf UMSocialService:jsonDict[@"param"]];
//        }
//        else if ([method isEqualToString:@"sensor"])
//        {
//            weakSelf.shakeParam = [jsonDict[@"param"] firstObject][@"url"];
//        }
//        else if ([method isEqualToString:@"chat"])
//        {
//            [weakSelf gotoChatViewController:[jsonDict[@"param"] firstObject]];
//        }
//        else
//        {
//            if ([paramURL hasPrefix:@"takeout"])
//            {
//                [weakSelf openOrderFood];
//            }
//            else
//            {
//                [weakSelf loadWithStringUrl:encodingString];
//            }
//        }
//    }];
//}
//
//- (void)openOrderFood
//{
//    KYFoodIndexViewController *index = [[KYFoodIndexViewController alloc] init];
//    index.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:index animated:YES];
//}
//
//- (void)gotoChatViewController:(NSDictionary *)param
//{
//    if ([self.navigationController.topViewController isKindOfClass:[ChatViewController class]])
//    {
//        return;
//    }
//    
//    id chatType = param[@"chatType"];
//    
//    self.showNavigationBarWhenPush = YES;
//    if (chatType)
//    {
//        switch ([chatType integerValue])
//        {
//            case 1:
//            {
//                NSArray *serviceArr = [NSArray arrayWithObject:param][0];
//                NSDictionary *tmepDict =serviceArr[0];
//                NSMutableDictionary *serviceDict = [[NSMutableDictionary alloc] init];
//                if ([ArchiveAccessFile UnarchivedSuccessFileName:KServiceNumber])
//                {
//                    [serviceDict addEntriesFromDictionary:[ArchiveAccessFile UnarchivedSuccessFileName:KServiceNumber]];
//                }
//                
//                [serviceDict setValue:tmepDict forKey:tmepDict[@"userCode"]];
//                [ArchiveAccessFile ArchiveSuccessData:serviceDict fileName:KServiceNumber];
//                
//                ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:tmepDict[@"userCode"] conversationType:eConversationTypeChat];
//                [chatController setHidesBottomBarWhenPushed:YES];
//                [self.navigationController pushViewController:chatController animated:YES];
//            }
//                break;
//            case 2:
//            {
//                ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:param[@"userCode"] isGroup:YES];
//                chatController.hidesBottomBarWhenPushed = YES;
//                chatController.title = param[@"userName"];
//                [self.navigationController pushViewController:chatController animated:YES];
//            }
//                break;
//            default:
//                break;
//        }
//    }
//    else
//    {
//        NSArray *serviceArr = [NSArray arrayWithObject:param][0];
//        NSDictionary *tmepDict =serviceArr[0];
//        NSMutableDictionary *serviceDict = [[NSMutableDictionary alloc] init];
//        if ([ArchiveAccessFile UnarchivedSuccessFileName:KServiceNumber])
//        {
//            [serviceDict addEntriesFromDictionary:[ArchiveAccessFile UnarchivedSuccessFileName:KServiceNumber]];
//        }
//        
//        [serviceDict setValue:tmepDict forKey:tmepDict[@"userCode"]];
//        [ArchiveAccessFile ArchiveSuccessData:serviceDict fileName:KServiceNumber];
//        
//        ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:tmepDict[@"userCode"] conversationType:eConversationTypeChat];
//        [chatController setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:chatController animated:YES];
//    }
//}
//
//- (void)loadWithStringUrl:(NSString *)Surl
//{
//
//    NewWebViewController *_newWebViewController = [[NewWebViewController alloc] init];
//    _newWebViewController.stringUrl = Surl;
//    [self.navigationController pushViewController:_newWebViewController animated:YES];
//
//}
//
////---------------------taokan   2015.11.16 友盟分享  --------------------------------------
//
////-(void)UMSocialService:(NSString *)title shareText:(NSString *)shareText  UMSocialUrlResources:(NSString *)url
//-(void)UMSocialService:(NSDictionary *)jsonDic
//{
//    //解析json
//    NSString *imageURL = jsonDic[@"imageUrl"];              //设置歌手头像，必有
//    NSString *musicURL = jsonDic[@"musicUrl"];              //
//    NSString *videoURL = jsonDic[@"videoUrl"];
//    NSString *targetURL = jsonDic[@"targetUrl"];
//    NSString *shareText = jsonDic[@"shareText"];
//    
////    NSString *imageURL = @"https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=3bbc5db18c82b90122adc433438ca97e/21a4462309f790526c6231a80af3d7ca7bcbd523.jpg";
//    
//    NSString *title = jsonDic[@"title"];
//   
//    
////    UIImage *image = [UIImage sd_animatedGIFNamed:imageURL];
//
//    ///业务逻辑,
//    if (![musicURL isEqualToString:@""]) {
//         [self setUMSocialData:musicURL  imageURL:imageURL   title:title   URLType:UMSocialURLTypeMusic];
//    }else if (![videoURL isEqualToString:@""]){
//        [self setUMSocialData:videoURL imageURL:imageURL    title:title   URLType:UMSocialURLTypeVideo];
//    }else{
//         [self setUMSocialData:targetURL imageURL:imageURL   title:title   URLType:UMSocialURLTypeDefault];
//    }
//    
//    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeClear];
//    
//    [[EMSDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageURL] options:EMSDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize)
//    {
//        
//    } completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
//    {
//        [SVProgressHUD dismiss];
//        [UMSocialSnsService presentSnsIconSheetView:self
//                                             appKey:UMAppKey
//                                          shareText:shareText
//                                         shareImage: image
//                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
//                                           delegate:self];
//    }];
//    
//    
//    
//}
//
//
////设置各个平台的信息，传入分享内容地址, thumbImage:(NSString *)thumburl
//-(void)setUMSocialData:(NSString *)url  imageURL:(NSString *)imageURL title:(NSString *)titles URLType:(UMSocialURLType)type
//{
//    //设置所有分享的头部
//    [UMSocialData defaultData].extConfig.title = titles;
//    [UMSocialData defaultData].urlResource.url = url;           //分享的内容
//    
//   
//    [UMSocialData defaultData].extConfig.qzoneData.url = url;
//    [UMSocialData defaultData].extConfig.qzoneData.title = titles;
//
//    
//    [UMSocialData defaultData].extConfig.wechatSessionData.title =titles;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
//
//    
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = titles;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url =url;
//
//
//    [UMSocialData defaultData].extConfig.wechatFavoriteData.title = titles;
//    [UMSocialData defaultData].extConfig.wechatFavoriteData.url = url;
//
//    
//    
//    switch (type) {
//        case UMSocialURLTypeImage:
//        {
//
//            [UMSocialData defaultData].urlResource.resourceType = UMSocialUrlResourceTypeImage;
//
//
//            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
//
//            [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeImage;
//
//            [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeImage;
//
//            [UMSocialData defaultData].extConfig.wechatFavoriteData.wxMessageType = UMSocialWXMessageTypeImage;
//
//        }
//            break;
//      
//        case UMSocialURLTypeVideo:
//        {
//
//            [UMSocialData defaultData].urlResource.resourceType = UMSocialUrlResourceTypeVideo;
//            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
//            [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeVideo;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeVideo;
//            [UMSocialData defaultData].extConfig.wechatFavoriteData.wxMessageType = UMSocialWXMessageTypeVideo;
//        }
//            break;
//        case UMSocialURLTypeMusic:
//        {
//
//            [UMSocialData defaultData].urlResource.resourceType = UMSocialUrlResourceTypeMusic;
//            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;;
//            
//
//            [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeMusic;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeMusic;
//            [UMSocialData defaultData].extConfig.wechatFavoriteData.wxMessageType = UMSocialWXMessageTypeMusic;
//
//        }
//            break;
//        case UMSocialURLTypeWeb:
//        {
//
//            [UMSocialData defaultData].urlResource.resourceType = UMSocialUrlResourceTypeDefault;
//            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
//            [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
//            [UMSocialData defaultData].extConfig.wechatFavoriteData.wxMessageType = UMSocialWXMessageTypeWeb;
//        }
//            break;
//   }
//    
//}
//
//
////分享完成调用
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
//    //根据`responseCode`得到发送结果,如果分享成功
////    if(response.responseCode == UMSResponseCodeSuccess)
////    {
////        
////    }
//    
//}
//
//
////可以根据不同的分享平台设置不同的内容
//-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
//
//    id social = socialData;
//    NSLog(@"--------%@",socialData);
//    if (platformName == UMShareToQQ) {
//        //qq好友
////        UMSocialQQData *qqData = [[UMSocialQQData alloc]init];
////        qqData.url = @"www.baidu.com";              //分享的内容
////        qqData.title = @"测试由蒙牛";                //测试头
////
////        
////        
////        socialData.urlResource = resul;
////        socialData.extConfig.qqData = qqData;
//        
//        
//    }else if(platformName == UMShareToQzone){
//        //qq控件
////        UMSocialQzoneData *QzoneData = [[UMSocialQzoneData alloc]init];
////        QzoneData.title = @"分享到qq空间的内容";
////        
////        socialData.extConfig.qzoneData = QzoneData;
//        
//        
//    }else if (platformName == UMShareToWechatSession){
//        //微信好友
//        
//    }else if(platformName == UMShareToWechatTimeline){
//        //微信朋友圈
//        
//    }else if (platformName == UMShareToWechatFavorite){
//        //微信收藏
//    }
//}
//
////---------------------taokan   2015.11.16 测试友盟分享--------------------------------------
//
//
//
//-(void)jsClick
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:_paramDict];
//}
//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
//
//#pragma mark - motion action
//
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if (motion == UIEventSubtypeMotionShake && self.shakeParam)
//    {
//        [self triggerShake];
//    }
//}
//
//- (void)triggerShake
//{
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    
//    [self.webView stringByEvaluatingJavaScriptFromString:self.shakeParam];
//    self.shakeParam = nil;
//}
//
//    
////    NSLog(@"-----------------------------------@%",Surl);
//
//    
////    [UMSocialSnsService presentSnsIconSheetView:self
////                                         appKey:UMAppKey
////                                      shareText:@"此二十的是哦昂开发哈看的"
////                                     shareImage:[UIImage imageNamed:@"icon"]
////                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,nil]
////                                       delegate:nil];
//
//
//
////    _newWebViewController = [[NewWebViewController alloc] init];
////    _newWebViewController.stringUrl = Surl;
////    [self.navigationController pushViewController:_newWebViewController animated:YES];
//
////    _newWebViewController = [[NewWebViewController alloc] init];
////    _newWebViewController.stringUrl = Surl;
////    [self.navigationController pushViewController:_newWebViewController animated:YES];
//    
////}
//
//
//
//
//
//
//
//-(void)newWithClose
//{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//
//    if (_webType != nil) {
//        [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    }else{
//        [[self navigationController] setNavigationBarHidden:YES animated:YES];
//
//    }
//
//}
//
//-(void)callWithNumber:(NSString *)number
//{
//    
//    if (number != nil) {
//        
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",number]]];//使用这个方法，打电话结束后会进入联系人列表
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",number]]];
//        //使用这种方法在拨打电话前会先弹出框，询问是否打电话，然后打完电话之后回到主程序中，有人说这种方法可能不合法，无法通过审核
//        
//    }
//
//}
//
//
//#pragma mark -- ABPeoplePickerNavigationControllerDelegate
//-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
//{
//    ABNewPersonViewController *newVC = [[ABNewPersonViewController alloc] init];
//    newVC.newPersonViewDelegate = self;
//    //获得电话本
//    ABAddressBookRef addressBook = ABAddressBookCreate();
//    //获取联系人
//    CFArrayRef contacts = ABAddressBookCopyArrayOfAllPeople(addressBook);
//    [self paintInfo:contacts];
//
//    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
//    
//    ABMutableMultiValueRef multi=ABMultiValueCreateMutableCopy(phoneNumbers);
//
//    //添加新的字段
//    ABMultiValueAddValueAndLabel(multi,(__bridge CFStringRef)_theNumber, kABPersonPhoneMobileLabel, nil);
//    //修改联系人电话
//    ABRecordSetValue(person, kABPersonPhoneProperty, multi, nil);
//
//    newVC.displayedPerson = person;
//    [self.navigationController pushViewController:newVC animated:YES];
//    [[newVC navigationController] setNavigationBarHidden:NO animated:YES];
//    _theNumber = nil;
//
//}
//
//
//-(void)peopleWithNumber:(NSString *)number
//{
//    ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
//    picker.newPersonViewDelegate = self;
//    ABRecordRef personRef=ABPersonCreate();
//    CFErrorRef error =NULL;
//    ABMutableMultiValueRef multi=ABMultiValueCreateMutable(kABMultiStringPropertyType);
//    ABMultiValueAddValueAndLabel(multi,(__bridge CFTypeRef)(number), kABPersonPhoneMobileLabel, NULL);
//    ABRecordSetValue(personRef, kABPersonPhoneProperty, multi, &error);
//    picker.displayedPerson = personRef;
//    [self.navigationController pushViewController:picker animated:YES];
//    [[picker navigationController] setNavigationBarHidden:NO animated:YES];
//
//}
//
//-(void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person
//{
//
//        [self.navigationController popViewControllerAnimated:YES];
//        [[self navigationController] setNavigationBarHidden:YES animated:YES];
//
//}
//
//
//-(void)paintInfo:(CFArrayRef)contacts {
//    
//    for(CFIndex i = 0; i < CFArrayGetCount(contacts); i++) {
//        ABRecordRef person = CFArrayGetValueAtIndex(contacts, i);
//        
//        NSString *firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
//        ATLog(@"first name: %@",firstName);
//        
//        NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
//        ATLog(@"last name: %@",lastName);
//        
//        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
//        if(phones) {
//            for (int k = 0; k < ABMultiValueGetCount(phones); k++) {
//                NSString *phoneMobile = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, 0);
//                ATLog(@"mobile: %@",phoneMobile);
//                
//                NSString *label = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, k));
//                if(label)
//                    ATLog(@"label: %@",label);
//            }
//        }
//        
//        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
//        if(emails) {
//            for (int i = 0; i < ABMultiValueGetCount(emails); i++) {
//                NSString *workEmail = (__bridge NSString *)ABMultiValueCopyValueAtIndex(emails, 0);
//                ATLog(@"email: %@",workEmail);
//            }
//        }
//    }
//}
//
//
//#pragma mark   ==============产生随机订单号==============
//- (NSString *)generateTradeNO
//{
//    static int kNumber = 15;
//    
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand(time(0));
//    for (int i = 0; i < kNumber; i++)
//    {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }
//    return resultStr;
//}
//
//-(void)merchandiseWithMoneyDict:(NSDictionary *)moneyDict
//{
//
//    Order *order = [[Order alloc] init];
//    order.amount = [moneyDict objectForKey:@"amount"];
//    order.productName = [moneyDict objectForKey:@"name"]; //商品标题
//    order.productDescription = moneyDict[@"desc"];
//    _orderId = moneyDict[@"orderId"];
//    order.partner = Kpartner;
//    order.seller =  Kseller;
//    order.tradeNO = moneyDict[@"orderCode"]; //订单ID（由商家自行制定）
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"University1";
//    NSString *orderSpec = [order description];
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(KprivateKey);
//    NSString *signedString = [signer signString:orderSpec];
//
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            
//            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
//                
//                [self showHint:@"支付成功"];
//                [self isPayPraise];
//            }else{
//                [self showHint:@"支付未成功"];
//            }
//            
//            
//        }];
//    }
//}
//#pragma mark 分享到好友
//-(void)pushContractVCWithDict: (NSDictionary *)dict
//{
//    ContactsViewController *contractVC = [[ContactsViewController alloc] init];
//    contractVC.shareDict = dict;
//    [contractVC setHidesBottomBarWhenPushed:YES];
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contractVC];
//    nav.tabBarItem.title = @"分享";
//    [self presentViewController:nav animated:YES completion:^{
//    }];
//}
//
//#pragma mark 分享群组
//-(void)pushGroupVCWithDict: (NSDictionary *)dict
//{
//    GroupListViewController *groupVC = [[GroupListViewController alloc] init];
//    groupVC.shareDict = dict;
//    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:groupVC];
//    nav.tabBarItem.title = @"分享";
//    [self presentViewController:nav animated:YES completion:^{
//    }];
//}
//
//#pragma mark - NJKWebViewProgressDelegate
//-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
//{
//    if (progress == 0.0) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//        _progressView.progress = 0;
//        [UIView animateWithDuration:0.27 animations:^{
//            _progressView.alpha = 1.0;
//        }];
//    }
//    if (progress == 1.0) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
//            _progressView.alpha = 0.0;
//        } completion:nil];
//    }
//    
//    [_progressView setProgress:progress animated:NO];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"error" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
//    
//}
//
//#pragma mark 添加好友
//-(void)addFriendWithName:(NSString *)name
//{
//    EMError *error = nil;
//    BOOL isSuccess = YES;
//    UIAlertView *alertVC = [[UIAlertView alloc] initWithTitle:@"提 示" message:@"此用户已是好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//
//    if (_friendName[name]) {
//        [alertVC show];
//        isSuccess = NO;
//    }
//    if (isSuccess) {
//        isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:name message:@"我想加您为好友" error:&error];
//
//        [self newWithClose];
//        
//        [LoginRequest updateNameResult:name Type:@"2" completionBlock:^(NSDictionary *dict) {
//            if (dict != nil) {
//                NSArray *arr= [NSArray arrayWithObject:dict[@"data"]][0];
//                NSMutableDictionary *nameDict = [[NSMutableDictionary alloc] init];
//                
//                for (NSDictionary *dict in arr) {
//                    [nameDict setObject:dict[@"userName"] forKey:dict[@"userCode"]];
//                    NSString *sex = [NSString stringWithFormat:@"%@Sex",dict[@"userCode"]];
//                    [nameDict setObject:dict[@"sex"] forKey:sex];
//                }
//                [ArchiveAccessFile ArchiveSuccessData:nameDict fileName:kFriendsName];
//            }
//        
//        }];
//    }
//    name = nil;
//}
//
//-(void)deleteFriendWithName:(NSString *)name
//{
//    if (_friendName != nil) {
//        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:_friendName];
//        [mutableDict removeObjectForKey:name];
//        [mutableDict removeObjectForKey:[NSString stringWithFormat:@"%@Sex",name]];
//        [ArchiveAccessFile ArchiveSuccessData:mutableDict fileName:kFriendsName];
//    }
//    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
//    [userInfo setObject:name forKey:@"friendName"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteFriend" object:nil userInfo:userInfo];
//}
//
////支付成功后回调上一个
//-(void)isPayPraise{
//    
//    NSDictionary *userDict = [ArchiveAccessFile UnarchivedSuccessFileName:userDatas];
//    NSString *webUrlHead = [NSString stringWithFormat:@"%@%@%@shop/paySuccess.jsp?",KHttp,KIP_Head,SERVER_ROOT_WEB];
//    NSString *webString =[NSString stringWithFormat:@"%@uid=%@&id=%@",webUrlHead,userDict[@"userId"],_orderId];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webString]]];
//}
//
//#pragma mark 保存图片到相册
//-(void)savedWithImageUrl:(NSString *)imageUrl
//{
//    [self showHudInView:self.view hint:@"正在保存"];
//    
//     EMSDWebImageManager *imageManager  =  [EMSDWebImageManager sharedManager];
//    [imageManager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//    } completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        [self hideHud];
//
//        if (error) {
//            [self showHint:@"保存失败,请重试!"];
//        }
//        if (image) {
//            UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
//        }
//    }];
// }
//
//
////实现imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:方法
//- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (!error) {
//
//        [self showHint:@"成功保存到相册"];
//        
//    }else
//    {
//
//        [self showHint:@"保存失败,请重试!"];
//    }
//}
//
//#pragma mark 恢复内容视图到最开始的位置。
//- (void)restoreContentWithType:(BOOL)type
//{
//    AppDelegate *app  = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app.mainController.screePan setEnabled:type];
//}
//
//-(void)reloadWebWithInfoDict:(NSNotification *)infoDict
//{
//    if ([infoDict.object[@"func"] isEqualToString:@"reload"]) {
//        [self reloadWebView];
//    }
//}
//
//-(void)reloadWebView
//{
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_stringUrl]]];
//    
//}

@end
