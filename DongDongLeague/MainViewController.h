//
//  ViewController.h
//  DongDongLeague
//
//  Created by 李炜 on 15/1/22.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginButton;

-(void)loadWeiboUser;
@end

