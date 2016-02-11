//
//  KYStoreListViewController.m
//  University1.0
//
//  Created by 刘成 on 15/11/9.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYStoreListViewController.h"
#import "KYStoreDetailViewController.h"
#import "KYStoreInfoTableViewCell.h"
#import "KYProgressAnimationHUD.h"
#import "AppCommonConstant.h"
#import "KYServiceRequest.h"
#import "KYCustomBarItem.h"
#import "SVProgressHUD.h"

@interface KYStoreListViewController ()

@property(nonatomic, strong) NSMutableArray *requestDatas;

@end

@implementation KYStoreListViewController

#pragma mark - life cycle

- (instancetype)init
{
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"商家列表";
    self.requestDatas = [[NSMutableArray alloc] init];
    
    self.navigationItem.leftBarButtonItem = [KYCustomBarItem backBarWithTarget:self andAction:@selector(backBarAction:)];
    
    [self.tableView registerClass:[KYStoreInfoTableViewCell class]
           forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self requsetData];
}

-(void)requsetData
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
        [self.requestDatas addObject:seller];
    }
    
    [self.tableView reloadData];

    
//    NSString *uid = [AppCommonConstant sharedCommonConstant].userId;
//    
//    [KYServiceRequest requestPOSTWithRequestAPI:API_TakeOut
//                                       isSecret:NO
//                                  withParameter:@{@"optCode": @"3", @"userId" : uid}
//                              withResponseClass:nil
//                               withSuccessBlock:^(id response)
//    {
//        NSArray *sellerModels = [KYSellerModel arrayOfModelsFromDictionaries:response[@"sellers"]];
//        [self.requestDatas addObjectsFromArray:sellerModels];
//        [self.tableView reloadData];
//        [KYProgressAnimationHUD dismiss];
//        
//    } withErrorBlock:^(id error)
//    {
//        [KYProgressAnimationHUD dismiss];
//        [SVProgressHUD showErrorWithStatus:[error description]];
//    }];
//    
//    [KYProgressAnimationHUD show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.requestDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KYStoreInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"
                                                                     forIndexPath:indexPath];
    
    //----------------------taokan ------2015 11.13 添加以下代码------------------/
    [cell configWithModel:self.requestDatas[indexPath.row]];
    
    //----------------------taokan ------2015 11.13 添加以下代码------------------/
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KYSellerModel *seller = self.requestDatas[indexPath.row];
    
    KYStoreDetailViewController *detail = [[KYStoreDetailViewController alloc] init];
    detail.title = seller.sellerName;
    detail.sellerId = seller.sellerId;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - event response

- (void)backBarAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
