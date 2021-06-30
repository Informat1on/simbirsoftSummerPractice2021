//
//  DatabaseModel.swift
//  iosEveryDayer
//
//  Created by Арсений Щербак on 29.06.2021.
//  Copyright © 2021 Arseniy Shcherbak. All rights reserved.
//

import RealmSwift

//модель базы данных
class JSFile:Object{
    @objc dynamic var id = 1
    @objc dynamic var date_start = ""
    @objc dynamic var date_finish = ""
    @objc dynamic var name = ""
    @objc dynamic var eventDescription = ""
}
