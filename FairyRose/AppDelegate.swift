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
        let fairyViewController = FairyViewController()
        let rootScene = GameScene(fairyViewController: fairyViewController)
        fairyViewController.presentSceneWhenReady(rootScene)

        let saveManager = SaveGameManager<GameState>()
        var games = saveManager.load()
        games.append(GameState(playerName: "Violet2"))
        saveManager.save(games)

        window?.rootViewController = fairyViewController
        window?.makeKeyAndVisible()
        return true
    }


}

