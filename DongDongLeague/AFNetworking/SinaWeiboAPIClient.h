//
//  SinaWeiboAPIClient.h
//  DongDongLeague
//
//  Created by 李炜 on 15/1/31.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface SinaWeiboAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
