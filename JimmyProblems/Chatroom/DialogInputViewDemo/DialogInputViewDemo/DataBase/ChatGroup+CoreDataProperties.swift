//
//  ChatGroup+CoreDataProperties.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//
//

import Foundation
import CoreData


extension ChatGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatGroup> {
        return NSFetchRequest<ChatGroup>(entityName: "ChatGroup")
    }

    @NSManaged public var name: String
    @NSManaged public var id: String
    @NSManaged public var ownerID: String
    @NSManaged public var user: NSSet?
    @NSManaged public var log: ChatLog?

}

// MARK: Generated accessors for user
extension ChatGroup {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}
