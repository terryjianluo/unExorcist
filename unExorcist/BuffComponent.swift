//
//  BuffComponent.swift
//  unExorcist
//
//  Created by Terry on 16/5/30.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class BuffComponent: GKComponent{
    
    func buff(config:[String:Double]){
        let hero = (entity as! SkillEntity).targetHero
        if let node = (entity as! SkillEntity).componentForClass(BasicNode)?.node {
            node.position = CGPoint(x: 0, y: 42)
            (entity as! SkillEntity).caster.componentForClass(BasicNode)?.node.addChild(node)
        }
        for (k,v) in config{
            var delta = Double(0)
            delta += v
            switch k {
            case "msxHP":
                hero.componentForClass(BuffContainer)?.maxHP = delta
                break
            case "msxMP":
                hero.componentForClass(BuffContainer)?.maxMP = delta
                break
            case "ATK":
                hero.componentForClass(BuffContainer)?.ATK = delta
                break
            case "DEF":
                hero.componentForClass(BuffContainer)?.DEF = delta
                break
            case "MR":
                hero.componentForClass(BuffContainer)?.MR = delta
                break
            case "SP":
                hero.componentForClass(BuffContainer)?.SP = delta
                break
            case "speed":
                hero.componentForClass(BuffContainer)?.speed = delta
                break
            case "range":
                hero.componentForClass(BuffContainer)?.range = delta
                break
            case "critical":
                hero.componentForClass(BuffContainer)?.critical = delta
                break
            case "spellCritical":
                hero.componentForClass(BuffContainer)?.spellCritical = delta
                break
            case "hitPenetration":
                hero.componentForClass(BuffContainer)?.hitPenetration = delta
                break
            case "spellPenetration":
                hero.componentForClass(BuffContainer)?.spellPenetration = delta
                break
            case "hitRating":
                hero.componentForClass(BuffContainer)?.hitRating = delta
                break
            case "spellHitRating":
                hero.componentForClass(BuffContainer)?.spellHitRating = delta
                break
            case "criticalDamage":
                hero.componentForClass(BuffContainer)?.criticalDamage = delta
                break
            case "spellCriticalDamage":
                hero.componentForClass(BuffContainer)?.spellCriticalDamage = delta
                break
            case "dodge":
                hero.componentForClass(BuffContainer)?.dodge = delta
                break
            case "strikeSpeed":
                hero.componentForClass(BuffContainer)?.strikeSpeed = delta
                break
            default:
                break
            }
        }
        
    }
    
    func buffEnd(){
        let hero = (entity as! SkillEntity).targetHero
        hero.componentForClass(BuffContainer)?.maxHP = 0
        hero.componentForClass(BuffContainer)?.maxMP = 0
        
        hero.componentForClass(BuffContainer)?.ATK = 0
        hero.componentForClass(BuffContainer)?.DEF = 0
        hero.componentForClass(BuffContainer)?.MR = 0      //魔抗
        hero.componentForClass(BuffContainer)?.SP = 0     //魔攻
        
        hero.componentForClass(BuffContainer)?.speed = 0 //移动速度
        hero.componentForClass(BuffContainer)?.range = 0 //射程
        
        
        //辅助属性
        hero.componentForClass(BuffContainer)?.critical = 0 //物理暴击率
        hero.componentForClass(BuffContainer)?.spellCritical = 0 //法术暴击率
        hero.componentForClass(BuffContainer)?.hitPenetration = 0 //物理穿透
        hero.componentForClass(BuffContainer)?.spellPenetration = 0 //法术穿透
        hero.componentForClass(BuffContainer)?.hitRating = 0 //物理命中
        hero.componentForClass(BuffContainer)?.spellHitRating = 0 //法术命中
        hero.componentForClass(BuffContainer)?.criticalDamage = 0 //物理暴击伤害
        hero.componentForClass(BuffContainer)?.spellCriticalDamage = 0 //法术暴击伤害
        hero.componentForClass(BuffContainer)?.dodge = 0 //闪避
        hero.componentForClass(BuffContainer)?.strikeSpeed = 0 //攻速
        
        (entity as! SkillEntity).componentForClass(BasicNode)?.node.removeFromParent()
    }
    
    
}
