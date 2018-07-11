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

struct SaveGameManager {

    static let encoder = PropertyListEncoder()
    static let decoder = PropertyListDecoder()

    static func buildSaveURL() -> URL {
        do {
            let gameDocumentsDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return gameDocumentsDir.appendingPathComponent("fairyrose")
        } catch let error as NSError {
            fatalError("SaveGameManager Error: couldn't build save url: \(error.localizedDescription)")
        }
    }

    static func load() -> [GameState] {
        let url = buildSaveURL()
        if !FileManager.default.fileExists(atPath: url.path) {
            fairylog("No save file found")
            return []
        }
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? Data else {
            fairylog("SaveGameManager Error: couldn't unarchive data from file")
            return []
        }
        do {
            let saves = try decoder.decode([GameState].self, from: data)
            return saves
        } catch let error as NSError {
            fairylog("SaveGameManager Error: couldn't decode saves: \(error)")
            return []
        }
    }

    static func save(_ games: [GameState]) {
        do {
            let data = try encoder.encode(games)
            try data.write(to: buildSaveURL())
        } catch let error as NSError {
            fairylog("SaveGameManager Error: couldn't save: \(error.localizedDescription)")
        }
    }

    static func sendSavesToiCloud() {
        // todo use NSUbiquitousKeyValueStore
    }

    static func iCloudDidUpdateSaves() {

    }

}
