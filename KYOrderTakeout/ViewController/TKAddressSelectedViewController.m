//
//  AddressSelectedViewController.m
//  University1.0
//
//  Created by yoyo on 15/11/25.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "TKAddressSelectedViewController.h"
#import "Masonry.h"
#import "TKAddressViewController.h"
#import "TKAddressSelectedTableViewCell.h"
#import "KYServiceRequest.h"

#import "KYCustomBarItem.h"

#import "KYProgressAnimationHUD.h"
#import "SVProgressHUD.h"
#import "TKAddressSelectedModel.h"
#import "AppCommonConstant.h"

@interface TKAddressSelectedViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, copy)NSArray<TKAddressSelectedModel *> *dataSources;

@property(nonatomic, strong)NSIndexPath *indexPath;

@end

@implementation TKAddressSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择现有地址";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1]];
    self.navigationItem.leftBarButtonItem = [KYCustomBarItem backBarWithTarget:self andAction:@selector(leftBarButtonPopViewController)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
//    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutSubview];
    
    [self requestData];
    
}




-(void)leftBarButtonPopViewController{
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)popViewController{
    
    if(self.dataSources.count > 0 && self.indexPath != nil){
         TKAddressSelectedModel *model =  self.dataSources[self.indexPath.row];
        //返回数据
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"userName"] = model.userName;
        dic[@"phoneText"] = model.mobile;
        dic[@"addressText"] = model.address;
        dic[@"addrId"] = model.addrId;
        dic[@"myAddrId"] = model.myAddrId;
        
        //此处时候要发送一个通知咧
        [[NSNotificationCenter defaultCenter]postNotificationName:@"userInfo" object:self userInfo:dic];
    }

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)layoutSubview{
    
    UIView *headViewBack = [UIView new];
    [headViewBack setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headViewBack];
    
    __block __typeof(self) weakSelf = self;
    [headViewBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.size.mas_equalTo(CGSizeMake(weakSelf.view.frame.size.width, 70));
    }];
    
    UIView *labelBack = [UIView new];
    [labelBack setBackgroundColor:[UIColor whiteColor]];
    [headViewBack addSubview:labelBack];
    
    [labelBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headViewBack);
        make.right.equalTo(headViewBack);
        make.top.equalTo(headViewBack);
    }];
    
    UILabel *label = [UILabel new];
    [label setText:@"添加配送地址"];
    [label setTextColor:[UIColor colorWithRed:0.769 green:0.294 blue:0.298 alpha:1]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [labelBack addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelBack.mas_centerY);
        make.left.equalTo(labelBack.mas_left).offset(15);
    }];
    
    UIImageView *rightImage = [UIImageView new];
    [rightImage setImage:[UIImage imageNamed:@"arrow"]];
    [labelBack addSubview:rightImage];
    
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelBack.mas_centerY);
        make.right.equalTo(labelBack.mas_right).offset(-15);
        
    }];
    
    
    UIButton *headerViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerViewButton addTarget:self action:@selector(pushAddAddressController) forControlEvents:UIControlEventTouchUpInside];
    [labelBack addSubview:headerViewButton];
    
    [headerViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    UIView *separatorView = [UIView new];
    [separatorView setBackgroundColor: [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1]];
    [headViewBack addSubview:separatorView];
    
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headViewBack.mas_bottom);
        make.left.equalTo(headViewBack.mas_left).offset(0);
        make.right.equalTo(headViewBack.mas_right).offset(0);
        make.height.mas_equalTo(10);
    }];

    [labelBack mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(separatorView.mas_top);
    }];
    
    
    
    
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableView];
    self.tableView = tableView;

    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headViewBack.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);

    }];

}

#pragma mark - button
-(void)pushAddAddressController{
    TKAddressViewController *addressVC = [[TKAddressViewController alloc]init];
    [self.navigationController pushViewController:addressVC animated:YES];
}


-(void)requestData
{
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        
        TKAddressSelectedModel *model = [[TKAddressSelectedModel alloc] init];
        model.addrId = @(i);
        model.address = [NSString stringWithFormat:@"测试地址%d",i];
        model.mobile = @"18627156769";
        model.myAddrId = @(i);
        model.userId = @(100);
        model.userName = @"姓名";
        [temp addObject:model];
    }
    
    self.dataSources = temp;
    [self.tableView reloadData];
    
//    [KYServiceRequest requestPOSTWithRequestAPI:@"shop.addr.web" isSecret:NO withParameter:@{
//                                                                                             @"optCode" : @4,
//                                                                                             @"userId":@(self.userID)
//                                                                                             } withResponseClass:[TKAddressSelectedModel class] withSuccessBlock:^(id response) {
//                                                                                                 self.dataSources = response;
//                                                                                                 //获得数据，刷新tableview
//                                                                                                [self.tableView reloadData];
//                                                                                                 [KYProgressAnimationHUD dismiss];
//    } withErrorBlock:^(id error) {
//        [KYProgressAnimationHUD dismiss];
//        [SVProgressHUD showErrorWithStatus:[error description]];
//    }];

}


#pragma mark - tableviewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TKAddressSelectedTableViewCell *cell = [TKAddressSelectedTableViewCell cellWithTableView:tableView];
    
    TKAddressSelectedModel *model = self.dataSources[indexPath.row];
    
    //获得model中的地址ID与传过来的进行对比，如果相同就讲当前的cell选中
    if ([model.myAddrId intValue] == self.addressSelectedID) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView.hidden = NO;
        self.indexPath = indexPath;
    }

   cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.dataSources.count;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TKAddressSelectedTableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.indexPath];
    TKAddressSelectedTableViewCell *nowCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.indexPath != indexPath) {
        [tableView deselectRowAtIndexPath:self.indexPath animated:YES];
        [oldCell setCellTextColor:YES];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        oldCell.accessoryView.hidden = YES;
        
    }
    
    [nowCell setCellTextColor:NO];
    nowCell.accessoryType = UITableViewCellAccessoryCheckmark;
    nowCell.accessoryView.hidden = NO;
    
    self.indexPath = indexPath;
    


//   TKAddressSelectedModel *model =  self.dataSources[indexPath.row];
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"userName"] = model.userName;
//    dic[@"phoneText"] = model.mobile;
//    dic[@"addressText"] = model.address;
//    
//    //此处时候要发送一个通知咧
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"userInfo" object:self userInfo:dic];
//    
//    [self.navigationController popViewControllerAnimated:YES];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [UILabel new];
    [label  setTextColor:[UIColor colorWithRed:0.176 green:0.153 blue:0.145 alpha:1]];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setText:@"选择配送地址"];
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view.mas_left).offset(15);
    }];


    
    UIView *blackView = [UIView new];
    [blackView setBackgroundColor:[UIColor colorWithRed:0.843 green:0.843 blue:0.859 alpha:1]];
    [view addSubview:blackView];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.right.equalTo(view);
        make.left.equalTo(view).offset(15);
        make.bottom.equalTo(view.mas_bottom);
    }];
    
    return view;

}


-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

@end
