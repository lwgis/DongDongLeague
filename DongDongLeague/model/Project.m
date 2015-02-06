//
//  Project.m
//  DongDongLeague
//
//  Created by 李炜 on 15/2/3.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "Project.h"

@implementation Project
@synthesize name=_name,pid=_pid,icon=_icon;
-(id)initWithPid:(NSString *)pid name:(NSString *)name icon:(NSString *)icon{
    self=[super init];
    if (self) {
        _name=name;
        _pid=pid;
        _icon=icon;
    }
    return self;
}
@end
