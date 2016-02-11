//
//  KYFoodIndexView.h
//  University1.0
//
//  Created by 刘成 on 15/11/9.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYImageModel.h"

@class KYFoodIndexView;

@protocol KYFoodIndexViewDelegate <NSObject>

- (void)indexView:(KYFoodIndexView *)view didTapScrollImageAtIndex:(NSInteger)index;

@end

@interface KYFoodIndexView : UIView

@property (weak, nonatomic) id<KYFoodIndexViewDelegate> delegate;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

- (void)configPictureWithModelArray:(NSArray *)modelArray;

@end
