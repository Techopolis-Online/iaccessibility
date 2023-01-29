//
//  iAccessibilityApp.swift
//  iAccessibility
//
//  Created by Michael Doise on 10/26/22.
//

import SwiftUI
import AVFoundation
import AVKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        return true
    }
}

@main
struct iAccessibilityApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let audioPlayer = LiveAudioPlayer()
    var body: some Scene {
        WindowGroup {
            ContentView(liveAudioPlayer: audioPlayer)
        }
        
    }
}
