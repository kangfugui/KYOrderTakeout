//
//  AddressTableViewCell.h
//  University1.0
//
//  Created by yoyo on 15/11/25.
//  Copyright © 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKAddAddressViewModel;
@interface TKAddressTableViewCell : UITableViewCell

@property(nonatomic, strong)TKAddAddressViewModel *model;

+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
