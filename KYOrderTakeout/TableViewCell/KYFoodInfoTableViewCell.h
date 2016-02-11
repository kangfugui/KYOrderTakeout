//
//  KYFoodInfoTableViewCell.h
//  University1.0
//
//  Created by 刘成 on 15/11/11.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYGoodsModel.h"

@class KYFoodInfoTableViewCell;

@protocol KYFoodInfoTableViewCellDelegate <NSObject>

- (void)foodInfoTableViewCell:(KYFoodInfoTableViewCell *)cell didAdjustNumber:(NSInteger)number;

@end

@interface KYFoodInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) id<KYFoodInfoTableViewCellDelegate> delegate;

- (void)configWithModel:(KYGoodsModel *)model;

@end
