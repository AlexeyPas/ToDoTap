//
//  AppDelegate.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 08.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var appCoordinator = AppCoordinator()
    var window: UIWindow?

    let notificationCenter = UNUserNotificationCenter.current()
    let notifications = Notifications()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notifications.requestAutorization()
        notifications.notificationCenter.delegate = notifications
        
        appCoordinator.start()
        return true
    }


}

