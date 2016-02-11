//
//  KYStoreDetailView.h
//  University1.0
//
//  Created by 刘成 on 15/11/10.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYGoodsModel.h"

@interface KYStoreDetailView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *headerBackgroundImage;
@property (strong, nonatomic) UITapGestureRecognizer *headerTapGesture;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UIImageView *couponIcon;
@property (strong, nonatomic) UIImageView *backIcon;
@property (strong, nonatomic) UIButton *sellerIntroButton;
@property (strong, nonatomic) UIButton *sellerCommentButton;
@property (strong, nonatomic) UITableView *categoryTable;
@property (strong, nonatomic) UITableView *foodTable;
@property (strong, nonatomic) UIView *switchMark;

@property (strong, nonatomic) UILabel *priceSendLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UILabel *startLabel;

@end
