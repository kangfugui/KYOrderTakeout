//
//  KYStoreInfoTableViewCell.m
//  University1.0
//
//  Created by 刘成 on 15/11/9.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import "KYStoreInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "KYServiceRequest.h"
#import "CWStarRateView.h"
#import "Masonry.h"

@interface KYStoreInfoTableViewCell ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *saleLabel;
@property (strong, nonatomic) UILabel *startPriceLabel;
@property (strong, nonatomic) UILabel *sendPriceLabel;
@property (strong, nonatomic) UIImageView *backIcon;
@property (strong, nonatomic) UIImageView *couponIcon;
@property (strong, nonatomic) CWStarRateView *starView;
@property (strong, nonatomic) UIImageView *breakfastMark;
@property (strong, nonatomic) UIImageView *dinnerMark;
@property (strong, nonatomic) UIView *space1;
@property (strong, nonatomic) UIView *space2;
@property (strong, nonatomic) UIView *space3;

@end

@implementation KYStoreInfoTableViewCell

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
    _iconView.backgroundColor = [UIColor colorWithRed:1.0 green:0.792 blue:0.0 alpha:1];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    _iconView.contentScaleFactor = [UIScreen mainScreen].scale;
    _iconView.clipsToBounds = YES;
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.equalTo(@11);
        make.bottom.mas_equalTo(-11);
//        make.size.mas_equalTo(CGSizeMake(44, 44));
        
        make.width.equalTo(weakSelf.contentView).multipliedBy(0.2);
//        make.width.equalTo(_iconView.mas_height).multipliedBy(0.7);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.text = @"哈哈哈";
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@8);
        make.left.equalTo(_iconView.mas_right).offset(10);
    }];
    
    CGFloat starX = _iconView.frame.origin.x + [UIScreen mainScreen].bounds.size.width *0.2 + 18;
    
    _starView = [[CWStarRateView alloc] initWithFrame:CGRectMake(starX, 30, 80, 12) numberOfStars:5];
    _starView.scorePercent = 1.0;
    [self.contentView addSubview:_starView];
    
//    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_iconView.mas_right).offset(10);
//        make.top.equalTo(_nameLabel.mas_bottom);
//    }];
    
    _saleLabel = [[UILabel alloc] init];
    _saleLabel.font = [UIFont systemFontOfSize:12];
    _saleLabel.textColor = [UIColor grayColor];
    _saleLabel.text = @"销量200";
    [self.contentView addSubview:_saleLabel];
    [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(_starView.mas_right).offset(5);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
//        make.top.equalTo(_starView.mas_bottom).offset(5);
    }];
    
    _summaryLabel = [[UILabel alloc] init];
    _summaryLabel.font = [UIFont systemFontOfSize:12];
    _summaryLabel.textColor = [UIColor grayColor];
    _summaryLabel.text = @"描述描述描述描述描述描述描述描述描述描述描述描述";
    [self.contentView addSubview:_summaryLabel];
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_saleLabel.mas_bottom).offset(5);
        make.right.lessThanOrEqualTo(self.contentView).offset(-10);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.text = @"30分钟送达";
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_saleLabel.mas_bottom).offset(24);
    }];
    
    _startPriceLabel = [[UILabel alloc] init];
    _startPriceLabel.font = [UIFont systemFontOfSize:12];
    _startPriceLabel.textColor = [UIColor grayColor];
    _startPriceLabel.text = @"15元起送";
    [self.contentView addSubview:_startPriceLabel];
    [_startPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_timeLabel);
        make.left.equalTo(_timeLabel.mas_right).offset(15);
    }];
    
    _sendPriceLabel = [[UILabel alloc] init];
    _sendPriceLabel.font = [UIFont systemFontOfSize:12];
    _sendPriceLabel.textColor = [UIColor grayColor];
    _sendPriceLabel.text = @"免外送费";
    [self.contentView addSubview:_sendPriceLabel];
    [_sendPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_timeLabel);
        make.left.equalTo(_startPriceLabel.mas_right).offset(15);
    }];
    
    _backIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_backIcon];
    [_backIcon mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_timeLabel.mas_bottom).offset(5);
    }];
    
    _space1 = [[UIView alloc] init];
    [self.contentView addSubview:_space1];
    [_space1 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_backIcon);
        make.left.equalTo(_backIcon.mas_right);
        make.size.mas_equalTo(CGSizeMake(5, 15));
    }];
    
    _couponIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_couponIcon];
    [_couponIcon mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_backIcon);
        make.left.equalTo(_space1.mas_right).priorityHigh();
        make.left.equalTo(_backIcon.mas_right).priorityLow();
    }];
    
    _space2 = [[UIView alloc] init];
    [self.contentView addSubview:_space2];
    [_space2 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_backIcon);
        make.left.equalTo(_couponIcon.mas_right);
        make.size.mas_equalTo(CGSizeMake(5, 15));
    }];
    
    _breakfastMark = [[UIImageView alloc] init];
    [self.contentView addSubview:_breakfastMark];
    [_breakfastMark mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_backIcon);
        make.left.equalTo(_space2.mas_right).priorityHigh();
        make.left.equalTo(_couponIcon.mas_right).priorityLow();
    }];
    
    _space3 = [[UIView alloc] init];
    [self.contentView addSubview:_space3];
    [_space3 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_backIcon);
        make.size.mas_equalTo(CGSizeMake(5, 15));
        make.left.equalTo(_breakfastMark.mas_right);
    }];
    
    _dinnerMark = [[UIImageView alloc] init];
    [self.contentView addSubview:_dinnerMark];
    [_dinnerMark mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(_backIcon);
        make.left.equalTo(_space3.mas_right).priorityHigh();
        make.left.equalTo(_breakfastMark.mas_right).priorityLow();
    }];
    
    

}

- (void)configWithModel:(KYSellerModel *)model
{
    self.nameLabel.text = model.sellerName;
    self.summaryLabel.text = model.textKey;
    self.saleLabel.text = [NSString stringWithFormat:@"销量%zd",model.volumeSales];
    self.timeLabel.text = [NSString stringWithFormat:@"%zd分钟送达",model.timePeisong];
    self.startPriceLabel.text = [NSString stringWithFormat:@"%.1f元起送",model.moneyQisong];
    self.sendPriceLabel.text = model.moneyPeisong == 0 ? @"免配送费" : [NSString stringWithFormat:@"配送费%.1f元",model.moneyPeisong];
    self.starView.scorePercent = model.scorePingjia / 5;
    self.backIcon.image = model.hasBack ? [UIImage imageNamed:@"fan_icon"] : nil;
    self.couponIcon.image = model.hasVoucher ? [UIImage imageNamed:@"di_yong_quan_icon"] : nil;
    self.breakfastMark.image = model.hasBreakfast ? [UIImage imageNamed:@"breakfast"] : nil;
    self.dinnerMark.image = model.hasSnack ? [UIImage imageNamed:@"dinner"] : nil;
    self.iconView.image = [UIImage imageNamed:@"food_icon"];
    
    model.hasBack ? [self.contentView addSubview:self.space1] : [self.space1 removeFromSuperview];
    model.hasVoucher ? [self.contentView addSubview:self.space2] : [self.space2 removeFromSuperview];
    model.hasBreakfast ? [self.contentView addSubview:self.space3] : [self.space3 removeFromSuperview];
}

@end
