//
//  GameState.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/10/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import UIKit


struct GameState: Codable {
    var playerName: String

    init(playerName: String) {
        self.playerName = playerName
    }
}
