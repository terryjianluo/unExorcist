//
//  MapData.swift
//  unExorcist
//
//  Created by Terry on 16/1/31.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import RealmSwift

class GameRecord: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var id = ""
    dynamic var scene = ""
    dynamic var property = ""
    dynamic var equip = ""
    dynamic var trigger = ""
    dynamic var quest = ""
    dynamic var bag = ""
}

class Pakage: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var id = ""
    dynamic var number = ""
}

class PlayerProperty: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var level = ""
    dynamic var HP = ""
    dynamic var MP = ""
    dynamic var ATK = ""
    dynamic var DEF = ""
    dynamic var MR = ""
    dynamic var SP = ""
    
    dynamic var HPup = ""
    dynamic var MPup = ""
    dynamic var ATKup = ""
    dynamic var DEFup = ""
    
    dynamic var speed = ""
    dynamic var range = ""
    dynamic var critical = ""
    dynamic var spellCritical = ""
    dynamic var hitPenetration = ""
    dynamic var spellPenetration = ""
    dynamic var hitRating = ""
    dynamic var spellHitRating = ""
    dynamic var criticalDamage = ""
    dynamic var spellCriticalDamage = ""
    dynamic var dodge = ""
    dynamic var strikeSpeed = ""
    dynamic var shield = ""
    dynamic var threaten = ""
    dynamic var assist = ""
    dynamic var phyle = ""
    dynamic var career = ""
    dynamic var powerRank = ""

}

class GameConfigRecord: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var player1 = ""
    dynamic var player2 = ""
    dynamic var player3 = ""
    dynamic var player4 = ""
    dynamic var player5 = ""
    dynamic var player1Position = ""
    dynamic var player2Position = ""
    dynamic var player3Position = ""
    dynamic var player4Position = ""
    dynamic var player5Position = ""
    //dynamic var player1Property = ""
    //dynamic var player2Property = ""
    //dynamic var player3Property = ""
    //dynamic var player4Property = ""
    //dynamic var player5Property = ""
    dynamic var combo1 = ""
    dynamic var combo2 = ""
    dynamic var combo3 = ""
}




