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


protocol FairySceneDelegate: class {
    func toggleUIKitView(animated: Bool)
}

class FairyViewController: UIViewController, FairySceneDelegate {

    let gameView = SKView()
    var uiKitOverlayController: UIViewController?
    var sceneToPresentOnLoad: FairyScene?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black

        gameView.frame = view.bounds
        gameView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(gameView)

        if let sceneToPresentOnLoad = sceneToPresentOnLoad {
            gameView.presentScene(sceneToPresentOnLoad)
            self.sceneToPresentOnLoad = nil
        }

        // only use the zPosition node property to determine whom is in front of whom - very efficient, but needs manual management
        //        gameView.ignoresSiblingOrder = true

        // Debug helpers
        #if DEBUG
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        #endif
    }

    func presentSceneWhenReady(_ scene: FairyScene) {
        if isViewLoaded {
            gameView.presentScene(scene)
        } else {
            sceneToPresentOnLoad = scene
        }
    }

    func toggleUIKitView(animated: Bool) {
        if uiKitOverlayController?.parent != nil {
            closeUIKitOverlay(animated: animated)
        } else {
            openUIKitOverlay(animated: animated)
        }
    }

    func openUIKitOverlay(animated: Bool) {
        guard let scene = gameView.scene else { return }
        guard let uiKitOverlayController = uiKitOverlayController else { return }
        if uiKitOverlayController.parent != nil { return }

        scene.isPaused = true
        uiKitOverlayController.view.frame = view.bounds
        addChildViewController(uiKitOverlayController)

        if animated {
            uiKitOverlayController.view.alpha = 0.0
            view.addSubview(uiKitOverlayController.view)
            UIView.animate(withDuration: 0.130, delay: 0, options: .curveEaseOut, animations: {
                 uiKitOverlayController.view.alpha = 1.0
            }, completion: nil)
        } else {
            view.addSubview(uiKitOverlayController.view)
            uiKitOverlayController.didMove(toParentViewController: self)
        }
    }

    func closeUIKitOverlay(animated: Bool) {
        guard let scene = gameView.scene else { return }
        guard let uiKitOverlayController = uiKitOverlayController else { return }
        if uiKitOverlayController.parent == nil { return }

        uiKitOverlayController.willMove(toParentViewController: nil)
        uiKitOverlayController.removeFromParentViewController()

        if animated {
            UIView.animate(withDuration: 0.130, delay: 0, options: .curveEaseOut, animations: {
                uiKitOverlayController.view.alpha = 0
            }) { (finished) in
                uiKitOverlayController.view.removeFromSuperview()
                scene.isPaused = false
            }
        } else {
            uiKitOverlayController.view.removeFromSuperview()
            scene.isPaused = false
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
