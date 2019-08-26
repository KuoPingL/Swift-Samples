//
//  ChatLog+CoreDataProperties.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//
//

import Foundation
import CoreData


extension ChatLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatLog> {
        return NSFetchRequest<ChatLog>(entityName: "ChatLog")
    }

    @NSManaged public var text: String?
    @NSManaged public var image: NSData?
    @NSManaged public var date: NSDate
    @NSManaged public var isRead: Bool
    @NSManaged public var numberOfRead: Int16
    @NSManaged public var sender: User
    @NSManaged public var chatGroup: ChatGroup

}
