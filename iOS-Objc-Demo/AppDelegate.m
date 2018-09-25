//
//  AppDelegate.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //本地推送
    [self requestAuthor];
    
    CGFloat Y = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.fpsLabel = [[DNFPSLabel alloc] initWithFrame:CGRectMake(75, Y, 60, 44)];
    self.fpsLabel.textColor = UIColor.redColor;
    [self.window addSubview:self.fpsLabel];
        
    return YES;
}

//创建本地通知
- (void)requestAuthor {
     if (@available(iOS 10.0, *)) {
         UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
         center.delegate = self;
         [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                               completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                   NSLog(@"未获取权限");
                               }];
         [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
             
         }];
     } else {
         
     }
}

#pragma mark - UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
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
