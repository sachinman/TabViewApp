//
//  ZSCAppDelegate.m
//  TabViewApp
//
//  Created by student on 13-5-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ZSCAppDelegate.h"
#import <BaiduSocialShare/BDSocialShareSDK.h>
#import "ZSCFirstViewController.h"
#import "ZSCSecondViewController.h"
#import "ZSCThirdViewController.h"
#import "ZSCFourthViewController.h"

@implementation ZSCAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //定义分享平台数组
    //kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,
    NSArray *platforms = [NSArray arrayWithObjects:kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO,kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO,kBD_SOCIAL_SHARE_PLATFORM_QQZONE,kBD_SOCIAL_SHARE_PLATFORM_KAIXIN,kBD_SOCIAL_SHARE_PLATFORM_RENREN,kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,
                          kBD_SOCIAL_SHARE_PLATFORM_EMAIL,
                          kBD_SOCIAL_SHARE_PLATFORM_SMS,nil];
    //初始化分享组件
    //x5fCwuGQZDGtKHlbWEavlgaa
    [BDSocialShareSDK registerApiKey:@"dHwDe5TTTtFEv4MOgoeTGLvX" andSupportPlatforms:platforms];
    
    //初始化微信
    [BDSocialShareSDK registerWXApp:@"wx712df8473f2a1dbe"];
    
    //设置新浪微博和QQ客户端的app id，使用SSO功能
    [BDSocialShareSDK enableSinaWeiboSSOWithAppId:@"319137445"];
    [BDSocialShareSDK enableQQSSOWithAppId:@"100358052"];
    
    
    
    //UIViewController *viewController1 = [[ZSCFirstViewController alloc] initWithNibName:@"ZSCFirstViewController" bundle:nil];
    //viewController1.navigationItem.title=@"对联知识";
    UIViewController *viewController2 = [[ZSCSecondViewController alloc] initWithNibName:@"ZSCSecondViewController" bundle:nil];
    viewController2.navigationItem.title=@"对联生成";
    UIViewController *viewController3 = [[ZSCThirdViewController alloc] initWithNibName:@"ZSCThirdViewController" bundle:nil];
    viewController3.title=@"历史";
    viewController3.tabBarItem.image = [UIImage imageNamed:@"historical"];
    viewController3.navigationItem.title=@"历史记录";
    UIViewController *viewController4 = [[ZSCFourthViewController alloc] initWithNibName:@"ZSCFourthViewController" bundle:nil];
    viewController4.navigationItem.title=@"设置中心";
    
    //UINavigationController *nc1=[[UINavigationController alloc]initWithRootViewController:viewController1];
    UINavigationController *nc2=[[UINavigationController alloc]initWithRootViewController:viewController2];
    UINavigationController *nc3=[[UINavigationController alloc]initWithRootViewController:viewController3];
    UINavigationController *nc4=[[UINavigationController alloc]initWithRootViewController:viewController4];
    
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nc2, nc3,nc4, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [BDSocialShareSDK destroy];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [BDSocialShareSDK handleOpenURL:url];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
