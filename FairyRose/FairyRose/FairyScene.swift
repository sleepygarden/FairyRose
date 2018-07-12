//
//  FairyScene.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/12/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import SpriteKit

class FairyScene: SKScene {

    weak var fairyViewController: FairyViewController?

    init(fairyViewController: FairyViewController) {
        self.fairyViewController = fairyViewController
        super.init(size: UIScreen.main.bounds.size)
        self.scaleMode = .aspectFit
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
