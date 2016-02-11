//
//  TKOrderConfirmationViewController.m
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "TKOrderConfirmationViewController.h"
#import "Masonry.h"
#import "TKOrderConfirmationTableViewCell.h"
#import "TKOrderConfirmationHeaderView.h"
#import "TKAddressViewController.h"
#import "KYServiceRequest.h"

#import "KYGoodsModel.h"
#import "KYCustomBarItem.h"
#import "SVProgressHUD.h"
#import "AppCommonConstant.h"

#import "TKOrderConfirmationModel.h"
#import "TKAddressSelectedViewController.h"

#import "TKOrderConfirmationModel.h"
#import "NewWebViewController.h"
#import "KYFoodIndexViewController.h"

#define COLOR(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

@interface TKOrderConfirmationViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic, weak) UITableView *tableview;

@property(nonatomic, strong) UITableViewCell *hongbaoCell;
@property (nonatomic, strong) UITableViewCell *diyongquanCell;

@property(nonatomic, strong) UITableViewCell *lufeiCell;

@property(nonatomic, strong)TKOrderConfirmationHeaderView *headerView;

@property(nonatomic,weak) UILabel  *diyongquanPrice;

@property(nonatomic, weak) UILabel * HongbaoPrice;

@property(nonatomic, weak) UILabel *lufeiPrice;

@property(nonatomic,strong)TKOrderConfirmationModel *model;

@property (copy, nonatomic) NSString *orderCode;

@property (assign, nonatomic) NSInteger myAddrId;
@property (assign, nonatomic) NSInteger addrId;

@property (strong, nonatomic) NSMutableArray *discountSection;

@property (assign, nonatomic) NSInteger currentRedPotcketId;
@property (copy, nonatomic) NSString *currentRedPotcketMoney;
@property (assign, nonatomic) NSInteger currentVoucherId;
@property (copy, nonatomic) NSString *currentVoucherMoney;
@property (copy, nonatomic) NSDictionary *currentPayInfo;

@property(nonatomic, weak) UILabel *price;

@end


@implementation TKOrderConfirmationViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"订单确认";
    self.discountSection = [[NSMutableArray alloc] initWithCapacity:2];

    [self layoutSubview];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [KYCustomBarItem backBarWithTarget:self andAction:@selector(back)];
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(UserAddress:)
                                                name:@"userInfo"
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePickerRedPocketNotification:) name:@"pickerRedPocketNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePickerVoucherNotification:)
                                                 name:@"pickerVoucherNotification"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"userInfo"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"pickerRedPocketNotification"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"pickerVoucherNotification"
                                                  object:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.headerView endEditing:YES];
}



- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.headerView endEditing:YES];
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - notification

- (void)receivePickerVoucherNotification:(NSNotification *)notification
{
    self.currentVoucherId = [notification.userInfo[@"myVoucherId"] integerValue];
    self.currentVoucherMoney = toString(notification.userInfo[@"money"]);
    
    NSString *diyongquanPic = [@"-" stringByAppendingString:self.currentVoucherMoney];
    if (self.currentVoucherId == 0) diyongquanPic = @"不使用";
    
    [self.diyongquanPrice setText:diyongquanPic];
 
    [self setBottomPriceText];
}

- (void)receivePickerRedPocketNotification:(NSNotification *)notification
{
    self.currentRedPotcketId = [notification.userInfo[@"redPacketId"] integerValue];
    self.currentRedPotcketMoney = toString(notification.userInfo[@"money"]);
    
    NSString *hongbaoPic = [@"-" stringByAppendingString:self.currentRedPotcketMoney];
    if (self.currentRedPotcketId == 0) hongbaoPic = @"不使用";
    [self.HongbaoPrice setText:hongbaoPic];
    
    [self setBottomPriceText];
}

-(void)UserAddress:(NSNotification *)notification
{
    NSDictionary *userInfos = notification.userInfo;
    
    self.myAddrId = [[userInfos objectForKey:@"myAddrId"] integerValue];
    self.addrId = [userInfos[@"addrId"] integerValue];
    self.model.userName = userInfos[@"userName"];
    self.model.mobile = userInfos[@"phoneText"];
    self.model.address = userInfos[@"addressText"];
    self.headerView.userInfo = userInfos;
}

#pragma mark -  请求数据

