//
//  KYFoodInfoTableViewCell.m
//  University1.0
//
//  Created by 刘成 on 15/11/11.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYFoodInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "KYNumberAdjustControl.h"
#import "KYServiceRequest.h"
#import "Masonry.h"

@interface KYFoodInfoTableViewCell ()<KYNumberAdjustControlDelegate>

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UILabel *saleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *originPriceLabel;
@property (strong, nonatomic) KYNumberAdjustControl *adjustControl;

@end

@implementation KYFoodInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    __weak __typeof(self) weakSelf = self;
    
    _iconView = [[UIImageView alloc] init];
    _iconView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.left.equalTo(@12);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"招牌套餐";
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@8);
        make.left.equalTo(_iconView.mas_right).offset(10);
    }];
    
    _saleLabel = [[UILabel alloc] init];
    _saleLabel.text = @"销量 20";
    _saleLabel.font = [UIFont systemFontOfSize:10];
    _saleLabel.textColor = [UIColor colorWithRed:0.529 green:0.533 blue:0.537 alpha:1];
    [self.contentView addSubview:_saleLabel];
    [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(_nameLabel);
         make.top.equalTo(_nameLabel.mas_bottom).offset(3);
     }];
    
    _summaryLabel = [[UILabel alloc] init];
    _summaryLabel.text = @"商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍商品介绍";
    _summaryLabel.font = [UIFont systemFontOfSize:10];
    _summaryLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_summaryLabel];
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_saleLabel.mas_bottom).offset(3);
        make.right.lessThanOrEqualTo(weakSelf.contentView).offset(-10);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"18元";
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = [UIColor colorWithRed:1.0 green:0.792 blue:0.0 alpha:1];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(_iconView);
        make.top.equalTo(_iconView.mas_bottom).offset(14);
    }];
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.text = @"/份";
    unitLabel.font = [UIFont systemFontOfSize:14];
    unitLabel.textColor = [UIColor colorWithRed:0.529 green:0.533 blue:0.537 alpha:1];
    [self.contentView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_priceLabel);
        make.left.equalTo(_priceLabel.mas_right).offset(1);
    }];
    
    _originPriceLabel = [[UILabel alloc] init];
    _originPriceLabel.text = @"原价 100";
    _originPriceLabel.font = [UIFont systemFontOfSize:10];
    _originPriceLabel.textColor = [UIColor colorWithRed:0.529 green:0.533 blue:0.537 alpha:1];
    [self.contentView addSubview:_originPriceLabel];
    [_originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.equalTo(unitLabel).offset(-1);
        make.left.equalTo(unitLabel.mas_right).offset(5);
    }];
    
    UIView *deleteLine = [[UIView alloc] init];
    deleteLine.backgroundColor = _originPriceLabel.textColor;
    [_originPriceLabel addSubview:deleteLine];
    [deleteLine mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.height.equalTo(@0.5);
        make.left.right.centerY.equalTo(_originPriceLabel);
    }];
    
    KYNumberAdjustControl *adjust = [[KYNumberAdjustControl alloc] initWithFrame:CGRectZero];
    adjust.delegate = self;
    [self.contentView addSubview:adjust];
    self.adjustControl = adjust;
    [adjust mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(adjust.bounds.size);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.bottom.equalTo(weakSelf.contentView).offset(-5);
    }];
}

- (void)configWithModel:(KYGoodsModel *)model
{
    self.nameLabel.text = model.goodsName;
    self.summaryLabel.text = model.textKey;
    self.adjustControl.currentNumber = model.buyCount;
    self.saleLabel.text = [NSString stringWithFormat:@"销量 %zd",model.volumeSales];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",model.priceDiscount];
    self.originPriceLabel.text = [NSString stringWithFormat:@"原价 %.0f元",model.priceSelling];
    self.iconView.image = [UIImage imageNamed:@"food_icon"];
}

#pragma mark - KYNumberAdjustControlDelegate

- (void)numberAdjustControl:(KYNumberAdjustControl *)control didAdjustNumber:(NSInteger)number
{
    if ([self.delegate respondsToSelector:@selector(foodInfoTableViewCell:didAdjustNumber:)])
    {
        [self.delegate foodInfoTableViewCell:self didAdjustNumber:number];
    }
}

@end
