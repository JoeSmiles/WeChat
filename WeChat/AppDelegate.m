//
//  AppDelegate.m
//  WeChat
//
//  Created by admin on 2018/1/17.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeVC.h"
#import "ContactsVC.h"
#import "FindVC.h"
#import "MineVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HomeVC *homeVC = [[HomeVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = nav;
    
    self.window.rootViewController = [self setupViewControllers];
    [self customizeInterface];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UITabBarController *)setupViewControllers
{
    HomeVC *homeVC = [[HomeVC alloc] init];
    UIViewController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    ContactsVC *contactVC = [[ContactsVC alloc] init];
    UIViewController *contactNav = [[UINavigationController alloc] initWithRootViewController:contactVC];
    
    FindVC *findVC = [[FindVC alloc] init];
    UIViewController *findNav = [[UINavigationController alloc] initWithRootViewController:findVC];
    
    MineVC *mineVC = [[MineVC alloc] init];
    UIViewController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];

    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           homeNav,
                                           contactNav,
                                           findNav,
                                           mineNav
                                           ]];
    return tabBarController;
}

- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController
{
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle:@"微信",
                            CYLTabBarItemImage:@"tabbar_mainframe",
                            CYLTabBarItemSelectedImage:@"tabbar_mainframeHL"
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle:@"通信录",
                            CYLTabBarItemImage:@"tabbar_contacts",
                            CYLTabBarItemSelectedImage:@"tabbar_contactsHL"
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle:@"发现",
                            CYLTabBarItemImage:@"tabbar_discover",
                            CYLTabBarItemSelectedImage:@"tabbar_discoverHL"
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:@"tabbar_me",
                            CYLTabBarItemSelectedImage:@"tabbar_meHL"
                            };
    
    NSArray *tabBarItemsAttributes = @[dict1,dict2,dict3,dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    tabBarController.tabBar.translucent = NO;
}

- (void)customizeInterface
{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = NormalTextCorlor;
    
    // 选中状态下的文字的属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = SelectedTextCorlor;
    
    // 设置文字的属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // 设置图片背景
    UITabBar *tabBarApperance = [UITabBar appearance];
    [tabBarApperance setBackgroundImage:[UIImage imageNamed:@""]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
