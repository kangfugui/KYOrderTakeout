//
//  KYFoodCategoryTableViewCell.m
//  University1.0
//
//  Created by 刘成 on 15/11/10.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYFoodCategoryTableViewCell.h"
#import "Masonry.h"

@implementation KYFoodCategoryTableViewCell

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
    
    UIView *selectionView = [[UIView alloc] init];
    selectionView.backgroundColor = [UIColor whiteColor];
    
    UIView *markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 44)];
    markView.backgroundColor = [UIColor colorWithRed:1.0 green:0.792 blue:0.0 alpha:1];
    [selectionView addSubview:markView];
    
    self.contentView.backgroundColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1];
    self.backgroundColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1];
    self.selectedBackgroundView = selectionView;
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"豪华套餐";
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@10);
        make.centerY.equalTo(weakSelf.contentView);
    }];
}

@end
