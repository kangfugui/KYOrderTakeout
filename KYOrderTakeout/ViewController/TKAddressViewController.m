//
//  TKAddressViewController.m
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "TKAddressViewController.h"
#import "Masonry.h"
#import "KYCustomBarItem.h"
#import "KYServiceRequest.h"
#import "TKAddressTableViewCell.h"

#import "TKAddAddressViewModel.h"
#import "TKAddressSelectedViewController.h"

#import "TKOrderConfirmationViewController.h"

#import "SVProgressHUD.h"
@interface TKAddressViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, weak) UITextField *userName;

@property(nonatomic, weak) UITextField *phoneNumber;

@property(nonatomic, weak) UITextField *address;

//@property(nonatomic, weak) UITextField *beizhu;

@property(nonatomic, weak) UIButton *finishButton;

@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, copy)NSArray *dataSources;


@end

@implementation TKAddressViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加配送地址";
    
//    [self.view setBackgroundColor:[UIColor colorWithRed:243 green:243 blue:243 alpha:0.8]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = [KYCustomBarItem backBarWithTarget:self andAction:@selector(back)];
    
    [self requestData];
    
    [self layoutSubView];
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ObserverKeyboardShowAndHidden:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ObserverKeyboardShowAndHidden:) name:UIKeyboardDidHideNotification object:nil];
}


-(void)ObserverKeyboardShowAndHidden:(NSNotification *)notification{
    if (notification.name == UIKeyboardDidShowNotification) {
        self.tableView.hidden = YES;
    }else{
        self.tableView.hidden = NO;
    }

}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestData{
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        TKAddAddressViewModel *model = [[TKAddAddressViewModel alloc] init];
        model.addrId = @(i);
        model.name = [NSString stringWithFormat:@"测试地址%d",i];
        model.typeAddr = @(1);
        model.pointX = @"114";
        model.pointY = @"32";
        [temp addObject:model];
    }
    self.dataSources = temp;
    [self.tableView reloadData];
    
//    [KYServiceRequest requestPOSTWithRequestAPI:@"shop.addr.web" isSecret:NO withParameter:@{
//                                                                                @"optCode":@3
//                                                                                } withResponseClass:[TKAddAddressViewModel class] withSuccessBlock:^(id response) {
//                                                                                    self.dataSources = response;
//                                                                                    [self.tableView reloadData];
//    } withErrorBlock:^(id error) {
//        [SVProgressHUD showErrorWithStatus:[error description]];
//    }];
}



-(void)layoutSubView
{
    
    UIView *backView1 = [UIView new];
    
    [backView1 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backView1];
    
    
    __weak __typeof(self) weakSelf = self;
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(64+10);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@44);
    }];
    
    
    UILabel *name = [UILabel new];
    [name setText:@"收货人"];
    [name setTextAlignment:NSTextAlignmentLeft];
    [name setFont:[UIFont fontWithName:@"" size:25]];
    [backView1 addSubview:name];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView1.mas_centerY);
        make.left.equalTo(backView1.mas_left).offset(10);
        make.width.equalTo(@60);
    }];
    
    
    UITextField *userName = [UITextField new];
    //设置左显示
    [userName setPlaceholder:@"请输入收货人姓名"];
    [userName setFont:[UIFont systemFontOfSize:15]];
    [userName setReturnKeyType:UIReturnKeyNext];
    [userName setTextAlignment:NSTextAlignmentLeft];
    userName.delegate = self;
    [backView1 addSubview:userName];
    self.userName = userName;
    
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(10);
        make.right.equalTo(backView1.mas_right);
        make.centerY.equalTo(backView1.mas_centerY);
        make.height.equalTo(backView1.mas_height);
        
    }];
    
    
    UIView *backView2 = [UIView new];
    [backView2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backView2];

    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView1.mas_bottom).offset(2);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@44);
    }];
    
    UILabel *phoneText = [UILabel new];
    [phoneText setText:@"手机号"];
    [phoneText setFont:[UIFont fontWithName:@"" size:25]];
    [phoneText setTextAlignment:NSTextAlignmentLeft];
    [backView2 addSubview:phoneText];
    
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView2.mas_centerY);
        make.left.equalTo(backView2.mas_left).offset(10);
        make.width.equalTo(@60);
    }];

    UITextField *phoneNumber = [UITextField new];
    //设置左显示
    [phoneNumber setPlaceholder:@"请输入收货人电话号码"];
    [phoneNumber setFont:[UIFont systemFontOfSize:15]];
    [phoneNumber setKeyboardType:UIKeyboardTypeNumberPad];
    phoneNumber.delegate = self;
    [phoneNumber setReturnKeyType:UIReturnKeyNext];
    [self.view addSubview:phoneNumber];
    self.phoneNumber = phoneNumber;
    
    [phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView2.mas_right);
        make.centerY.equalTo(backView2.mas_centerY);
        make.left.equalTo(phoneText.mas_right).offset(10);
        
    }];

    UIView *backView3 = [UIView new];
    [backView3 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backView3];
    
    [backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView2.mas_bottom).offset(2);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.equalTo(@44);
    }];

    UILabel *addressText = [UILabel new];
    [addressText setText:@"配送至"];
    [addressText setFont:[UIFont fontWithName:@"" size:20]];
    [backView3 addSubview:addressText];
    
    [addressText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView3.mas_centerY);
        make.left.equalTo(backView3.mas_left).offset(10);
        make.width.equalTo(@60);
        
    }];

    UITextField *address = [UITextField new];
    //设置左显示
    [address setPlaceholder:@"请输入宿舍名/楼栋等"];
    address.delegate  = self;
    [address setFont:[UIFont systemFontOfSize:15]];
    [address setReturnKeyType:UIReturnKeyNext];
    [self.view addSubview:address];
    self.address = address;
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView3.mas_right);
        make.centerY.equalTo(backView3.mas_centerY);
        make.left.equalTo(phoneText.mas_right).offset(10);
        
    }];
    
    //备注
