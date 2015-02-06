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
#import "DongDongClient.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadWeiboUser];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *projectid=[ud valueForKey:@"projectid"];
    NSString *projectName=[ud valueForKey:@"projectname"];
    if (projectid==nil||[projectid isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"SelectProject" sender:self];
    }
    else{
        [self.projectTypeBtn setTitle:projectName forState:UIControlStateNormal];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 加载微博信息
 */
-(void)loadWeiboUser{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString* urlString=[NSString stringWithFormat:@"2/users/show.json?access_token=%@&uid=%@",myDelegate.user.wbtoken,myDelegate.user.wbCurrentUserID];
    [[SinaWeiboAPIClient sharedClient] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *postsFromResponse =(NSDictionary* )responseObject;
        NSString* name=[postsFromResponse valueForKey:@"name"];
        NSString* avatar_large=[postsFromResponse valueForKey:@"avatar_large"];
        myDelegate.user.name=name;
        myDelegate.user.image=avatar_large;
        self.navigationItem.title=name;
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setValue:myDelegate.user.wbCurrentUserID forKey:@"userid"];
        [ud setValue:myDelegate.user.wbtoken forKey:@"token"];
        [ud synchronize];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
-(void)loadUserInfo{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [[DongDongClient sharedClient].requestSerializer setValue:@"multipart/form-data;" forHTTPHeaderField:@"Content-Type"];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            myDelegate.user.wbCurrentUserID, @"openid",
                            @"1", @"snstype",
                            nil];
    [[DongDongClient sharedClient] POST:@"users/getbyopenid" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
//    [[DongDongClient sharedClient] POST:@"users/getbyopenid" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
}
- (IBAction)projectTypePress:(id)sender {
    [self performSegueWithIdentifier:@"SelectProject" sender:self];
}
@end
