//
//  AppDelegate.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/3/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = FairyViewController()
        fairylog("hello", "world")
        var games = SaveGameManager.load()
        print(games)
        games.append(GameState(playerName: "Violet1"))
        print(games)
        SaveGameManager.save(games)
        window?.makeKeyAndVisible()
        return true
    }
}
