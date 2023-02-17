//
//  Simple_Remote_Shopping_ListApp.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if CommandLine.arguments.contains("-TestUserLoggedIn") {
                    LandingPageView()
                }
                else {
                    PrelogView()
                }
            }
        }
    }
}
