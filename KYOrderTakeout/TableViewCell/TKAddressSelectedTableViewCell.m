//
//  TKAddressSelectedTableViewCell.m
//  University1.0
//
//  Created by yoyo on 15/11/25.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "TKAddressSelectedTableViewCell.h"
#import "Masonry.h"
#import "TKAddressSelectedModel.h"
@interface TKAddressSelectedTableViewCell ()

@property(nonatomic, weak) UILabel *addressText;

@property(nonatomic, weak) UILabel *userName;

@property(nonatomic, weak) UILabel *phoneText;

@end

@implementation TKAddressSelectedTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"addressSelected";
    TKAddressSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TKAddressSelectedTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];

    }
    return cell;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //子控件创建
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *userName = [UILabel new];
        [userName setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:userName];
        self.userName = userName;
        
        UILabel *phoneText = [UILabel new];
       [phoneText setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:phoneText];
        self.phoneText = phoneText;
        
        UILabel *addressText  = [UILabel new];
        [addressText setFont:waimaiFontSize];
        [self.contentView addSubview:addressText];
        self.addressText = addressText;
        

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"AddressSelected"]];
        imageView.hidden = YES;

        self.accessoryView.hidden = YES;
        self.accessoryView = imageView;

    }
    
    
    
    return self;
}

-(void)layoutSubviews
{
        [super layoutSubviews];
    
    __block __typeof(self) weakSelf = self;
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_centerY).offset(-23);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];

    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.userName);
    }];

    [self.addressText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.userName.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.userName.mas_left);
        make.bottom.equalTo(weakSelf).offset(-10);
        
    }];
}


-(void)setModel:(TKAddressSelectedModel *)model
{
    _model = model;
    self.userName.text = model.userName;
    self.phoneText.text = model.mobile;
    self.addressText.text = model.address;

    if (self.accessoryView.hidden) {
        [self setCellTextColor:YES];
    }
}



-(void)setCellTextColor:(BOOL)selected
{
    if (selected) {
        [self.addressText setTextColor:[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1]];
        [self.phoneText setTextColor:[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1]];
        [self.userName setTextColor:[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1]];
    }else{
        [self.addressText setTextColor:[UIColor colorWithRed:0.302 green:0.290 blue:0.286 alpha:1]];
        [self.phoneText setTextColor:[UIColor colorWithRed:0.302 green:0.290 blue:0.286 alpha:1]];
        [self.userName setTextColor:[UIColor colorWithRed:0.302 green:0.290 blue:0.286 alpha:1]];
    }
   
}
@end