- (void)requestData
{
//    CGFloat zongjia = [self calcGoodsMoney];
    
    self.myAddrId = 0;
    self.addrId = 1;
    self.model = [[TKOrderConfirmationModel alloc] init];
    self.model.addrId = @(3);
    self.model.address = @"11444fefe";
    self.model.mobile = @"18627156769";
    self.model.myAddrId = @(2);
    self.model.userName = @"测试";
    self.model.redPacket = [[TKRedPacketModel alloc] init];
    self.model.redPacket.redPacketId = @(11);
    self.model.redPacket.money = @"5.0";
    self.model.voucher = [[TKVoucherModel alloc] init];
    self.model.voucher.voucherId = @(12);
    self.model.voucher.money = @"3.0";
    
    [self.headerView updateUserInforface:self.model];
    self.currentRedPotcketId = [self.model.redPacket.redPacketId integerValue];
    self.currentRedPotcketMoney = self.model.redPacket.money;
    self.HongbaoPrice.text = [@"-" stringByAppendingString:self.currentRedPotcketMoney];
    [self.discountSection addObject:@"redPacket"];
    
    self.currentVoucherId = [self.model.voucher.voucherId integerValue];
    self.currentVoucherMoney = self.model.voucher.money;
    self.diyongquanPrice.text = [@"-" stringByAppendingString:self.currentVoucherMoney];
    [self.discountSection addObject:@"voucher"];
    [self.tableview reloadData];
    [self setBottomPriceText];
//    NSDictionary *param = @{@"optCode":@8,
//                            @"userId":[AppCommonConstant sharedCommonConstant].userId,
//                            @"sellerId":@(self.sellerId),
//                            @"money":@(zongjia),
//                            @"discount": @(self.sellerDiscount)
//                            };
//    [KYServiceRequest requestPOSTWithRequestAPI:API_TakeOut
//                                       isSecret:NO
//                                  withParameter:param
//                              withResponseClass:[TKOrderConfirmationModel class]
//                               withSuccessBlock:^(id response)
//    {
//        self.model = response;
//        self.myAddrId = [self.model.myAddrId integerValue];
//        self.addrId = [self.model.addrId integerValue];
//        
//        [_headerView updateUserInforface:response];
//        
//        self.currentRedPotcketId = [self.model.redPacket.redPacketId integerValue];
//        self.currentVoucherId = [self.model.voucher.myVoucherId integerValue];
//        if (self.model.redPacket)
//        {
//        }
//        if (self.model.voucher)
//        {
//        }
//        
//        [self.tableview reloadData];
//        [self setBottomPriceText];
//        
//    } withErrorBlock:^(id error)
//    {
//        
//    }];
}

#pragma mark - 懒加载

//抵用券
- (UITableViewCell *)diyongquanCell
{
    if (!_diyongquanCell)
    {
        _diyongquanCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _diyongquanCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _diyongquanCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configCell:_diyongquanCell
               withImage:[UIImage imageNamed:@"di_yong_quan_icon_h"]
                andTitle:@"抵用券"];
        
        UILabel *diyongquanPrice = [UILabel new];
        [diyongquanPrice setTextColor:[UIColor grayColor]];
        
        [_diyongquanCell.contentView addSubview:diyongquanPrice];
        self.diyongquanPrice = diyongquanPrice;
        [diyongquanPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.diyongquanCell);
            make.right.equalTo(self.diyongquanCell).offset(-30);
        }];
        
        if (self.currentVoucherMoney) {
            self.diyongquanPrice.text = [@"-" stringByAppendingString:self.currentVoucherMoney];
        }
        
        
    }
    return _diyongquanCell;
}



//红包
-(UITableViewCell *)hongbaoCell
{
    
    if (!_hongbaoCell) {
        
        _hongbaoCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                             reuseIdentifier:nil];

        _hongbaoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _hongbaoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configCell:_hongbaoCell
               withImage:[UIImage imageNamed:@"hong_bao_icon"]
                andTitle:@"红包"];
        
        UILabel *HongbaoPrice = [UILabel new];
        [HongbaoPrice setTextColor:[UIColor grayColor]];
        [_hongbaoCell.contentView addSubview:HongbaoPrice];
        self.HongbaoPrice = HongbaoPrice;
        [HongbaoPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.hongbaoCell);
            make.right.equalTo(self.hongbaoCell).offset(-30);
        }];
    
        if (self.currentRedPotcketMoney) {
            self.HongbaoPrice.text = [@"-" stringByAppendingString:self.currentRedPotcketMoney];
        }
        
//        self.currentRedPotcketMoney = self.model.redPacket.money;
    }
    return _hongbaoCell;
}




- (void)configCell:(UITableViewCell *)cell withImage:(UIImage *)image andTitle:(NSString *)title
{
    UIImageView *icon = [[UIImageView alloc] init];
    [icon setImage:image];
    [cell.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@15);
         make.centerY.equalTo(cell.contentView);
     }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.equalTo(cell.contentView);
         make.left.equalTo(icon.mas_right).offset(5);
     }];
}

