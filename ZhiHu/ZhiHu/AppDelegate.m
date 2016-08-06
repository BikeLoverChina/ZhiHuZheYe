//
//  AppDelegate.m
//  ZhiHu
//
//  Created by Apple on 16/7/16.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedViewController.h"
#import "FeedImageNameHandle.h"
#import "ZHFeedImageConstants.h"
#import "DiscoverViewController.h"
#import "DiscoveryImageNameHandle.h"
#import "ZHDiscoveryImageConstants.h"
#import "NotificationsViewController.h"
#import "NotificationsImageNameHandle.h"
#import "ZHNotificationsImageConstants.h"
#import "MessagesViewController.h"
#import "MessagesImageNameHandle.h"
#import "ZHMessagesImageConstants.h"
#import "MoreViewController.h"
#import "MoreImageNameHandle.h"
#import "ZHMoreImageConstants.h"
#import "ZHSkinManager.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabbarViewController = [[UITabBarController alloc] init];
    
    // 首页
    FeedViewController *feedViewController = [[FeedViewController alloc] init];
    feedViewController.tabBarItem.title = @"首页";
    NSString *feedImageKey = [FeedImageNameHandle handleImageName:Night_Tabbar_Feed_Normal];
    feedViewController.tabBarItem.image = [[ZHSkinManager sharedManager] imageWithImageKey:feedImageKey];
    
    // 发现
    DiscoverViewController *discoverViewController = [[DiscoverViewController alloc] init];
    discoverViewController.tabBarItem.title = @"发现";
    NSString *discoveryImageKey = [DiscoveryImageNameHandle handleImageName:Night_Tabbar_Discover_Normal];
    discoverViewController.tabBarItem.image = [[ZHSkinManager sharedManager] imageWithImageKey:discoveryImageKey];
    
    // 通知
    NotificationsViewController *notificationsViewController = [[NotificationsViewController alloc] init];
    notificationsViewController.tabBarItem.title = @"通知";
    NSString *notificationsImageKey = [NotificationsImageNameHandle handleImageName:Night_Tabbar_Notifications_Normal];
    notificationsViewController.tabBarItem.image = [[ZHSkinManager sharedManager] imageWithImageKey:notificationsImageKey];
    
    // 私信
    MessagesViewController *messagesViewController = [[MessagesViewController alloc] init];
    messagesViewController.tabBarItem.title = @"私信";
    NSString *messagesImageKey = [MessagesImageNameHandle handleImageName:Night_Tabbar_Messages_Normal];
    messagesViewController.tabBarItem.image = [[ZHSkinManager sharedManager] imageWithImageKey:messagesImageKey];
    
    // 更多
    MoreViewController *moreViewController = [[MoreViewController alloc] init];
    moreViewController.tabBarItem.title = @"更多";
    NSString *moreImageKey = [MoreImageNameHandle handleImageName:Night_Tabbar_More_Normal];
    moreViewController.tabBarItem.image = [[ZHSkinManager sharedManager] imageWithImageKey:moreImageKey];
    
    tabbarViewController.viewControllers = [NSArray arrayWithObjects:feedViewController, discoverViewController, notificationsViewController, messagesViewController, moreViewController, nil];
    self.window.rootViewController = tabbarViewController;
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

@end
