//
//  SaveGameManager.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/11/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import Foundation


struct SaveGameManager<T: Codable> {

    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    var saveFileName = "fairyrose"

    func buildSaveURL() -> URL {
        do {
            let gameDocumentsDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return gameDocumentsDir.appendingPathComponent(saveFileName)
        } catch let error as NSError {
            fatalError("SaveGameManager Error: couldn't build save url: \(error.localizedDescription)")
        }
    }

    func load() -> [T] {
        let url = buildSaveURL()
        if !FileManager.default.fileExists(atPath: url.path) {
            fairylog("No save file found")
            return []
        }

        do {
            let rawData = try Data(contentsOf: url)
            if rawData.count == 0 {
                fairylog("SaveGameManager Error: Save data empty")
                return []
            }
            let unarchived = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(rawData)
            guard let unarchivedData = unarchived as? Data else {
                fairylog("SaveGameManager Error: Unarchived data can't be parsed as bytes")
                return []
            }
            let saves = try decoder.decode([T].self, from: unarchivedData)
            return saves
        } catch let error as NSError {
            fairylog("SaveGameManager Error: couldn't decode saves: \(error)")
            return []
        }
    }

    func save(_ games: [T]) {
        do {
            let data = try encoder.encode(games)
            let archivedData = NSKeyedArchiver.archivedData(withRootObject: data)
            try archivedData.write(to: buildSaveURL())
        } catch let error as NSError {
            fairylog("SaveGameManager Error: couldn't save: \(error.localizedDescription)")
        }
    }

    func setupiCloud() {
        // todo register notification for updates to state, use NSUbiquitousKeyValueStore
    }
    func sendSavesToiCloud() {}
    func iCloudDidUpdateSaves() {}

}

