//
//  ButtonNode.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/3/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import SpriteKit

typealias FairyButtonAction = (FairyButton) -> ()

class FairyButton: SKNode {

    var action: FairyButtonAction
    var isDown = false {
        didSet {
            updateUIForDownState()
        }
    }
    let labelNode = SKLabelNode()
    let spriteNode = SKSpriteNode()

    var size: CGSize {
        didSet {
            spriteNode.size = size
            labelNode.preferredMaxLayoutWidth = size.width
        }
    }


    init(size: CGSize, action: @escaping FairyButtonAction) {
        self.action = action
        self.size = size
        super.init()
        addChild(spriteNode)
        addChild(labelNode)
        isUserInteractionEnabled = true
        spriteNode.color = .purple
        labelNode.text = "FairyButton"
        labelNode.verticalAlignmentMode = .center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDown = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDown {
            action(self)
        }
        isDown = false
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var stillDown = false
        for touch in touches {
            if spriteNode.frame.contains(touch.location(in: self)) {
                stillDown = true
                break
            }
        }

        isDown = stillDown
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDown = false
    }

    func updateUIForDownState() {
        if isDown {
            spriteNode.color = .blue
        } else {
            spriteNode.color = .purple
        }
    }
}
