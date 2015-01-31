//
//  User.h
//  DongDongLeague
//
//  Created by 李炜 on 15/1/31.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* image;
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@end
