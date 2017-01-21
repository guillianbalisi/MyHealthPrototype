//
//  AppDelegate.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit
import UserNotifications
import UserNotificationsUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let healthStore = HKHealthStore()
    
    var presentFrom: String = ""
    var hasCompletedRCT = false
    
    var window: UIWindow?
    
    var containerViewController: ResearchContainerViewController? {
        return window?.rootViewController as? ResearchContainerViewController
    }
    
    private func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let standardDefaults = UserDefaults.standard
        if standardDefaults.object(forKey: "ORKSampleFirstRun") == nil {
            ORKPasscodeViewController.removePasscodeFromKeychain()
            standardDefaults.setValue("ORKSampleFirstRun", forKey: "ORKSampleFirstRun")
        }
        
        // Appearance customization
        let pageControlAppearance = UIPageControl.appearance()
        pageControlAppearance.pageIndicatorTintColor = UIColor.lightGray
        pageControlAppearance.currentPageIndicatorTintColor = UIColor.black
        
        // Dependency injection.
        containerViewController?.injectHealthStore(healthStore)
        return true
    }
    
    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        lockApp()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            // Hide content so it doesn't appear in the app switcher.
            containerViewController?.contentHidden = true
        }
        
        if hasCompletedRCT == false {
            hasCompletedRCT = true
            let date = Date(timeIntervalSinceNow: 10)
            scheduleRCTNotification(at: date)
        }
        else {
            hasCompletedRCT = false
            let date = Date(timeIntervalSinceNow: 10)
            scheduleFollowUpNotification(at: date)
        }
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        lockApp()
    }
    
    func lockApp() {
        /*
         Only lock the app if there is a stored passcode and a passcode
         controller isn't already being shown.
         */
        guard ORKPasscodeViewController.isPasscodeStoredInKeychain() && !(containerViewController?.presentedViewController is ORKPasscodeViewController) else { return }
        
        window?.makeKeyAndVisible()
        
        let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Welcome back to MyHealthPHRI", delegate: self)
        containerViewController?.present(passcodeViewController, animated: false, completion: nil)
    }
    
    // Notification
    
    func scheduleRCTNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Randomized Control Trial"
        content.body = "Would you like to participate in a randomized survey for research purposes?"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "RCTCategory"

        
        if let path = Bundle.main.path(forResource: "PHRI1", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("attachment not found.")
            }
        }
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "RCTNotification", content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
                
                print("Uh oh! Something went wrong")
            }
        }
    }
    
    func scheduleFollowUpNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Randomized Control Trial"
        content.subtitle = "Follow Up"
        content.body = "Thank you for participating in the research study. We have a couple of questions."
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "FollowUpCategory"
        
        if let path = Bundle.main.path(forResource: "PHRI1", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("attachment not found.")
            }
        }
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "FollowUpNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
                
                print("Uh oh! Something went wrong")
            }
        }
    }

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        let joinAction = UNNotificationAction(identifier: "Join", title: "Join study", options: [])
        let remindAction = UNNotificationAction(identifier: "RemindLater", title: "Remind me later", options: [])
        let noThanksAction = UNNotificationAction(identifier: "No", title: "No thanks", options: [])
        let RCTCategory = UNNotificationCategory(identifier: "RCTCategory", actions: [joinAction, remindAction, noThanksAction], intentIdentifiers: [], options: [])
        
        let followUpAction = UNNotificationAction(identifier: "FollowUp", title: "Follow up", options: [])
        let followUpCategory = UNNotificationCategory(identifier: "FollowUpCategory", actions: [followUpAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([RCTCategory, followUpCategory])
        

//        UNUserNotificationCenter.current().setNotificationCategories([followUpCategory])
//        
        return true
    }
}

extension AppDelegate: ORKPasscodeDelegate {
    
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        containerViewController?.contentHidden = false
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async{
            if response.actionIdentifier == "RemindLater" {
                let newDate = Date(timeInterval: 10, since: Date())
                self.scheduleRCTNotification(at: newDate)
            }
            
            if response.actionIdentifier == "Join" {
                self.presentFrom = "RCT"
                self.redirectToRCT()

            }
            
            if response.actionIdentifier == "No" {
                completionHandler()
            }
            
            if response.actionIdentifier == "FollowUp" {
                self.presentFrom = "FollowUp"
                self.redirectToRCT()
            }
        }
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == "RCTNotification" {
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
    
    func redirectToRCT() {
        window?.makeKeyAndVisible()
    }

}

extension AppDelegate : ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Handle results using taskViewController.result
        if(reason != ORKTaskViewControllerFinishReason.failed){
            taskViewController.delegate = self
            taskViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}

