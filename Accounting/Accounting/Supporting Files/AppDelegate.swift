//
//  AppDelegate.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/22/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController: UIViewController
        
        let calendar = IncomeCalendar.instance
        let todayDate = Date()
        
        if IncomeCalendar.workingDays.contains(todayDate.dayOfWeek()) {
            // Today is workign day
            let today = calendar.days[calendar.todayIndex]
            
            if today.timeIn == nil {
                initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "StartNewWorkingDayView") as! StartNewWorkingDayViewController
            } else if today.timeIn != nil, today.timeOut == nil {
                initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "EndWorkingDayView") as! EndWorkingDayViewController
            } else {
                initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "StatisticsDayView") as! StatisticsDayViewController
            }
            
        } else {
            // Today is weekend
            initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "StatisticsDayView") as! StatisticsDayViewController
        }
        
        self.window?.rootViewController = initialViewController
        
        self.window?.makeKeyAndVisible()
        
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


}

