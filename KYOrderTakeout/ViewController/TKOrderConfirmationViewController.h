//
//  TKOrderConfirmationViewController.h
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKOrderConfirmationViewController : UIViewController

@property(nonatomic, copy) NSArray *DetailArray;


@property(nonatomic, assign)CGFloat lufei;
@property (assign, nonatomic) CGFloat sellerDiscount;
@property (assign, nonatomic) NSInteger sellerId;
@property (copy, nonatomic) NSString *sellerName;

@end
