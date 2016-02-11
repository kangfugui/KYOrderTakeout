//
//  KYNumberAdjustControl.m
//  University1.0
//
//  Created by 刘成 on 15/11/11.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import "KYNumberAdjustControl.h"

@implementation KYNumberAdjustControl

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.width = 80;
    frame.size.height = 24;
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupViews];
        
        [self addObserver:self
               forKeyPath:@"currentNumber"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                  context:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"currentNumber" context:nil];
}

#pragma mark - observer

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"currentNumber"])
    {
        self.numberLabel.text = [NSString stringWithFormat:@"%zd",self.currentNumber];
        self.numberLabel.hidden = self.currentNumber == 0;
        self.minusButton.hidden = self.currentNumber == 0;
        
        if ([self.delegate respondsToSelector:@selector(numberAdjustControl:didAdjustNumber:)])
        {
            [self.delegate numberAdjustControl:self didAdjustNumber:self.currentNumber];
        }
    }
}

#pragma mark - event response

- (void)addButtonAction:(UIButton *)sender
{
    if (self.currentNumber < 99)
    {
        self.currentNumber += 1;
    }
}

- (void)minusButtonAction:(UIButton *)sender
{
    if (self.currentNumber > 0)
    {
        self.currentNumber -= 1;
    }
}

#pragma mark - private method

- (void)setupViews
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_minusButton setFrame:CGRectMake(0, 0, height, height)];
    [_minusButton setImage:[UIImage imageNamed:@"jian_icon"] forState:UIControlStateNormal];
    [_minusButton addTarget:self action:@selector(minusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_minusButton];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setFrame:CGRectMake(width - height, 0, height, height)];
    [_addButton setImage:[UIImage imageNamed:@"jia_icon"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    _numberLabel.text = [NSString stringWithFormat:@"%zd",_currentNumber];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    _numberLabel.textColor = [UIColor blackColor];
    _numberLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numberLabel];
}

@end
