//
//  TKOrderConfirmationHeaderView.m
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "TKOrderConfirmationHeaderView.h"
#import "Masonry.h"
#import "TKOrderConfirmationModel.h"

@interface TKOrderConfirmationHeaderView ()<UITextFieldDelegate>


@end

@implementation TKOrderConfirmationHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建控件
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self layoutSubview];
        
    }
    return self;
}


-(void)updateUserInforface:(TKOrderConfirmationModel *)userInfo
{

    
    NSString *userName = userInfo.userName;
    NSString *phoneNum = userInfo.mobile;
    NSString *address = userInfo.address;
    
        if (![userName isEqualToString:@""]) {
            [_userNameText setText:userName];
        }
        if (![phoneNum isEqualToString:@""]) {
             [_phoneText setText:phoneNum];
        }
        if (address != nil && ![address isEqualToString:@""]) {
             [_addressText setText:[@"配送地址:" stringByAppendingString:address]];
        }else {
             [_addressText setText:[@"配送地址:" stringByAppendingString:@""]];
        }

}

-(void)setUserInfo:(NSDictionary *)userInfo
{
    NSString *userName = [userInfo objectForKey:@"userName"] ;
    NSString *phoneNum = [userInfo objectForKey:@"phoneText"] ;
    NSString *address = [userInfo objectForKey:@"addressText"] ;
//    NSString *beizhu = [userInfo objectForKey:@"beizhu"];
    
    [_userNameText setText:userName];
    [_phoneText setText:phoneNum];
    
    if (address != nil || (![address isEqualToString:@""])) {
         [_addressText setText:[@"配送地址:" stringByAppendingString:address]];
    }else{
        [_addressText setText:[@"配送地址:" stringByAppendingString:@""]];
    }
    
   
//    [_beizhuText setText:[@"备注:" stringByAppendingString:beizhu]];
}


-(void)layoutSubview
{

    [self setBackgroundColor:[UIColor clearColor]];
        __weak __typeof(self) weakSelf = self;
    
    UIView *headerView = [UIView new];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
    }];
  
    
    UIImageView *userNameImage = [UIImageView new];
    [userNameImage setImage:[UIImage imageNamed:@"userIcon"]];
    [headerView addSubview:userNameImage];
    
    [userNameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.equalTo(headerView).offset(10);
        make.left.equalTo(headerView).offset(15);
    }];
    
    UILabel *userNameText = [UILabel new];
    [userNameText setFont:[UIFont systemFontOfSize:15]];
    [headerView addSubview:userNameText];
    self.userNameText = userNameText;
    [userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userNameImage);
        make.left.equalTo(userNameImage.mas_right).offset(2);
    }];


    UIImageView *phoneImage = [UIImageView new];
    [phoneImage setImage:[UIImage imageNamed:@"phoneIcon"]];
    [headerView addSubview:phoneImage];
    
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 16));
        make.left.equalTo(headerView.mas_centerX);
        make.centerY.equalTo(userNameImage.mas_centerY);
    }];
    
    UILabel *phoneText = [UILabel new];
    [phoneText setFont:[UIFont systemFontOfSize:15]];
    [headerView addSubview:phoneText];
    self.phoneText = phoneText;
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneImage.mas_centerY);
        make.top.equalTo(headerView).offset(5);
        make.left.equalTo(phoneImage.mas_right).offset(5);
    }];

    UILabel *addressText = [UILabel new];
    [addressText setTextAlignment:NSTextAlignmentLeft];
    [addressText setTextColor:[UIColor grayColor]];
    [addressText setFont:waimaiFontSize];
    [headerView addSubview:addressText];
    self.addressText = addressText;
    
    [addressText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.top.equalTo(userNameText.mas_bottom).offset(20);

        
    }];

    UIImageView *bottomimageView = [UIImageView new];
    [bottomimageView setImage:[UIImage imageNamed:@"header_bottom_image"]];
    [headerView addSubview:bottomimageView];
    
    [bottomimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left);
        make.height.equalTo(@15);
        make.top.equalTo(addressText.mas_bottom).offset(5);
        make.right.equalTo(headerView.mas_right);
    }];


    UITextField *beizhuText = [UITextField new];
    [beizhuText setPlaceholder:@"订单备注:"];
    [beizhuText setTextColor:[UIColor grayColor]];
    [beizhuText setText:@""];
    beizhuText.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [beizhuText  setFont:[UIFont systemFontOfSize:15]];
    [headerView addSubview:beizhuText];
    self.beizhuText = beizhuText;
    
    [beizhuText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.height.mas_equalTo(30);
        make.top.equalTo(bottomimageView.mas_bottom);
        make.right.equalTo(headerView);
        
    }];

    
    UIView *bottomView = [UIView new];
    [bottomView setBackgroundColor:[UIColor colorWithRed:0.784 green:0.776 blue:0.800 alpha:1]];
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    UIView *bottomView2 = [UIView new];
    [bottomView2 setBackgroundColor:[UIColor colorWithRed:0.784 green:0.776 blue:0.800 alpha:1]];
    [self addSubview:bottomView2];
    
    [bottomView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(headerView.mas_bottom);
    }];
    
    
    UIButton *aphlaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView insertSubview:aphlaButton atIndex:0];
    self.aphlaButton = aphlaButton;
    
    [aphlaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top);
        make.left.equalTo(headerView.mas_left);
        make.right.equalTo(headerView.mas_right);
        make.bottom.equalTo(bottomimageView.mas_bottom);
    }];
    
    
    UIImageView *leftImageView = [UIImageView new];
    [leftImageView setImage:[UIImage imageNamed:@"arrow"]];
    [headerView addSubview:leftImageView];
    
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView).offset(-25);
        make.right.equalTo(headerView).offset(-20);

    }];

}


