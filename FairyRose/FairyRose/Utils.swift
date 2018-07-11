//
//  Utils.swift
//  FairyRose
//
//  Created by Michael Cornell on 7/11/18.
//  Copyright © 2018 Oath. All rights reserved.
//

import Foundation

#if DEBUG
let fairylog = { (args: Any...) in
    for arg in args {
        print("\(arg) ", separator:" ", terminator:"")
    }
    print("")
}
#else
let fairylog = { (args: Any...) in }
#endif