//路费
-(UITableViewCell *)lufeiCell
{
    if (!_lufeiCell) {
        _lufeiCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _lufeiCell.textLabel.text = @"配送费";
        [_lufeiCell.textLabel setFont:[UIFont systemFontOfSize:15]];
        _lufeiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *lufeiPrice = [UILabel new];
        
        [lufeiPrice setFont:[UIFont systemFontOfSize:15]];
        (self.lufei == 0)?([lufeiPrice setText:@"免配送费"]):([lufeiPrice setText:[NSString stringWithFormat:@"+ %.1f",self.lufei]]);
  
        [_lufeiCell.contentView addSubview:lufeiPrice];
        self.lufeiPrice = lufeiPrice;
        
        [lufeiPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_lufeiCell);
            make.right.equalTo(_lufeiCell).offset(-30);
        }];
        
        
    }
    return _lufeiCell;
}



-(void)layoutSubview
{
    CGRect rect = self.view.bounds;
    rect.size.height -= 49;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    TKOrderConfirmationHeaderView *header = [[TKOrderConfirmationHeaderView alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 120)];
    
    [header addTarget:self action:@selector(pushAddressViewController) forControlEvents:UIControlEventTouchUpInside];
    [tableview setTableHeaderView:header];
    self.headerView = header;
    [self.view addSubview:tableview];
    self.tableview = tableview;
    
    [self bottomAboveTableView];
    
}

#pragma mark - private method

- (void)pushToWebViewWithSuffix:(NSString *)suffix
{
    NewWebViewController *newWeb = [[NewWebViewController alloc] init];
    newWeb.stringUrl = kFullWebViewURL(suffix);
    [self.navigationController pushViewController:newWeb animated:YES];
}

- (CGFloat)calcGoodsMoney
{
    CGFloat money = 0;
    for (KYGoodsModel *goods in self.DetailArray)
    {
        money += ((goods.priceDiscount > 0 ? goods.priceDiscount : goods.priceSelling) * goods.buyCount);
    }
    
    
    money += self.lufei;
    return MAX(0, money);
}

#pragma mark - push 新的控制器
-(void)pushAddressViewController
{
    
    if([_model.myAddrId intValue] != 0){
        TKAddressSelectedViewController *addressSelectedVC = [[TKAddressSelectedViewController alloc]init];
        
        addressSelectedVC.addressSelectedID = self.myAddrId;
        addressSelectedVC.userID = [_model.voucher.userId intValue];
        [self.navigationController pushViewController:addressSelectedVC animated:YES];
    }else
    {
        TKAddressViewController *addressVC = [[TKAddressViewController alloc]init];
        [self.navigationController pushViewController:addressVC animated:YES];
    }

}

- (void)popToIndexViewController
{
    for (UIViewController *item in self.navigationController.viewControllers)
    {
        if ([item isKindOfClass:[KYFoodIndexViewController class]])
        {
            [self.navigationController popToViewController:item animated:YES];
            break;
        }
    }
}


