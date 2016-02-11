//
//  TKOrderConfirmationTableViewCell.h
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KYGoodsModel;
@interface TKOrderConfirmationTableViewCell : UITableViewCell

@property(nonatomic, strong) KYGoodsModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
