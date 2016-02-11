//
//  AddressTableViewCell.m
//  University1.0
//
//  Created by yoyo on 15/11/25.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "TKAddressTableViewCell.h"
#import "TKAddAddressViewModel.h"

@implementation TKAddressTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView

{
    static NSString *ID = @"address";
    TKAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TKAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //创建子控件
        self.textLabel.textColor  = [UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1];
    }
    
    return self;
}


-(void)setModel:(TKAddAddressViewModel *)model
{
    _model = model;
    self.textLabel.text = model.name;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //子控件布局
}


@end
