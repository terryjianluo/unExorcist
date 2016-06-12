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
    
    dynamic var usrId = ""
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
    
    /*待功能完善后开放
    dynamic var player1Equipment:HeroEquip?
    dynamic var player2Equipment:HeroEquip?
    dynamic var player3Equipment:HeroEquip?
    dynamic var player4Equipment:HeroEquip?
    dynamic var player5Equipment:HeroEquip?
    dynamic var combo1:SkillCombo?
    dynamic var combo2:SkillCombo?
    dynamic var combo3:SkillCombo?
    dynamic var bag:Pakage?
     
     dynamic var diamond = ""
     dynamic var gold = ""
    */
    
    override static func indexedProperties() -> [String] {
        return ["usrId"]
    }
}

class Pakage: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var id = ""
    dynamic var number = ""
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
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
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}

class HeroEquip: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var head = ""
    dynamic var shoulder = ""
    dynamic var arm = ""
    dynamic var leg = ""
    dynamic var body = ""
    dynamic var shoe = ""
    dynamic var weapon = ""
    dynamic var ring = ""
}

class SkillCombo: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var name = ""
    dynamic var first = ""
    dynamic var second = ""
    dynamic var third = ""
    dynamic var fouth = ""
    dynamic var fifth = ""
    dynamic var sixth = ""
    dynamic var seventh = ""
}





class SkillConfigration: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var skillDescription = ""
    dynamic var team = ""
    dynamic var coolDown = ""
    dynamic var manaCost = ""
    dynamic var hitDamage = ""
    dynamic var hitDamageUp = ""
    dynamic var spDamage = ""
    dynamic var spDamageUp = ""
    dynamic var sumTime = ""
    dynamic var timePerEffect = ""
    dynamic var sumPerEffect = ""
    dynamic var spDamagePerEffect = ""
    dynamic var hitDamagePerEffect = ""
    dynamic var skillRange = ""
    dynamic var aoeRange = ""
    dynamic var move = ""
    dynamic var direction = ""
    dynamic var maxHP = ""
    dynamic var maxMP = ""
    dynamic var ATK = ""
    dynamic var DEF = ""
    dynamic var MR = ""
    dynamic var SP = ""
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
    dynamic var control = ""
    dynamic var controlTime = ""

}


class SkillArt: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var speed = ""
    dynamic var collision = ""
}

class SkillGlobal: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    dynamic var chn = ""
    dynamic var cht = ""
    dynamic var en = ""
    dynamic var kr = ""
    dynamic var jp = ""
}
