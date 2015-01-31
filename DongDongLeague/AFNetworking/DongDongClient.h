//
//  DongDongClient.h
//  DongDongLeague
//
//  Created by 李炜 on 15/2/1.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "AFHTTPSessionManager.h"
static NSString * const SinaWeiboAPIBaseURLString = @"https://api.weibo.com/";

@interface DongDongClient : AFHTTPSessionManager
+ (instancetype)sharedClient;

@end
