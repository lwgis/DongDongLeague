//
//  DongDongClient.m
//  DongDongLeague
//
//  Created by 李炜 on 15/2/1.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "DongDongClient.h"
static NSString * const DongDongBaseURLString = @"https://api.weibo.com/";

@implementation DongDongClient
+ (instancetype)sharedClient {
    static DongDongClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DongDongClient alloc] initWithBaseURL:[NSURL URLWithString:DongDongBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}
@end
