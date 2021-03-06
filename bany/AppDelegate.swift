//
//  AppDelegate.swift
//  bany
//
//  Created by Lee Janghyup on 9/23/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import Bolts
import FBSDKCoreKit
import ParseFacebookUtilsV4
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var reachability : Reachability?
    var reachable :Bool = true
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("SlGp3xHZTvM9fiCYhdnKC3t8zVBlZXZ6Qfp3u3pI",
            clientKey: "8qVDrtz952VDOIcTFfQgwPJ5ce7Sku2Dnp1ZCpHE")
        
        // [Optional] Track statistics around application opens.
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        //리치어빌리티
        do {
            let reachability = try Reachability.reachabilityForInternetConnection()
            self.reachability = reachability
        } catch ReachabilityError.FailedToCreateWithAddress(let address) {
        }
        catch {}
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: nil)
        
        do {
            try reachability?.startNotifier()
            
        }catch {}

        
        
        //자동로그인
        let objectIdCheck : String? = NSUserDefaults.standardUserDefaults().stringForKey("objectId")
        
        print(objectIdCheck)
        
         if(objectIdCheck != nil)
        {
            
            let mainStroyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let welcomeVC: WelcomVC = mainStroyBoard.instantiateViewControllerWithIdentifier("WelcomVC") as! WelcomVC
            
            let welcomeNav = UINavigationController(rootViewController : welcomeVC)
            
            let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = welcomeNav
        }
        
        
        
        
        
        return true
        
        
    }
    
    func reachabilityChanged(notification : NSNotification) {
        
        let reachability = notification.object as! Reachability
        
        if reachability.isReachable() {
            
            
        }else {
            
        }
        
        
    }

    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL : url, sourceApplication :sourceApplication, annotation : annotation)
        
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       FBSDKAppEvents.activateApp()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

