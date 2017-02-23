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
        // reset all local notification
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
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
        let token = String(format: "%@", deviceToken as CVarArg) as String
        print("deviceToken: \(token)")
        addWeeklyNotification()
    }

    func addWeeklyNotification() {
        var dateComp = DateComponents()
        dateComp.hour   = 20

        let trig = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let req = UNNotificationRequest(identifier: "weeklyAlert", content: createContentOfAlert(), trigger: trig)

        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }

    func createContentOfAlert() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "千代田区ごみ"
        // create subtitle
        let weekday = NSCalendar.current.component(Calendar.Component.weekday, from: NSDate() as Date)
        switch weekday {
        case 1: //sunday
            content.subtitle = "Tomorrow is Monday"
            content.body = "生ごみ"
            break
        case 2: //monday
            content.subtitle = "Tomorrow is Tuesday"
            content.body = "資源ごみ"
            break
        case 3: //tuesday
            content.subtitle = "Tomorrow is Wednesday"
            content.body = "ごみなし"
            break
        case 4: //wednesday
            content.subtitle = "Tomorrow is Thursday"
            content.body = "生ごみ"
            break
        case 5: //thursday
            content.subtitle = "Tomorrow is Friday"
            content.body = "プラスチックごみ"
            break
        case 6: //friday
            content.subtitle = "Tomorrow is Saturday"
            content.body = "ごみなし"
            break
        case 7: //saturday
            content.subtitle = "Tomorrow is Sunday"
            content.body = "ごみなし"
            break
        default: break
        }
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