-(void)bottomAboveTableView
{
    
    __weak __typeof(self) weakSelf = self;
    
    UIView *bottomView = [UIView new];
    [bottomView setBackgroundColor:[UIColor colorWithRed:42/255 green:42/255 blue:42/255 alpha:0.8]];
    [self.view insertSubview:bottomView aboveSubview:self.tableview];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@49);
    }];
    

    UILabel *price = [UILabel new];

    [price setTextColor:COLOR(255, 192, 4, 0.7)];
    //获得label的size
    [bottomView addSubview:price];
    self.price = price;
    
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left).offset(20);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:COLOR(255, 191, 2, 1.0)];
    [button setTitle:@"立即支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    button.contentEdgeInsets =  UIEdgeInsetsMake(5, 10, 5, 10);
    [button mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
     [self setBottomPriceText];
}


-(void)setBottomPriceText{
    
    CGFloat maney = 0.0;
    for (KYGoodsModel *model in self.DetailArray) {
        maney += model.priceDiscount * model.buyCount;
    }
    
//    maney -= ([self.model.voucher.maney intValue] + [self.model.redPacket.maney intValue]);
    
    if(self.currentRedPotcketMoney){
        maney -= [self.currentRedPotcketMoney floatValue];
    }
    
    if (self.currentVoucherMoney) {
        maney -= [self.currentVoucherMoney floatValue];
    }
    
    
    maney += self.lufei;
    maney = MAX(maney, 0);
    [self.price setText:[NSString stringWithFormat:@"%.02f", maney]];
    
}



//支付
- (void)orderAction:(UIButton *)sender
{
//    if (self.model.userName.length == 0 ||
//        self.model.mobile.length == 0 ||
//        self.model.address.length == 0)
//    {
//        [SVProgressHUD showErrorWithStatus:@"请填写收货地址"];
//        return;
//    }
//    
//    NSString *redMoney = self.currentRedPotcketMoney ? self.currentRedPotcketMoney : @"0";
//    NSString *voucherMoney = self.currentVoucherMoney ? self.currentVoucherMoney : @"0";
//    NSString *uid = [AppCommonConstant sharedCommonConstant].userId;
//    NSMutableArray *goodsList = [[NSMutableArray alloc] init];
//    
//    CGFloat money = [self calcGoodsMoney];
//    money -= [redMoney floatValue];
//    money -= [voucherMoney floatValue];
//    money = MAX(money, 0);
//    
//    for (KYGoodsModel *goods in self.DetailArray)
//    {
//        [goodsList addObject:[goods postDictionary]];
//    }
//    
//    NSMutableDictionary *param = [@{@"userId" : uid,
//                                    @"optCode" : @"33",
//                                    @"money" : [NSString stringWithFormat:@"%.1f",money],
//                                    @"moneyPeisong" : [NSString stringWithFormat:@"%.f",self.lufei],
//                                    @"moneyRedPacket" : redMoney,
//                                    @"moneyVoucher" : voucherMoney,
//                                    @"redPacketId" : @(self.currentRedPotcketId),
//                                    @"voucherId" : @(self.currentVoucherId),
//                                    @"discount" : @(self.sellerDiscount),
//                                    @"sellerId" : @(self.sellerId),
//                                    @"addrId" : @(self.addrId),
//                                    @"myAddrId" : @(self.myAddrId),
//                                    @"userName" : self.model.userName,
//                                    @"mobile" : self.model.mobile,
//                                    @"address" : self.model.address,
//                                    @"moment" : self.headerView.beizhuText.text,
//                                    } mutableCopy];
//    
//    [param setObject:goodsList forKey:@"goods"];
//    
//    __weak __typeof(self) weakSelf = self;
//    [KYServiceRequest requestPOSTWithRequestAPI:API_Order
//                                       isSecret:NO
//                                  withParameter:param
//                              withResponseClass:nil
//                               withSuccessBlock:^(id response)
//    {
//        NSString *info = response[@"info"];
//        if (info && info.length > 0)
//        {
//            weakSelf.currentPayInfo = response;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
//                                                            message:info
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else
//        {
//            CGFloat pay = [response[@"pay"] floatValue];
//            if (pay > 0)
//            {
//                weakSelf.orderCode = response[@"orderCode"];
//                [weakSelf useAlipayWithOrderCode:response[@"orderCode"]
//                                      withAmount:response[@"pay"]];
//            }
//        }
//        
//        [SVProgressHUD dismiss];
//        
//    } withErrorBlock:^(id error)
//    {
//        [SVProgressHUD showErrorWithStatus:[error description]];
//    }];
//    
//    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeClear];
}

//- (void)processPaymentWithResult:(NSDictionary *)result
//{
//    if ([result[@"resultStatus"] isEqualToString:@"9000"])
//    {
//        [self showHint:@"支付成功"];
//        
//        NSDictionary *param = @{@"optCode" : @"1",
//                                @"orderCode" : self.orderCode};
//        
//        [KYServiceRequest requestPOSTWithRequestAPI:API_Order
//                                           isSecret:NO
//                                      withParameter:param
//                                  withResponseClass:nil
//                                   withSuccessBlock:^(id response)
//        {
//            [SVProgressHUD dismiss];
//            [self popToIndexViewController];
//            
//        } withErrorBlock:^(id error)
//        {
//            [SVProgressHUD showErrorWithStatus:[error description]];
//        }];
//        
//        [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeClear];
//    }
//    else
//    {
//        [self showHint:@"支付失败"];
//        
//        NSDictionary *param = @{@"optCode" : @"34",
//                                @"orderCode" : self.orderCode};
//        
//        [KYServiceRequest requestPOSTWithRequestAPI:API_Order
//                                           isSecret:NO
//                                      withParameter:param
//                                  withResponseClass:nil
//                                   withSuccessBlock:^(id response)
//        {
//            [SVProgressHUD dismiss];
////            [self popToIndexViewController];
//            
//        } withErrorBlock:^(id error)
//        {
//            [SVProgressHUD showErrorWithStatus:[error description]];
//        }];
//        
//        [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeClear];
//    }
//}
//
//- (void)useAlipayWithOrderCode:(NSString *)orderCode withAmount:(NSString *)amount
//{
//    NSString *notifyURL = [NSString stringWithFormat:@"%@%@%@business/notify_ali.jsp",KHttp,KIP_Head,SERVER_ROOT];
//    
//    NSMutableString *description = [NSMutableString string];
//    for (KYGoodsModel *model in self.DetailArray)
//    {
//        if (description.length > 0)
//        {
//            [description appendString:@","];
//        }
//        [description appendString:model.goodsName];
//        [description appendFormat:@"(%zd份)",model.buyCount];
//    }
//    
//    Order *order = [[Order alloc] init];
//    order.tradeNO = orderCode;
//    order.productName = [NSString stringWithFormat:@"优优外卖-%@",self.sellerName];
//    order.productDescription = description;
//    order.amount = amount;
//    order.notifyURL =  notifyURL;
//    order.partner = Kpartner;
//    order.seller =  Kseller;
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    NSString *appScheme = @"University1";
//    
//    //商品信息拼接字符串
//    NSString *orderSpec = [order description];
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(KprivateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil)
//    {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        __weak __typeof(self) weakSelf = self;
//        [[AlipaySDK defaultService] payOrder:orderString
//                                  fromScheme:appScheme
//                                    callback:^(NSDictionary *resultDic)
//        {
//            [weakSelf processPaymentWithResult:resultDic];
//        }];
//    }
//}

#pragma mark - UIAlertViewDelegate

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        CGFloat pay = [self.currentPayInfo[@"pay"] floatValue];
//        if (pay > 0)
//        {
//            self.orderCode = self.currentPayInfo[@"orderCode"];
//            [self useAlipayWithOrderCode:self.currentPayInfo[@"orderCode"]
//                              withAmount:self.currentPayInfo[@"pay"]];
//        }
//        else
//        {
//            [self showHint:@"支付成功"];
//            
//            NSDictionary *param = @{@"optCode" : @"1",
//                                    @"orderCode" : self.currentPayInfo[@"orderCode"]};
//            
//            [KYServiceRequest requestPOSTWithRequestAPI:API_Order
//                                               isSecret:NO
//                                          withParameter:param
//                                      withResponseClass:nil
//                                       withSuccessBlock:^(id response)
//             {
//                 [SVProgressHUD dismiss];
//                 [self popToIndexViewController];
//                 
//             } withErrorBlock:^(id error)
//             {
//                 [SVProgressHUD showErrorWithStatus:[error description]];
//             }];
//            
//            [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeClear];
//        }
//    }
//}

#pragma mark - tableViewDelegate
//返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.DetailArray.count;
        
    }else if(section == 1){
        return 1;
    }
    else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        TKOrderConfirmationTableViewCell *cell = [TKOrderConfirmationTableViewCell cellWithTableView:tableView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        KYGoodsModel *model = self.DetailArray[indexPath.row];
        cell.model = model;

        return cell;
    }
    else if(indexPath.section == 1)
    {
        return self.lufeiCell;
    }
    else
    {
        if (indexPath.row == 0)
        {
            return self.hongbaoCell;
        }
        else
        {
            return self.diyongquanCell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.headerView endEditing:YES];
    
//    if (indexPath.section == 2)
//    {
//        if (indexPath.row == 0)
//        {
//            NSString *suffix = [NSString stringWithFormat:@"shop/redPacket.jsp?uid=%@&type=1&sellerId=%zd&redPacketId=%zd",[AppCommonConstant sharedCommonConstant].userId,self.sellerId,self.currentRedPotcketId];
//            [self pushToWebViewWithSuffix:suffix];
//        }
//        else
//        {
//            NSString *suffix = [NSString stringWithFormat:@"shop/voucher.jsp?uid=%@&type=1&sellerId=%zd&myVoucherId=%zd",[AppCommonConstant sharedCommonConstant].userId,self.sellerId,self.currentVoucherId];
//            [self pushToWebViewWithSuffix:suffix];
//        }
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIView *leftView = [UIView new];
        [leftView setBackgroundColor:[UIColor yellowColor]];
        [view addSubview:leftView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(5, 20));
            
        }];

        UILabel *label = [UILabel new];
        [label  setTextColor:[UIColor colorWithRed:0.176 green:0.153 blue:0.145 alpha:1]];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setText:@"已选商品"];
        [view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.left.equalTo(leftView.mas_right).offset(10);
        }];
        
        return view;
    }
    
    return nil;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return indexPath.section != 0 ? 44 :70;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 40 : 10;
}

//返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.discountSection.count > 0)
//    {
//        return 3;
//    }
    
    return 3;
}

@end