//    UIView *backView4 = [UIView new];
//    [backView4 setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:backView4];
//    
//    [backView4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backView3.mas_bottom).offset(2);
//        make.left.equalTo(weakSelf.view.mas_left);
//        make.right.equalTo(weakSelf.view.mas_right);
//        make.height.equalTo(@44);
//    }];
//    
//    UILabel *beizhuText = [UILabel new];
//    [beizhuText setText:@"备  注"];
//    [beizhuText setFont:[UIFont fontWithName:@"" size:20]];
//    [backView4 addSubview:beizhuText];
//    
//    [beizhuText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(backView4.mas_centerY);
//        make.left.equalTo(backView4.mas_left).offset(10);
//        make.width.equalTo(@60);
//        
//    }];
//    
//    UITextField *beizhu = [UITextField new];
//    //设置左显示
//    [beizhu setPlaceholder:@"备注信息"];
//    beizhu.delegate  = self;
//    [beizhu setReturnKeyType:UIReturnKeyDone];
//    [self.view addSubview:beizhu];
//    self.beizhu = beizhu;
//    
//    [beizhu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(backView4.mas_right);
//        make.centerY.equalTo(backView4.mas_centerY);
//        make.left.equalTo(beizhuText.mas_right).offset(10);
//        
//    }];

#define COLOR(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setBackgroundColor:COLOR(240, 197, 46, 0.8)];
    [finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    self.finishButton = finishButton;
    
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView3.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view.mas_left).offset(5);
        make.right.equalTo(weakSelf.view.mas_right).offset(-5);
        make.height.equalTo(@44);
    }];
    
    
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(finishButton.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _userName) {
        [_phoneNumber becomeFirstResponder];
    }else if (textField == _phoneNumber){
        [_address becomeFirstResponder];
    }else
//        if (textField == _address){
//        [_beizhu becomeFirstResponder];
//    } else
    {
        [self.view endEditing:YES];
    }
    
    return YES;
}


#pragma mark - button event

-(void)finishButtonClick
{
    NSString *userNameText = self.userName.text;
    NSString *phoneText = self.phoneNumber.text;
    NSString *addressText = self.address.text;
//    NSString *beizhuText = self.beizhu.text;
    
    if ([userNameText isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    
    if([phoneText isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"用户电话不能为空"];
        return;
    }
    
    if ([addressText isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"用户地址不能为空"];
        return;
    }
    
    //去除空格
    userNameText = [userNameText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    phoneText  = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    addressText = [addressText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([self.userName isFirstResponder]) {
        [self.userName resignFirstResponder];
    }else if([self.phoneNumber isFirstResponder]){
        [self.phoneNumber resignFirstResponder];
    }else if([self.address resignFirstResponder]){
        [self.address resignFirstResponder];
    }
    
    NSInteger addrId = 0;
    for (TKAddAddressViewModel *model in self.dataSources)
    {
        if ([addressText isEqualToString:model.name])
        {
            addrId = [model.addrId integerValue];
            break;
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userName"] = userNameText;
    dic[@"phoneText"] = phoneText;
    dic[@"addressText"] = addressText;
    dic[@"addrId"] = @(addrId);
    
    if ((![userNameText isEqualToString:@""]) && (![phoneText isEqualToString:@""]) &&(![addressText isEqualToString:@""])) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"userInfo" object:self userInfo:dic];
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[TKOrderConfirmationViewController class]]) {
                [self.navigationController popToViewController:viewController animated:YES];
            }
        }
    }

}

-(void)touchesBegan:(UITouch *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    
    //测试
//    TKAddressSelectedViewController *addressSelectedVC = [[TKAddressSelectedViewController alloc]init];
//    [self.navigationController pushViewController:addressSelectedVC animated:YES];
    
}


#pragma mark - uitableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TKAddressTableViewCell *cell = [TKAddressTableViewCell cellWithTableView:tableView];
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.textLabel.text = @"555555";
    
 TKAddAddressViewModel *model =   self.dataSources[indexPath.row];
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
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;

    //将选中测cell的内容设置到配送地址处
    self.address.text = str;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"选择可用地址";
}

@end
