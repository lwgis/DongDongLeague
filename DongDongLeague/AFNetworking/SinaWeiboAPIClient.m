//
//  SinaWeiboAPIClient.m
//  DongDongLeague
//
//  Created by 李炜 on 15/1/31.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "SinaWeiboAPIClient.h"
static NSString * const SinaWeiboAPIBaseURLString = @"https://api.weibo.com/";

@implementation SinaWeiboAPIClient

+ (instancetype)sharedClient {
    static SinaWeiboAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SinaWeiboAPIClient alloc] initWithBaseURL:[NSURL URLWithString:SinaWeiboAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
