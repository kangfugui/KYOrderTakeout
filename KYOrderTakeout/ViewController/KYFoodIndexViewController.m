//
//  KYFoodIndexViewController.m
//  University1.0
//
//  Created by 刘成 on 15/11/9.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYFoodIndexViewController.h"
#import "KYStoreDetailViewController.h"
#import "KYStoreListViewController.h"
#import "KYStoreInfoTableViewCell.h"
#import "KYProgressAnimationHUD.h"
#import "NewWebViewController.h"
#import "AppCommonConstant.h"
#import "KYServiceRequest.h"
#import "KYFoodIndexView.h"
#import "KYCustomBarItem.h"
#import "SVProgressHUD.h"
#import "ServerConfig.h"
#import "Masonry.h"

@interface KYFoodIndexViewController ()<UITableViewDataSource,UITableViewDelegate,KYFoodIndexViewDelegate>

@property (strong, nonatomic) KYFoodIndexView *indexView;
@property (strong, nonatomic) UITableViewCell *redBagCell;
@property (strong, nonatomic) UITableViewCell *couponCell;

@property (strong, nonatomic) NSMutableArray<KYSellerModel *> *orderHistoryArray;
@property (strong, nonatomic) NSMutableArray<KYSellerModel *> *hotStoreArray;
@property (copy, nonatomic) NSArray *images;

@property (strong, nonatomic) NSTimer *autoScrollTimer;

@end

@implementation KYFoodIndexViewController

#pragma mark - life cycle

- (void)loadView
{
    [super loadView];
    
    self.indexView = [[KYFoodIndexView alloc] initWithFrame:self.view.frame];
    self.view = self.indexView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"优优外卖";
    self.orderHistoryArray = [[NSMutableArray alloc] init];
    self.hotStoreArray = [[NSMutableArray alloc] init];
    self.indexView.delegate = self;
    
    self.indexView.tableView.delegate = self;
    self.indexView.tableView.dataSource = self;
    [self.indexView.tableView registerClass:[KYStoreInfoTableViewCell class]
                     forCellReuseIdentifier:@"reuseIdentifier"];
    
    [self beganRequest];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivePushToSellerNotifacation:) name:@"pushToSellerNotifacation" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"pushToSellerNotifacation"
                                                  object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addTimer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeTimer];
}

#pragma mark - notification

- (void)receivePushToSellerNotifacation:(NSNotification *)notifation
{
    NSDictionary *info = notifation.userInfo;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        KYStoreDetailViewController *storeVC = [[KYStoreDetailViewController alloc]init];
        storeVC.sellerId = [info[@"sellerId"] integerValue];
        [self.navigationController pushViewController:storeVC animated:YES];
    });
}

#pragma mark - timer

- (void)nextImage:(NSTimer *)sender
{
    NSInteger page = self.indexView.pageControl.currentPage;
    if (page == (self.indexView.pageControl.numberOfPages - 1)) {
        page = 0;
    } else {
        page++;
    }
    
    CGFloat x = page * self.indexView.scrollView.frame.size.width;
    self.indexView.pageControl.currentPage = page;
    [self.indexView.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)addTimer
{
    [self.autoScrollTimer invalidate];
    self.autoScrollTimer = nil;
    
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                            target:self
                                                          selector:@selector(nextImage:)
                                                          userInfo:nil
                                                           repeats:YES];
}

- (void)removeTimer
{
    [self.autoScrollTimer invalidate];
}

#pragma mark - KYFoodIndexViewDelegate

