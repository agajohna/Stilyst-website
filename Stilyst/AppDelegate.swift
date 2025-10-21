//
//  AppDelegate.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Firebase is already configured in StilystApp.swift
        return true
    }
    
    // Handle APNs token for phone authentication
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("📱 APNs token received")
        
        // Pass device token to Firebase Auth for phone authentication
        Auth.auth().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    // Handle push notifications for phone authentication
    func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Check if Firebase Auth can handle this notification
        if Auth.auth().canHandleNotification(notification) {
            print("📱 Firebase Auth handled notification")
            completionHandler(.noData)
            return
        }
        
        // Handle other notifications here
        completionHandler(.newData)
    }
    
    // Handle URL schemes for phone authentication reCAPTCHA
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // Check if Firebase Auth can handle this URL
        if Auth.auth().canHandle(url) {
            print("🔗 Firebase Auth handled URL: \(url)")
            return true
        }
        
        // Handle other URLs here
        return false
    }
}
