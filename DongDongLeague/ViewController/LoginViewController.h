//
//  LoginViewController.h
//  DongDongLeague
//
//  Created by 李炜 on 15/2/1.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,WeiboSDKDelegate>
@property (weak, nonatomic) IBOutlet UITextField  *emailTv;
@property (weak, nonatomic) IBOutlet UITextField  *passwordTv;
@property (weak, nonatomic) IBOutlet UIButton     *loginButton;
@property (weak,nonatomic ) User                  *user;

@end
