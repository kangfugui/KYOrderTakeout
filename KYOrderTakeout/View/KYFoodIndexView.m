//
//  KYFoodIndexView.m
//  University1.0
//
//  Created by 刘成 on 15/11/9.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYFoodIndexView.h"
#import "UIView+Helper.h"
#import "KYServiceRequest.h"
#import "UIImageView+WebCache.h"

@interface KYFoodIndexView ()<UIScrollViewDelegate>

@end

@implementation KYFoodIndexView

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
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.headerView];
    [self.headerView addSubview:self.scrollView];
    [self.headerView addSubview:self.pageControl];
}

#pragma mark - publish method

- (void)configPictureWithModelArray:(NSArray *)modelArray
{
    CGFloat width = CGRectGetWidth(_scrollView.bounds);
    CGFloat height = CGRectGetHeight(_scrollView.bounds);
    for (int i = 0; i < 3; i++)
    {
        UIImageView *itemView = [[UIImageView alloc] init];
        itemView.frame = CGRectMake(i * width, 0, width, height);
        itemView.backgroundColor = [UIColor blackColor];
        itemView.userInteractionEnabled = YES;
        itemView.tag = i;
        itemView.image = [UIImage imageNamed:[NSString stringWithFormat:@"banner%zd",i]];
        [_scrollView addSubview:itemView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
        [gesture addTarget:self action:@selector(scrollImageAction:)];
        [itemView addGestureRecognizer:gesture];
    }
    
    _scrollView.contentSize = CGSizeMake(width * 3, height);
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = index;
}

#pragma mark - event response

- (void)scrollImageAction:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(indexView:didTapScrollImageAtIndex:)])
    {
        NSInteger index = sender.view.tag;
        [self.delegate indexView:self didTapScrollImageAtIndex:index];
    }
}

#pragma mark - getters and setters

- (UIView *)headerView
{
    if (!_headerView)
    {
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = width / 2;
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    }
    
    return _headerView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    }
    
    return _tableView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.headerView.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.frame = CGRectMake(0,
                                        CGRectGetMaxY(self.headerView.bounds) - 10,
                                        CGRectGetWidth(self.bounds),
                                        10);
    }
    return _pageControl;
}

@end
