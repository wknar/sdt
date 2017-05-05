//
//  Garbage.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/05/05.
//  Copyright © 2017 wknar. All rights reserved.
//

import Foundation
import RealmSwift

class Garbage: Object {
    dynamic var day     = 0
    dynamic var content = ""

    override class func primaryKey() -> String? {
        return "day"
    }
}
