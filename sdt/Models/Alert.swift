//
//  Alert.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/03/08.
//  Copyright © 2017 wknar. All rights reserved.
//

import Foundation
import RealmSwift

class Alert: Object {
    dynamic var id      = 0
    dynamic var title   = ""
    dynamic var desc    = ""
    dynamic var hour    = 0
    dynamic var minute  = 0

    override class func primaryKey() -> String? {
        return "id"
    }
}
