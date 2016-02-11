//
//  KYStoreDetailViewController.m
//  University1.0
//
//  Created by 刘成 on 15/11/10.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYStoreDetailViewController.h"
#import "TKOrderConfirmationViewController.h"
#import "KYFoodCategoryTableViewCell.h"
#import "KYFoodInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "KYProgressAnimationHUD.h"
#import "NewWebViewController.h"
#import "AppCommonConstant.h"
#import "KYStoreDetailView.h"
#import "KYServiceRequest.h"
#import "KYGoodsListModel.h"
#import "KYCustomBarItem.h"
#import "SVProgressHUD.h"
#import "KYSellerModel.h"
#import "JSONModel.h"

@interface KYStoreDetailViewController ()<UITableViewDataSource,UITableViewDelegate,KYFoodInfoTableViewCellDelegate>

@property (strong, nonatomic) KYStoreDetailView *detailView;
@property (strong, nonatomic) KYSellerModel *sellerModel;
@property (strong, nonatomic) NSMutableArray<KYGoodsListModel *> *goodsModelArray;
@property (strong, nonatomic) NSMutableArray<NSString *> *categoryArray;

@end

@implementation KYStoreDetailViewController

#pragma mark - life cycle

- (void)loadView
{
    [super loadView];
    
    self.detailView = [[KYStoreDetailView alloc] initWithFrame:self.view.frame];
    self.view = self.detailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.categoryArray = [[NSMutableArray alloc] init];
    self.goodsModelArray = [[NSMutableArray alloc] init];
    
    self.navigationItem.leftBarButtonItem = [KYCustomBarItem backBarWithTarget:self andAction:@selector(backBarAction:)];
    
    [self.detailView.submitButton addTarget:self
                                     action:@selector(submitButtonAction:)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.detailView.sellerCommentButton addTarget:self
                                            action:@selector(commentButtonAction:)
                                  forControlEvents:UIControlEventTouchUpInside];
    
    [self.detailView.headerTapGesture addTarget:self action:@selector(headerTapAction:)];
    
    self.detailView.categoryTable.delegate = self;
    self.detailView.categoryTable.dataSource = self;
    [self.detailView.categoryTable registerClass:[KYFoodCategoryTableViewCell class]
                          forCellReuseIdentifier:@"categoryIdentifier"];
    
    self.detailView.foodTable.delegate = self;
    self.detailView.foodTable.dataSource = self;
    [self.detailView.foodTable registerClass:[KYFoodInfoTableViewCell class]
                      forCellReuseIdentifier:@"foodIdentifier"];
    
    self.title = @"测试";
    self.detailView.summaryLabel.text = @"测试fefgewf";
    self.detailView.couponIcon.hidden = NO;
    self.detailView.backIcon.hidden = NO;
    self.detailView.priceSendLabel.text = @"免费配送";
    self.detailView.startLabel.text = @"20元起送";
    
    [self testData];
    [self.detailView.categoryTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                               animated:YES
                                         scrollPosition:UITableViewScrollPositionNone];
    
//    NSDictionary *param = @{@"sellerId" : @(self.sellerId),
//                            @"optCode" : @"4",
//                            @"userId" : [AppCommonConstant sharedCommonConstant].userId};
//    [KYServiceRequest requestPOSTWithRequestAPI:API_TakeOut
//                                       isSecret:NO
//                                  withParameter:param
//                              withResponseClass:nil
//                               withSuccessBlock:^(id response)
//    {
//        NSDictionary *seller = response[@"sellerDetail"];
//        NSArray *discount = response[@"discountGoods"];
//        NSArray *goods = response[@"goods"];
//
//        self.sellerModel = [[KYSellerModel alloc] initWithDictionary:seller error:nil];
//        NSArray *goodsModels = [KYGoodsModel arrayOfModelsFromDictionaries:goods];
//        NSArray *discountModels = [KYGoodsModel arrayOfModelsFromDictionaries:discount];
//        
//        [self.detailView.headerBackgroundImage sd_setImageWithURL:[NSURL URLWithString:kFullImageURL(self.sellerModel.picBanner)]];
//        
//        [self configDataWithModels:goodsModels andDiscount:discountModels];
//        [self.detailView.foodTable reloadData];
//        [self.detailView.categoryTable reloadData];
//        
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableView == self.detailView.categoryTable ? 1 : self.goodsModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.detailView.categoryTable)
    {
        return self.categoryArray.count;
    }
    else
    {
        return self.goodsModelArray[section].goodsList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView == self.detailView.categoryTable ? 44 : 92;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView == self.detailView.categoryTable ? 0 : 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.detailView.foodTable)
    {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(12, 0, 100, 20);
        label.text = [NSString stringWithFormat:@"%@(%zd)",self.goodsModelArray[section].sortName,self.goodsModelArray[section].goodsList.count];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        [headerView addSubview:label];
        
        return headerView;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.detailView.categoryTable)
    {
        KYFoodCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryIdentifier" forIndexPath:indexPath];
        
        cell.nameLabel.text = self.categoryArray[indexPath.row];
        
        return cell;
    }
    else
    {
        KYFoodInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodIdentifier"
                                                                        forIndexPath:indexPath];
        
        KYGoodsModel *model = self.goodsModelArray[indexPath.section].goodsList[indexPath.row];
        [cell configWithModel:model];
        [cell setDelegate:self];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.detailView.foodTable)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.detailView.foodTable scrollToRowAtIndexPath:path
                                         atScrollPosition:UITableViewScrollPositionTop
                                                 animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.detailView.foodTable)
    {
        NSIndexPath *path = self.detailView.foodTable.indexPathsForVisibleRows.firstObject;
        NSIndexPath *select = [NSIndexPath indexPathForRow:path.section inSection:0];
        
        if (select.row != self.detailView.categoryTable.indexPathForSelectedRow.row)
        {
            [self.detailView.categoryTable selectRowAtIndexPath:select
                                                       animated:YES
                                                 scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

#pragma mark - KYFoodInfoTableViewCellDelegate

- (void)foodInfoTableViewCell:(KYFoodInfoTableViewCell *)cell didAdjustNumber:(NSInteger)number
{
    NSIndexPath *indexPath = [self.detailView.foodTable indexPathForCell:cell];
    
    if (indexPath)
    {
        KYGoodsModel *model = self.goodsModelArray[indexPath.section].goodsList[indexPath.row];
        
        model.buyCount = number;
        [self calcMoney];
    }
}

#pragma mark - private method

- (void)testData
{
    for (int i = 0; i < 10; i++) {
        
        NSString *str = [NSString stringWithFormat:@"测试%d",i];
        [self.categoryArray addObject:str];
        
        KYGoodsListModel *list = [[KYGoodsListModel alloc] init];
        list.sortId = i;
        list.sortName = str;
        [self.goodsModelArray addObject:list];
        
        for (int j = 0; j < 8; j++) {
            
            KYGoodsModel *goodsModel = [[KYGoodsModel alloc] init];
            goodsModel.goodsId = (i+j);
            goodsModel.goodsName = @"测试aa";
            goodsModel.offShelve = 1;
            goodsModel.priceDiscount = 10;
            goodsModel.priceSelling = 12;
            goodsModel.sellerId = 100;
            goodsModel.sortId = list.sortId;
            goodsModel.sortName = list.sortName;
            goodsModel.textKey = @"egegiojoi";
            goodsModel.volumeSales = 100;
            [list.goodsList addObject:goodsModel];
        }
    }
}

- (void)pushToWebViewWithSuffix:(NSString *)suffix
{
    NewWebViewController *newWeb = [[NewWebViewController alloc] init];
    newWeb.stringUrl = kFullWebViewURL(suffix);
    [self.navigationController pushViewController:newWeb animated:YES];
}

- (void)calcMoney
{
    CGFloat money = 0;
    
    for (KYGoodsListModel *list in self.goodsModelArray)
    {
        for (KYGoodsModel *model in list.goodsList)
        {
            money += ((model.priceDiscount == 0 ? model.priceSelling : model.priceDiscount) *
                      model.buyCount);
        }
    }
    
    self.detailView.priceLabel.text = [NSString stringWithFormat:@"%.2f元",money];
    self.detailView.submitButton.hidden = money < 20;
    self.detailView.startLabel.hidden = money >= 20;
}

- (void)configDataWithModels:(NSArray *)models andDiscount:(NSArray *)discountModels
{
    if (discountModels)
    {
        KYGoodsListModel *discountList = [[KYGoodsListModel alloc] init];
        discountList.sortName = @"今日特价";
        [discountList.goodsList addObjectsFromArray:discountModels];
        
        [self.goodsModelArray addObject:discountList];
        [self.categoryArray addObject:@"今日特价"];
    }
    
    for (KYGoodsModel *model in models)
    {
        KYGoodsListModel *last = self.goodsModelArray.lastObject;
        
        if (last && [last.sortName isEqualToString:model.sortName])
        {
            [last.goodsList addObject:model];
        }
        else
        {
            KYGoodsListModel *list = [[KYGoodsListModel alloc] init];
            list.sortId = model.sortId;
            list.sortName = model.sortName;
            [list.goodsList addObject:model];
            
            [self.goodsModelArray addObject:list];
            [self.categoryArray addObject:model.sortName];
        }
    }
}

#pragma mark - event response

- (void)headerTapAction:(UITapGestureRecognizer *)sender
{
//    NSString *suffix = [NSString stringWithFormat:@"shop/takeoutDetail.jsp?uid=%@&sellerId=%zd",[AppCommonConstant sharedCommonConstant].userId,self.sellerId];
//    [self pushToWebViewWithSuffix:suffix];
}

- (void)commentButtonAction:(id)sender
{
//    NSString *suffix = [NSString stringWithFormat:@"shop/takeoutReply.jsp?uid=%@&sellerId=%zd",[AppCommonConstant sharedCommonConstant].userId,self.sellerId];
//    [self pushToWebViewWithSuffix:suffix];
}

- (void)submitButtonAction:(id)sender
{
    NSMutableArray *orders = [NSMutableArray array];
    
    for (KYGoodsListModel *list in self.goodsModelArray)
    {
        for (KYGoodsModel *model in list.goodsList)
        {
            if (model.buyCount > 0)
            {
                [orders addObject:model];
            }
        }
    }
    
    if (orders.count == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择一样商品"];
        return;
    }
    
    TKOrderConfirmationViewController *confir = [[TKOrderConfirmationViewController alloc] init];
    confir.DetailArray = orders;
    confir.lufei = self.sellerModel.moneyPeisong;
    confir.sellerDiscount = self.sellerModel.discount;
    confir.sellerId = self.sellerId;
    confir.sellerName = self.sellerModel.sellerName;
    [self.navigationController pushViewController:confir animated:YES];
}

- (void)backBarAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
