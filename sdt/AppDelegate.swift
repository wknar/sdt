//
//  AppDelegate.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/02/16.
//  Copyright © 2017 wknar. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // check permission for notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler:{ (g, e) in
            if (e != nil) {
                return
            }
            if (g) {
                UIApplication.shared.registerForRemoteNotifications()
            }
        })
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // addWeeklyNotification()
    }

    func addWeeklyNotification(_ hour: Int, _ minute: Int, _ content: [String]) {
        // reset all local notification
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        var dateComp = DateComponents()
        dateComp.hour   = hour
        dateComp.minute = minute

        for w in 1...7 {
            dateComp.weekday = w
            let trig = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
            UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: "weeklyAlert" + String(w),
                                                                         content: createContentOfAlert(w, content),
                                                                         trigger: trig), withCompletionHandler: nil)
        }
    }

    func createContentOfAlert(_ w: Int, _ contentList: [String]) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "千代田区ごみ"
        // create subtitle
        let weekday = w
        content.subtitle = "明日は"
        switch weekday {
        case 1: //sunday
            content.subtitle.append("月曜日")
            content.body = contentList[0]
            break
        case 2: //monday
            content.subtitle.append("火曜日")
            content.body = contentList[1]
            break
        case 3: //tuesday
            content.subtitle.append("水曜日")
            content.body = contentList[2]
            break
        case 4: //wednesday
            content.subtitle.append("木曜日")
            content.body = contentList[3]
            break
        case 5: //thursday
            content.subtitle.append("金曜日")
            content.body = contentList[4]
            break
        case 6: //friday
            content.subtitle.append("土曜日")
            content.body = contentList[5]
            break
        case 7: //saturday
            content.subtitle.append("日曜日")
            content.body = contentList[6]
            break
        default: break
        }
        content.body.append("の日です。")
        content.sound = UNNotificationSound.default()
        return content
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("err with notification granted:", error.localizedDescription)
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


}

