//
//  Player+CoreDataProperties.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-08.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var passWord: String?
    @NSManaged public var playerID: UUID?
    @NSManaged public var userName: String?
    @NSManaged public var playerChallenges: NSSet?

}

// MARK: Generated accessors for playerChallenges
extension Player {

    @objc(addPlayerChallengesObject:)
    @NSManaged public func addToPlayerChallenges(_ value: UserChallenge)

    @objc(removePlayerChallengesObject:)
    @NSManaged public func removeFromPlayerChallenges(_ value: UserChallenge)

    @objc(addPlayerChallenges:)
    @NSManaged public func addToPlayerChallenges(_ values: NSSet)

    @objc(removePlayerChallenges:)
    @NSManaged public func removeFromPlayerChallenges(_ values: NSSet)

}

extension Player : Identifiable {

}
