//
//  AppDelegate.swift
//  MyHealthPrototype
//
//  Created by Guillian Balisi on 2016-10-12.
//  Copyright © 2016 Guillian Balisi. All rights reserved.
//

import UIKit
import ResearchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let healthStore = HKHealthStore()
    
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
        
        let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Welcome back to ResearchKit Sample App", delegate: self)
        containerViewController?.present(passcodeViewController, animated: false, completion: nil)
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

