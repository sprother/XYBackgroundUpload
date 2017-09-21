//
//  AppDelegate.swift
//  XYBackgroundUpload
//
//  Created by xiaoyi on 2017/9/19.
//  Copyright © 2017年 xiaoyi. All rights reserved.
//

import UIKit
import UserNotifications
//后台下载完成后处理闭包
typealias HanderCompletion = () -> Void

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var handler:HanderCompletion!


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, erro) in
            if granted {
            }else{
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    //MARK: - 后台下载上传完成处理
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        self.handler = completionHandler
        creatNotificationContent(identifier: identifier)
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }

    

    
}

//MARK: - 创建一个通知
func creatNotificationContent(identifier: String){
    let content = UNMutableNotificationContent()
    content.title = "上传完成通知"
    content.body = "任务\(identifier)完成上传啦"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
    
    let requestIdentfier = "com.xiaoyi.localNotification"
    
    let request = UNNotificationRequest(identifier: requestIdentfier, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if error == nil {
            
        }
    }
    
    
}
