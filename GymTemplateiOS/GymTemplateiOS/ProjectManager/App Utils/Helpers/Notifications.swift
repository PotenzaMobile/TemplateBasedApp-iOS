//
//  Notifications.swift
//  SwiftMasterProject
//
//  Created by Apple on 02/01/24.
//

import Foundation
import UIKit
import UserNotifications

//MARK: - Notiifcation SetUp
func registerNotification(aViewcontoller : UIViewController) {
    let center = UNUserNotificationCenter.current()
    center.delegate = aViewcontoller as? UNUserNotificationCenterDelegate
    center.requestAuthorization(options: [.sound, .alert, .badge]) { granted, error in
        if error == nil {
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
