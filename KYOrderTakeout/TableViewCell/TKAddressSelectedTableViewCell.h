//
//  TKAddressSelectedTableViewCell.h
//  University1.0
//
//  Created by yoyo on 15/11/25.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKAddressSelectedModel;
@interface TKAddressSelectedTableViewCell : UITableViewCell

@property(nonatomic, strong) TKAddressSelectedModel *model;

+(instancetype) cellWithTableView:(UITableView *)tableView;

-(void)setCellTextColor:(BOOL)selected;

@end
