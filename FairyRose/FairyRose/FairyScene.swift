//
//  GameScene.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/3/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol FairySceneDelegate: class {
    func toggleMenu(animated: Bool)
}

class FairyScene: SKScene {

    weak var fairyDelegate: FairySceneDelegate?

    init(fairyDelegate: FairySceneDelegate) {
        self.fairyDelegate = fairyDelegate
        super.init(size: UIScreen.main.bounds.size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {

        let bg = SKSpriteNode(color: UIColor.green.withAlphaComponent(0.2), size: size)
        addChild(bg)
        
        // load up texture atlases here
        let btn = FairyButton(size: CGSize(width: 180, height: 60)) { (btn) in
            print("touch")
        }
        btn.position = CGPoint(x: 100, y: 100)
        addChild(btn)

        let mark = SKSpriteNode(color: .red, size: CGSize(width: 2, height: 2))
        mark.position = btn.position
        addChild(mark)

        let typingLabel = FairyTypingLabel(text: "Hello World! My Name is Mike", width: 80)
        typingLabel.position = CGPoint(x: 50, y: 150)
        typingLabel.fontName = "Chalkduster"
        typingLabel.fontSize = 20
        typingLabel.fontColor = .white
        addChild(typingLabel)
        typingLabel.animateText()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
