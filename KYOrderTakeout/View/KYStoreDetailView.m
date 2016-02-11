//
//  KYStoreDetailView.m
//  University1.0
//
//  Created by 刘成 on 15/11/10.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYStoreDetailView.h"
#import "Masonry.h"

@implementation KYStoreDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    __weak __typeof(self) weakSelf = self;
    CGFloat width = CGRectGetWidth(self.bounds);
    
    self.backgroundColor = [UIColor whiteColor];
    
    _headerBackgroundImage = [[UIImageView alloc] init];
    _headerBackgroundImage.backgroundColor = [UIColor blackColor];
    _headerBackgroundImage.userInteractionEnabled = YES;
    _headerBackgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    _headerBackgroundImage.clipsToBounds = YES;
    _headerBackgroundImage.contentScaleFactor = [UIScreen mainScreen].scale;
    _headerBackgroundImage.image = [UIImage imageNamed:@"store_banner"];
    [self addSubview:_headerBackgroundImage];
    [_headerBackgroundImage mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@64);
        make.height.equalTo(@80);
        make.left.right.equalTo(weakSelf);
    }];
    
    _headerTapGesture = [[UITapGestureRecognizer alloc] init];
    [_headerBackgroundImage addGestureRecognizer:_headerTapGesture];
    
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [_headerBackgroundImage addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _summaryLabel = [[UILabel alloc] init];
    _summaryLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _summaryLabel.numberOfLines = 3;
    _summaryLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - 100;
    _summaryLabel.font = [UIFont systemFontOfSize:12];
    _summaryLabel.textColor = [UIColor whiteColor];
    _summaryLabel.text = @"";
    [_headerBackgroundImage addSubview:_summaryLabel];
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@15);
//        make.centerY.equalTo(_headerBackgroundImage);
        make.bottom.equalTo(_headerBackgroundImage).offset(-10);
    }];
    
    _couponIcon = [[UIImageView alloc] init];
    [_couponIcon setImage:[UIImage imageNamed:@"di_yong_quan_icon"]];
    [_headerBackgroundImage addSubview:_couponIcon];
    [_couponIcon mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.equalTo(_headerBackgroundImage).offset(-50);
        make.bottom.equalTo(_headerBackgroundImage).offset(-10);
    }];
    
    _backIcon = [[UIImageView alloc] init];
    [_backIcon setImage:[UIImage imageNamed:@"fan_icon"]];
    [_headerBackgroundImage addSubview:_backIcon];
    [_backIcon mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.equalTo(_couponIcon);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.equalTo(_couponIcon.mas_right).offset(5);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] init];
    [arrow setImage:[UIImage imageNamed:@"arrow"]];
//    [arrow setAlpha:0.5];
    [_headerBackgroundImage addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(_headerBackgroundImage);
        make.right.equalTo(_headerBackgroundImage).offset(-15);
    }];
    
    UIView *switchView = [[UIView alloc] init];
    switchView.backgroundColor = [UIColor whiteColor];
    switchView.layer.borderWidth = 0.5;
    switchView.layer.borderColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1].CGColor;
    [self addSubview:switchView];
    [switchView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.height.equalTo(@36);
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(_headerBackgroundImage.mas_bottom);
    }];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(width / 2 * i, 0, width / 2, 36)];
        [button setTitle:(i == 0 ? @"商品" : @"评价") forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [switchView addSubview:button];
        
        if (i == 1)
        {
            self.sellerCommentButton = button;
        }
    }
    
    _switchMark = [[UIView alloc] init];
    _switchMark.backgroundColor = [UIColor colorWithRed:1.0 green:0.792 blue:0.0 alpha:1];
    _switchMark.frame = CGRectMake(0, 34, width / 2, 2);
    [switchView addSubview:_switchMark];
    
    _categoryTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_categoryTable setTableFooterView:[[UIView alloc] init]];
    [self addSubview:_categoryTable];
    [_categoryTable mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.width.equalTo(@80);
        make.left.equalTo(weakSelf);
        make.top.equalTo(switchView.mas_bottom);
        make.bottom.equalTo(weakSelf).offset(-49);
    }];
    
    _foodTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_foodTable setTableFooterView:[[UIView alloc] init]];
    [self addSubview:_foodTable];
    [_foodTable mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(_categoryTable);
        make.top.equalTo(switchView.mas_bottom);
        make.left.equalTo(_categoryTable.mas_right);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithRed:0.184 green:0.188 blue:0.192 alpha:1];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.height.equalTo(@49);
        make.left.bottom.right.equalTo(weakSelf);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"0元";
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = [UIColor colorWithRed:1.0 green:0.835 blue:0.0 alpha:1];
    [bottomView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@15);
        make.centerY.equalTo(bottomView);
    }];
    
    _priceSendLabel = [[UILabel alloc] init];
    _priceSendLabel.text = @"免费配送";
    _priceSendLabel.textColor = [UIColor whiteColor];
    _priceSendLabel.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:_priceSendLabel];
    [_priceSendLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.equalTo(_priceLabel).offset(-2);
        make.left.equalTo(_priceLabel.mas_right).offset(2);
    }];
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.835 blue:0.0 alpha:1];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _submitButton.hidden = YES;
    [_submitButton setTitle:@"选好了" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_submitButton setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]
                        forState:UIControlStateHighlighted];
    [bottomView addSubview:_submitButton];
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(85, 35));
        make.right.equalTo(bottomView).offset(-15);
    }];
    
    _startLabel = [[UILabel alloc] init];
    _startLabel.text = @"20元起送";
    _startLabel.font = [UIFont systemFontOfSize:12];
    _startLabel.textColor = [UIColor whiteColor];
    [bottomView addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(bottomView);
        make.right.equalTo(bottomView).offset(-15);
    }];
}

#pragma mar - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    CGFloat width = CGRectGetWidth(self.bounds) / 2;
    
    [UIView animateWithDuration:0.25 animations:^
    {
        self.switchMark.frame = CGRectMake(index * width, 34, width, 2);
    }];
}

@end
