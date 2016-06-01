//
//  BuffContainer.swift
//  unExorcist
//
//  Created by Terry on 16/6/1.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit

class BuffContainer:GKComponent{
    
    var maxHP:Double!
    var maxMP:Double!
    
    var ATK:Double!
    var DEF:Double!
    var MR:Double!      //魔抗
    var SP:Double!     //魔攻
    
    var speed:Double! //移动速度
    var range:Double! //射程
    
    
    //辅助属性
    var critical:Double! //物理暴击率
    var spellCritical:Double! //法术暴击率
    var hitPenetration:Double! //物理穿透
    var spellPenetration:Double! //法术穿透
    var hitRating:Double! //物理命中
    var spellHitRating:Double! //法术命中
    var criticalDamage:Double! //物理暴击伤害
    var spellCriticalDamage:Double! //法术暴击伤害
    var dodge:Double! //闪避
    var strikeSpeed:Double! //攻速
    
    init(initNum:Double) {
        super.init()
        maxHP = initNum
        maxMP = initNum
        
        ATK = initNum
        DEF = initNum
        MR = initNum      //魔抗
        SP = initNum     //魔攻
        
        speed = initNum //移动速度
        range = initNum //射程
        
        
        //辅助属性
        critical = initNum //物理暴击率
        spellCritical = initNum //法术暴击率
        hitPenetration = initNum //物理穿透
        spellPenetration = initNum //法术穿透
        hitRating = initNum //物理命中
        spellHitRating = initNum //法术命中
        criticalDamage = initNum //物理暴击伤害
        spellCriticalDamage = initNum //法术暴击伤害
        dodge = initNum //闪避
        strikeSpeed = initNum //攻速
    }
    
}