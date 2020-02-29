//
//  Sports.swift
//  Sungatullin
//
//  Created by Булат Сунгатуллин on 26.02.2020.
//  Copyright © 2020 Булат Сунгатуллин. All rights reserved.
//

import UIKit
import RealmSwift

struct Sports {
    var name : String
    var startTime : String
    var endTime : String
    var teacher: String
    var place: String
    var descript: String
    var weekDay: Int
}

class SportWeekModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var startTime = ""
    @objc dynamic var endTime = ""
    @objc dynamic var teacher = ""
    @objc dynamic var place = ""
    @objc dynamic var descript = ""
    @objc dynamic var weekDay = 0
}