- (void)indexView:(KYFoodIndexView *)view didTapScrollImageAtIndex:(NSInteger)index
{
    KYImageModel *image = self.images[index];
    
    if ([image.imgUrl hasPrefix:@"takeout"])
    {
        NSString *sid = [image.imgUrl componentsSeparatedByString:@"="].lastObject;
        
        KYStoreDetailViewController *detail = [[KYStoreDetailViewController alloc] init];
        detail.sellerId = [sid integerValue];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (!image.imgUrl || image.imgUrl.length == 0)
    {
        
    }
    else
    {
        NSString *suffix = [NSString stringWithFormat:@"%@&uid=%@",image.imgUrl,[AppCommonConstant sharedCommonConstant].userId];
        [self pushToWebViewWithSuffix:suffix];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else if (section == 1)
    {
        return self.orderHistoryArray.count;
    }
    else
    {
        return self.hotStoreArray.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 44 : 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) return nil;
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 35);
    view.backgroundColor = [UIColor whiteColor];
    view.tag = section;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:0.784 green:0.776 blue:0.8 alpha:1];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.height.equalTo(@0.5);
        make.left.top.right.equalTo(view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(headerTapAction:)];
    [view addGestureRecognizer:tap];
    
    UIView *mark = [[UIView alloc] init];
    mark.backgroundColor = [UIColor colorWithRed:1.0 green:0.792 blue:0.0 alpha:1];
    [view addSubview:mark];
    [mark mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(2, 20));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = section == 1 ? @"我的订单" : @"外卖商家";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@12);
        make.centerY.equalTo(view);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] init];
    [arrow setImage:[UIImage imageNamed:@"arrow"]];
    [view addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-15);
    }];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return indexPath.row == 0 ? self.redBagCell : self.couponCell;
    }
    else if (indexPath.section == 1)
    {
        KYStoreInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"
                                                                         forIndexPath:indexPath];
        
        KYSellerModel *model = self.orderHistoryArray[indexPath.row];
        [cell configWithModel:model];
        
        return cell;
    }
    else
    {
        KYStoreInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"
                                                                         forIndexPath:indexPath];
        
        KYSellerModel *model = self.hotStoreArray[indexPath.row];
        [cell configWithModel:model];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KYSellerModel *seller;
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            NSString *suffix = [NSString stringWithFormat:@"shop/redPacket.jsp?uid=%@&type=1&sellerId=0",[AppCommonConstant sharedCommonConstant].userId];
            [self pushToWebViewWithSuffix:suffix];
        }
        else if (indexPath.row == 1)
        {
            NSString *suffix = [NSString stringWithFormat:@"shop/voucher.jsp?uid=%@&type=1&sellerId=0",[AppCommonConstant sharedCommonConstant].userId];
            [self pushToWebViewWithSuffix:suffix];
        }
        
        return;
    }
    else if (indexPath.section == 1)
    {
        seller = self.orderHistoryArray[indexPath.row];
    }
    else
    {
        seller = self.hotStoreArray[indexPath.row];
    }
    
    KYStoreDetailViewController *detail = [[KYStoreDetailViewController alloc] init];
    detail.title = seller.sellerName;
    detail.sellerId = seller.sellerId;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - event response

