//
//  User+CoreDataProperties.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var id: String
    @NSManaged public var avatar: NSData?
    @NSManaged public var chatlog: NSSet?
    @NSManaged public var chatGroup: NSSet?

}

// MARK: Generated accessors for chatlog
extension User {

    @objc(addChatlogObject:)
    @NSManaged public func addToChatlog(_ value: ChatLog)

    @objc(removeChatlogObject:)
    @NSManaged public func removeFromChatlog(_ value: ChatLog)

    @objc(addChatlog:)
    @NSManaged public func addToChatlog(_ values: NSSet)

    @objc(removeChatlog:)
    @NSManaged public func removeFromChatlog(_ values: NSSet)

}

// MARK: Generated accessors for chatGroup
extension User {

    @objc(addChatGroupObject:)
    @NSManaged public func addToChatGroup(_ value: ChatGroup)

    @objc(removeChatGroupObject:)
    @NSManaged public func removeFromChatGroup(_ value: ChatGroup)

    @objc(addChatGroup:)
    @NSManaged public func addToChatGroup(_ values: NSSet)

    @objc(removeChatGroup:)
    @NSManaged public func removeFromChatGroup(_ values: NSSet)

}
