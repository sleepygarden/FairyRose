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
        let saveManager = SaveGameManager<GameState>()
        var games = saveManager.load()
        print(games)
        games.append(GameState(playerName: "Violet2"))
        games = []
        print(games)
        saveManager.save(games)
        window?.makeKeyAndVisible()
        return true
    }
}

