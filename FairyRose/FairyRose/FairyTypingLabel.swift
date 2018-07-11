//
//  FairyTextView.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/6/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import SpriteKit

class FairyTypingLabel: SKLabelNode {

    var fullText: String
    var animationTimer: Timer?
    var animationSpeed: TimeInterval = 0.055

    init(text: String, width: CGFloat) {
        fullText = text
        super.init()
        self.preferredMaxLayoutWidth = width
        self.numberOfLines = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func hideText() {
        text = nil
    }

    func revealText() {
        text = fullText
    }
    
    func animateText() {
        animationTimer = Timer.scheduledTimer(withTimeInterval: animationSpeed, repeats: true, block: {[weak self] (timer) in
            guard let strongSelf = self else {
                self?.cancelAnimation()
                return
            }
            let text = strongSelf.text ?? ""
            if text.count >= strongSelf.fullText.count  {
                self?.cancelAnimation()
                return
            }

            let stringIdx = strongSelf.fullText.index(strongSelf.fullText.startIndex, offsetBy: text.count)
            strongSelf.text = text.appending(String(strongSelf.fullText[stringIdx]))
        })
    }

    func cancelAnimation() {
        self.animationTimer?.invalidate()
        self.animationTimer = nil
    }
}

