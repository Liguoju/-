//
//  AppDelegate.m
//  本地推送
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 栗国聚. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// 当应用程序再次启动，无论是通过点击图标还是点击通知中心，都会调用该代理方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  UILocalNotification *local = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (local != nil) {
        // 说明应用程序的启动方式是靠用户点击本地通知启动的
        
           }else {
        // 判断系统版本号
        float systemVersion = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (systemVersion > 8.0) {
            // 申请用户许可
            UIUserNotificationSettings *setings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge) categories:nil];
            [[UIApplication sharedApplication]registerUserNotificationSettings:setings];
            
        }
    }
    

    
    
    return YES;
}

// 取消注册

- (void)cancleLocalNotification {
    // 取消本地通知
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    // j记录了调度到系统中的本地通知,里面包含的对象都是 UIlocalNotificaton
    // 可以便利数组，找到某一个本地通知，然后取消掉
    [[UIApplication sharedApplication]scheduledLocalNotifications];
}


- (void)applicationWillResignActive:(UIApplication *)application {
   
    
    
}




#pragma 注册用户的代理方法 


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
      // 注册本地通知
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
       // 制定出发的时间
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
       // 警告框
        localNotification.alertBody= @"吉利博瑞最美中国车";
        localNotification.soundName = @"CAT2.WAV";
        // 应用程序的角标
        localNotification.applicationIconBadgeNumber = 1;
        
        // 把本地的通知调度到系统中，无论我的程序是否启动都会调用
        [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
       
        
    }
}
// 在后台时，收到本地通知，用户点击通知，该代理方法也会被调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //UIApplicationStateActive   说明应用程序在前台
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:notification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    }else if ( application.applicationState == UIApplicationStateInactive) {
        // 应用程序处于不活跃时收到的本地通知
        NSLog(@"再次激活时的业务处理");
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    }else {
        // 后台模式
        NSLog(@"后台模式");
    }
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
