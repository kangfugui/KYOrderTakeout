//
//  TKOrderConfirmationHeaderView.h
//  University1.0
//
//  Created by yoyo on 15/11/12.
//  Copyright (c) 2015年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKOrderConfirmationModel;
@interface TKOrderConfirmationHeaderView : UIView

@property(nonatomic,weak) UILabel *userNameText;

@property(nonatomic,weak)UILabel *phoneText;

@property(nonatomic, weak)UIButton *aphlaButton;

@property(nonatomic,weak)UILabel *addressText;

@property(nonatomic,weak)UITextField *beizhuText;

@property(nonatomic, strong,nullable)NSDictionary   *userInfo;

-(void)updateUserInforface:(TKOrderConfirmationModel  *)userInfo;

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

//获得用户输入的备注信息方法
-(NSDictionary *)getUserInfoWithDictionary;




@end
