//
//  GameScene.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/3/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: FairyScene {

    override func didMove(to view: SKView) {
        // load up texture atlases here

        backgroundColor = SKColor(red: 0.2, green: 0.95, blue: 0.65, alpha: 1)
        
        let btn = FairyButton(size: CGSize(width: 180, height: 60)) { (btn) in
            print("Okay!")
        }
        btn.position = CGPoint(x: 250, y: 100)
        addChild(btn)

        let mark = SKSpriteNode(color: .red, size: CGSize(width: 2, height: 2))
        mark.position = btn.position
        addChild(mark)

        let typingLabel = FairyTypingLabel(text: "Hello World! My Name is Mike", width: 120)
        typingLabel.position = CGPoint(x: 150, y: 150)
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
