//
//  LoginViewController.m
//  DongDongLeague
//
//  Created by 李炜 on 15/2/1.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "LoginViewController.h"
#import "MessageView.h"
#import "AppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    self.user=appDelegate.user;
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"loginButton_s"] forState:UIControlStateHighlighted];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.emailTv.delegate=self;
    self.passwordTv.delegate=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)weiboLoginPress:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.emailTv) {
        [self.emailTv resignFirstResponder];
        [self.passwordTv becomeFirstResponder];
    }
    if (textField==self.passwordTv) {
        if (![self validateEmail:self.emailTv.text]) {
            MessageView *mv=[MessageView messageViewWithMessageText:@"邮箱格式不正确！"];
            [mv show];

            [self.passwordTv resignFirstResponder];
            [self.emailTv becomeFirstResponder];
        }
    }
    return YES;
}
/**
验证邮箱格式
 @param candidate 邮箱字符串
 @return 如果是邮箱地址返回Yes，否则No
*/
- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}
#pragma mark -WBDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.user.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.user.wbCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        //        NSString *title = NSLocalizedString(@"认证结果", nil);
        //        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        //        message=[NSString stringWithFormat:@"%@",response.userInfo];
        //        NSDictionary* dict=response.userInfo;
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
        //                                                        message:message
        //                                                       delegate:nil
        //                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
        //                                              otherButtonTitles:nil];
        self.user.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.user.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIStoryboard      *mainStoryboard     = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController  *viewController     = [mainStoryboard instantiateInitialViewController];
        appDelegate.window.rootViewController = viewController;
        //        [alert show];
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
