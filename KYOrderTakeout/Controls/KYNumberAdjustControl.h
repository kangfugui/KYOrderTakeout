//
//  KYNumberAdjustControl.h
//  University1.0
//
//  Created by 刘成 on 15/11/11.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KYNumberAdjustControl;

@protocol KYNumberAdjustControlDelegate <NSObject>

- (void)numberAdjustControl:(KYNumberAdjustControl *)control didAdjustNumber:(NSInteger)number;

@end

@interface KYNumberAdjustControl : UIView

@property (strong, nonatomic) UIButton *minusButton;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UILabel *numberLabel;

@property (weak, nonatomic) id<KYNumberAdjustControlDelegate> delegate;
@property (assign, nonatomic) NSInteger currentNumber;

@end
