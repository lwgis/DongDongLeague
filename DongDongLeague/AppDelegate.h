//
//  AppDelegate.h
//  DongDongLeague
//
//  Created by 李炜 on 15/1/22.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)User* user;
@end

