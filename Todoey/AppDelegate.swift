//
//  AppDelegate.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 29/11/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


// etod metod wuzuwaetsia kogdaprilogenie zagrygaetsia. eto perwoe 4to proisxodit do togo kak viewDidLoad prilogenie polnostju zagryzitsia
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // opredeliaem identifikator peso4nicu gde zapys4eno nashe prilogenije, 4tobu prowerit soxraniaet li nasha baza dannux wwedennyju informaciju
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        return true
    }
    
    // srabatuwaet togda kogda s telefonom 4toto proisxodit kogda prologenie otkrito na perednem plane. naprimer esli polzowatel poly4aet zwonok , to w etom metode mu moget 4toto sdelat 4tobu predotwratit poteriu dannux.
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    //propisuwaem powedenie prilogenija kogda ono w bekgraynde.
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }
    
    //to mesto gde prilogenie bydet zakruto. wuzuwaetsia polzowatelem ili sistemoj.
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