-(void)view{
    [self setBackgroundColor:[UIColor clearColor]];
    __weak __typeof(self) weakSelf = self;
    
    UIView *headerView = [UIView new];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
    }];
    
    
    UIImageView *userNameImage = [UIImageView new];
    [userNameImage setImage:[UIImage imageNamed:@"userIcon"]];
    [headerView addSubview:userNameImage];
    
    [userNameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.equalTo(headerView).offset(10);
        make.left.equalTo(headerView).offset(15);
    }];
    
    UILabel *userNameText = [UILabel new];
    [userNameText setFont:waimaiFontSize];
    [self addSubview:userNameText];
    self.userNameText = userNameText;
    [userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userNameImage);
        make.left.equalTo(userNameImage.mas_right).offset(2);
    }];
    
    
    UIImageView *phoneImage = [UIImageView new];
    [phoneImage setImage:[UIImage imageNamed:@"phoneIcon"]];
    [self addSubview:phoneImage];
    
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 16));
        make.left.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(userNameImage.mas_centerY);
    }];
    
    UILabel *phoneText = [UILabel new];
    [phoneText setFont:waimaiFontSize];
    [self addSubview:phoneText];
    self.phoneText = phoneText;
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneImage.mas_centerY);
        make.top.equalTo(weakSelf).offset(5);
        make.left.equalTo(phoneImage.mas_right).offset(5);
    }];
    
    UILabel *addressText = [UILabel new];
    [addressText setTextAlignment:NSTextAlignmentLeft];
    [addressText setTextColor:[UIColor grayColor]];
    [addressText setFont:waimaiFontSize];
    [self addSubview:addressText];
    self.addressText = addressText;
    
    [addressText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(15);
        make.top.equalTo(userNameText.mas_bottom).offset(20);
        
        
    }];
    
    UIImageView *bottomimageView = [UIImageView new];
    [bottomimageView setImage:[UIImage imageNamed:@"header_bottom_image"]];
    [bottomimageView setBackgroundColor:[UIColor blueColor]];
    [self addSubview:bottomimageView];
    
    [bottomimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.height.equalTo(@10);
        make.top.equalTo(addressText.mas_bottom).offset(5);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    
    UITextField *beizhuText = [UITextField new];
    [beizhuText setPlaceholder:@"订单备注"];
    [beizhuText setTextColor:[UIColor grayColor]];
    [beizhuText setBackgroundColor:[UIColor redColor]];
    [beizhuText setText:@""];
    beizhuText.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [beizhuText  setFont:waimaiFontSize];
    [self addSubview:beizhuText];
    self.beizhuText = beizhuText;
    
    [beizhuText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(15);
        make.height.mas_equalTo(30);
        make.top.equalTo(bottomimageView.mas_bottom);
        make.right.equalTo(weakSelf);
        
    }];
    
    //    UIView *beizhuButtom = [UIView new];
    //    [beizhuButtom setBackgroundColor:[UIColor blackColor]];
    //    [self addSubview:beizhuButtom];
    //
    //    [beizhuButtom mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(beizhuText.mas_bottom);
    //        make.height.mas_equalTo(10);
    //        make.left.equalTo(weakSelf.mas_left);
    //        make.right.equalTo(weakSelf.mas_right);
    //    }];
    //
    
    UIButton *aphlaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:aphlaButton];
    [self insertSubview:aphlaButton atIndex:0];
    self.aphlaButton = aphlaButton;
    
    [aphlaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -40, 0));
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(bottomimageView.mas_bottom);
    }];
    
    
    UIImageView *leftImageView = [UIImageView new];
    [leftImageView setImage:[UIImage imageNamed:@"arrow"]];
    [self addSubview:leftImageView];
    
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf).offset(-25);
        make.right.equalTo(weakSelf).offset(-20);
        
    }];
    

}












-(NSDictionary *)getUserInfoWithDictionary
{
    NSDictionary *dic = @{
                          @"userName": self.userNameText.text,
                          @"mobile" : self.phoneText.text,
                          @"address" : self.addressText.text,
                          @"moment" : self.beizhuText.text,
                                                    };
    
    return dic;
}


-(void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.aphlaButton addTarget:target action:action forControlEvents:controlEvents];
}

-(CGSize)siezOfText:(NSString *)text font:(UIFont *)font
{
    //ios7复杂
    NSDictionary *attrbute = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size;
    
    //ios7简单
    return [text sizeWithAttributes:attrbute];
}
@end
