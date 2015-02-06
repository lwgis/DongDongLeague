//
//  AppDelegate.m
//  DongDongLeague
//
//  Created by 李炜 on 15/1/22.
//  Copyright (c) 2015年 DongDongLeague. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize user;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    self.user=[[User alloc] init];
    self.user.wbCurrentUserID=[ud valueForKey:@"userid"];
    self.user.wbtoken=[ud valueForKey:@"token"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self.user.wbCurrentUserID==nil||[self.user.wbCurrentUserID isEqual:@""]) {
        UIStoryboard      *loginStoryboard     = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UIViewController  *viewController     = [loginStoryboard instantiateInitialViewController];
        self.window.rootViewController = viewController;
    }
    else{
        UIStoryboard      *mainStoryboard     = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController  *viewController     = [mainStoryboard instantiateInitialViewController];
        self.window.rootViewController = viewController;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    LoginViewController *loginViewController=(LoginViewController *)self.window.rootViewController;
    return [WeiboSDK handleOpenURL:url delegate:loginViewController];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    LoginViewController *loginViewController=(LoginViewController *)self.window.rootViewController;
    return [WeiboSDK handleOpenURL:url delegate:loginViewController ];
}

@end