- (void)headerTapAction:(UITapGestureRecognizer *)sender
{
    if (sender.view.tag == 1)
    {
        NSString *suffix = [NSString stringWithFormat:@"shop/takeoutOrder.jsp?uid=%@",[AppCommonConstant sharedCommonConstant].userId];
        [self pushToWebViewWithSuffix:suffix];
    }
    else if (sender.view.tag == 2)
    {
        KYStoreListViewController *list = [[KYStoreListViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
    }
}

#pragma mark - private method

- (void)pushToWebViewWithSuffix:(NSString *)suffix
{
    NewWebViewController *newWeb = [[NewWebViewController alloc] init];
    newWeb.stringUrl = kFullWebViewURL(suffix);
    [self.navigationController pushViewController:newWeb animated:YES];
}

- (void)beganRequest
{
    for (int i = 0; i < 10; i++) {
        
        KYSellerModel *seller = [[KYSellerModel alloc] init];
        seller.discount = 5.0f;
        seller.hasBack = YES;
        seller.hasBreakfast = YES;
        seller.hasSnack = YES;
        seller.hasVoucher = YES;
        seller.hotNums = 8;
        seller.moneyPeisong = 5;
        seller.moneyQisong = 20;
        seller.scorePingjia = 5;
        seller.sellerId = 1;
        seller.sellerName = @"测试数据1";
        seller.textInfo = @"efgewgje";
        seller.textKey = @"vsgjoirejhi";
        seller.timePeisong = 30;
        seller.volumeSales = 10;
        [self.hotStoreArray addObject:seller];
        [self.orderHistoryArray addObject:seller];
    }
    
    [self.indexView.tableView reloadData];
    [self.indexView configPictureWithModelArray:nil];
    
//    NSDictionary *param = @{@"optCode" : @"9",
//                            @"userId" : [AppCommonConstant sharedCommonConstant].userId};
//    [KYServiceRequest requestPOSTWithRequestAPI:API_TakeOut
//                                       isSecret:NO
//                                  withParameter:param
//                              withResponseClass:nil
//                               withSuccessBlock:^(id response)
//    {
//        self.images = [KYImageModel arrayOfModelsFromDictionaries:response[@"banners"]];
//        [self.indexView configPictureWithModelArray:self.images];
//        
//        NSInteger redCount = [response[@"redPackets"] integerValue];
//        if (redCount > 0)
//        {
//            self.redBagCell.detailTextLabel.text = [NSString stringWithFormat:@"你有%zd个红包",redCount];
//        }
//        
//        NSInteger vouchers = [response[@"vouchers"] integerValue];
//        NSInteger near = [response[@"nearVouchers"] integerValue];
//        
//        NSMutableString *string = [NSMutableString stringWithString:@""];
//        
//        if (redCount == 0)
//        {
//            [string appendString:@"你有"];
//        }
//        
//        if (near > 0)
//        {
//            [string appendFormat:@"%zd个抵用券即将到期",near];
//        }
//        else if (vouchers > 0)
//        {
//            [string appendFormat:@"%zd个抵用券尚未使用",vouchers];
//        }
//        else
//        {
//            [string setString:@""];
//        }
//        
//        self.couponCell.detailTextLabel.text = string;
//        
//        NSArray *sellerModels = [KYSellerModel arrayOfModelsFromDictionaries:response[@"recommend"]];
//        NSArray *historyModels = [KYSellerModel arrayOfModelsFromDictionaries:response[@"record"]];
//        
//        [self.hotStoreArray addObjectsFromArray:sellerModels];
//        [self.orderHistoryArray addObjectsFromArray:historyModels];
//        [self.indexView.tableView reloadData];
//        [KYProgressAnimationHUD dismiss];
//        [self addTimer];
//        
//    } withErrorBlock:^(id error)
//    {
//        [KYProgressAnimationHUD dismiss];
//        [SVProgressHUD showErrorWithStatus:[error description]];
//    }];
//    
//    [KYProgressAnimationHUD show];
}

- (UITableViewCell *)createCellWithTitle:(NSString *)title image:(UIImage *)image
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    UIImageView *icon = [[UIImageView alloc] init];
    [icon setImage:image];
    [cell.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(cell.contentView);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(icon.mas_right).offset(5);
    }];
    
    return cell;
}

#pragma mark - getters and setters

- (UITableViewCell *)redBagCell
{
    if (!_redBagCell)
    {
        _redBagCell = [self createCellWithTitle:@"红包" image:[UIImage imageNamed:@"hong_bao_icon"]];
        _redBagCell.detailTextLabel.text = @"你有1个红包";
    }
    
    return _redBagCell;
}

- (UITableViewCell *)couponCell
{
    if (!_couponCell)
    {
        _couponCell = [self createCellWithTitle:@"抵用券" image:[UIImage imageNamed:@"di_yong_quan_icon_h"]];
        _couponCell.detailTextLabel.text = @"你有1个抵用券尚未使用";
    }
    return _couponCell;
}

@end
