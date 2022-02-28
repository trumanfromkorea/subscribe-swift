//
//  LocalNotificationManager.swift
//  subscribe
//
//  Created by 장재훈 on 2022/03/01.
//

import Foundation
import UserNotifications

struct Notification {
    var id: String
    var title: String
}

class LocalNotificationManager {
    var notifications = [Notification]()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
            if granted && error == nil {
                // We have permission!
            }
        }
    }

    func addNotification(title: String) {
        notifications.append(Notification(id: UUID().uuidString, title: title))
    }

    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }

    func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title

            content.sound = UNNotificationSound.default
            content.subtitle = "This is subtitle: notifications tutorial"

            content.body = "this is body"

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil
                else { return }

                print("scheduling notification with id \(notification.id)")
            }
        }
    }
}
