//
//  AppCommonConstant.m
//  DeveplopFrameWorkV1.0
//
//  Created by kaiyitech on 14-12-2.
//  Copyright (c) 2014年 kaiyitech. All rights reserved.
//

#import "AppCommonConstant.h"

@implementation AppCommonConstant

static AppCommonConstant *sharedCommonConstant = nil;
//创建单例模式
+(AppCommonConstant *) sharedCommonConstant{
    if(sharedCommonConstant == nil){
        sharedCommonConstant = [[super allocWithZone:NULL]init];
    }
    return sharedCommonConstant;
}


-(void)setIsFirstUseCurVersionApp:(BOOL)isFirstUseCurVersionApp{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isFirstUseCurVersionApp forKey:@"isFirtUseCurVersionApp"];
    [userDefaults synchronize];
}

-(BOOL)isFirstUseCurVersionApp{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"isFirtUseCurVersionApp"];
}
@end
