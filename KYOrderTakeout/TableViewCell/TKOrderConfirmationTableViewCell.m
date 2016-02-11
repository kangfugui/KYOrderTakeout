//
//  TKOrderConfirmationTableViewCell.m
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "TKOrderConfirmationTableViewCell.h"
#import "Masonry.h"
#import "KYGoodsModel.h"

@interface TKOrderConfirmationTableViewCell()

@property(nonatomic,weak) UILabel *price;

@end

@implementation TKOrderConfirmationTableViewCell
#define COLOR(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"sub";
    TKOrderConfirmationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TKOrderConfirmationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //此处布局子控件
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.textLabel setTextColor:[UIColor colorWithRed:0.302 green:0.290 blue:0.286 alpha:1]];
        [self.detailTextLabel setTextColor:[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1]];
        
        
        UILabel *price = [UILabel new];
//        [price setText:@"18.00"];
        [price setTextColor:COLOR(255, 191, 4, 1.0)];
        price.numberOfLines = 0;
        [self addSubview:price];
        self.price = price;
        
        __block __typeof(self) weakSelf = self;
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).and.offset(-20);
//            make.bottom.equalTo(weakSelf).and.offset(-10);
            make.centerY.mas_equalTo(weakSelf);
            
        }];
    }
    return self;
}

-(void)setModel:(KYGoodsModel *)model
{
    _model = model;
    self.textLabel.text = model.goodsName;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%.02f元/份x %ld",model.priceDiscount,(long)model.buyCount];
    self.price.text = [NSString stringWithFormat:@"%.02f",model.priceDiscount * model.buyCount];
    
}

-(void)layoutSubviews
{
    __block __typeof(self) weakSelf = self;
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textLabel.mas_bottom).offset(5);
        make.bottom.equalTo(weakSelf).offset(-10);
        make.left.equalTo(weakSelf.textLabel);
    }];
    
    [super layoutSubviews];

}




@end
