//
//  ViewController.m
//  DongDongLeague
//
//  Created by 李炜 on 15/1/22.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "SinaWeiboAPIClient.h"
#import "UIImageView+AFNetworking.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.user.wbCurrentUserID!=nil) {
        [self.loginButton setEnabled:NO];
        self.navigationItem.leftBarButtonItem=nil;
    }
    else{
        [self.loginButton setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginCick:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}
- (IBAction)LogoutPress:(id)sender {
}
-(void)loadWeiboUser{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString* urlString=[NSString stringWithFormat:@"2/users/show.json?access_token=%@&uid=%@",myDelegate.user.wbtoken,myDelegate.user.wbCurrentUserID];
    [[SinaWeiboAPIClient sharedClient] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *postsFromResponse =(NSDictionary* )responseObject;
        NSString* name=[postsFromResponse valueForKey:@"name"];
        NSString* avatar_large=[postsFromResponse valueForKey:@"avatar_large"];
        myDelegate.user.name=name;
        myDelegate.user.image=avatar_large;
        self.title=name;
        [self.userImageView setImageWithURL: [NSURL URLWithString:avatar_large]];
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setValue:myDelegate.user.wbCurrentUserID forKey:@"userid"];
        [ud setValue:myDelegate.user.wbtoken forKey:@"token"];
        [ud synchronize];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
@end
