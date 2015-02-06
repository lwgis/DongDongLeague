//
//  MeViewController.m
//  DongDongLeague
//
//  Created by 李炜 on 15/2/5.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "MeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "DongDongClient.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadUserInfo{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //    [[DongDongClient sharedClient].requestSerializer setValue:@"multipart/form-data;" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            myDelegate.user.wbCurrentUserID, @"openid",
                            @"1", @"snstype",
                            nil];
    [[DongDongClient sharedClient] POST:@"users/getbyopenid" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        [self.nameLable setText:[dic valueForKey:@"name"]];
        [self.meImageView setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"thumbnail"]]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    //    [[DongDongClient sharedClient] POST:@"users/getbyopenid" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //    } success:^(NSURLSessionDataTask *task, id responseObject) {
    //
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        
    //    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
