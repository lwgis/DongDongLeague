//
//  Project.h
//  DongDongLeague
//
//  Created by 李炜 on 15/2/3.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *pid;
@property(strong,nonatomic)NSString *icon;
-(id)initWithPid:(NSString *)pid name:(NSString *)name icon:(NSString *)icon;
@end
