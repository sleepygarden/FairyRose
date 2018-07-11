//
//  GameViewController.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/3/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



class FairyViewController: UIViewController, FairySceneDelegate {

    let gameView = SKView()
    let menuView = UIView()
    var menuShown = false

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.frame = view.bounds
        gameView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        menuView.frame = view.bounds
        menuView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(gameView)

        let scene = FairyScene(fairyDelegate: self)
        scene.scaleMode = .aspectFill
        gameView.presentScene(scene)

        // only use the zPosition node property to determine whom is in front of whom - very efficient, but needs manual management
//        gameView.ignoresSiblingOrder = true

        // Debug helpers
        gameView.showsFPS = true
        gameView.showsNodeCount = true
    }

    func toggleMenu(animated: Bool) {
        if menuShown {
            closeMenu(animated: animated)
        } else {
            openMenu(animated: animated)
        }
    }

    func openMenu(animated: Bool) {
        guard let scene = gameView.scene else { fatalError("Scene missing in menu transition") }
        if menuShown { return }
        menuShown = true
        let menuView = self.menuView
        scene.isPaused = true

        if animated {
            menuView.alpha = 0.0
            view.addSubview(menuView)
            UIView.animate(withDuration: 0.130, delay: 0, options: .curveEaseOut, animations: {
                menuView.alpha = 1.0
            }, completion: nil)
        } else {
            view.addSubview(menuView)
        }
    }

    func closeMenu(animated: Bool) {
        guard let scene = gameView.scene else { fatalError("Scene missing in menu transition") }
        if !menuShown { return }
        let menuView = self.menuView

        if animated {
            UIView.animate(withDuration: 0.130, delay: 0, options: .curveEaseOut, animations: {
                menuView.alpha = 0
            }) { (finished) in
                menuView.removeFromSuperview()
                scene.isPaused = false
            }
        } else {
            menuView.removeFromSuperview()
            scene.isPaused = false
        }
    }

    override func viewDidLayoutSubviews() {
        gameView.scene?.size = view.bounds.size
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
