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
    
    
    var buffConfig:[String:Double]!
    var targetEntity:HeroEntity!
    
    init(id:String,target:HeroEntity) {
        super.init()
        buffConfig = skillConfigDic(id)
        targetEntity = target
    }
    
    func skillConfigDic(id:String) -> [String:Double] {
        let dic = CoreDataManager().spellConfig(id, dataModel: SkillConfigration.self)
        var dic1 = ["index":Double(0)]
        for (k,v) in dic {
            if v is Double  {
                dic1[k as! String] = v as? Double
            }
        }
        return dic1
    }
    
    func buff(){
        for (k,v) in buffConfig{
            var delta = Double(0)
            delta += v
            switch k {
            case "maxHP":
                targetEntity.componentForClass(BuffContainer)?.maxHP = delta
                break
            case "maxMP":
                targetEntity.componentForClass(BuffContainer)?.maxMP = delta
                break
            case "ATK":
                targetEntity.componentForClass(BuffContainer)?.ATK = delta
                break
            case "DEF":
                targetEntity.componentForClass(BuffContainer)?.DEF = delta
                break
            case "MR":
                targetEntity.componentForClass(BuffContainer)?.MR = delta
                break
            case "SP":
                targetEntity.componentForClass(BuffContainer)?.SP = delta
                break
            case "speed":
                targetEntity.componentForClass(BuffContainer)?.speed = delta
                break
            case "range":
                targetEntity.componentForClass(BuffContainer)?.range = delta
                break
            case "critical":
                targetEntity.componentForClass(BuffContainer)?.critical = delta
                break
            case "spellCritical":
                targetEntity.componentForClass(BuffContainer)?.spellCritical = delta
                break
            case "hitPenetration":
                targetEntity.componentForClass(BuffContainer)?.hitPenetration = delta
                break
            case "spellPenetration":
                targetEntity.componentForClass(BuffContainer)?.spellPenetration = delta
                break
            case "hitRating":
                targetEntity.componentForClass(BuffContainer)?.hitRating = delta
                break
            case "spellHitRating":
                targetEntity.componentForClass(BuffContainer)?.spellHitRating = delta
                break
            case "criticalDamage":
                targetEntity.componentForClass(BuffContainer)?.criticalDamage = delta
                break
            case "spellCriticalDamage":
                targetEntity.componentForClass(BuffContainer)?.spellCriticalDamage = delta
                break
            case "dodge":
                targetEntity.componentForClass(BuffContainer)?.dodge = delta
                break
            case "strikeSpeed":
                targetEntity.componentForClass(BuffContainer)?.strikeSpeed = delta
                break
            default:
                break
            }
        }
    }
    
    func buffEnd(){
        targetEntity.componentForClass(BuffContainer)?.maxHP = 0
        targetEntity.componentForClass(BuffContainer)?.maxMP = 0
        
        targetEntity.componentForClass(BuffContainer)?.ATK = 0
        targetEntity.componentForClass(BuffContainer)?.DEF = 0
        targetEntity.componentForClass(BuffContainer)?.MR = 0      //魔抗
        targetEntity.componentForClass(BuffContainer)?.SP = 0     //魔攻
        
        targetEntity.componentForClass(BuffContainer)?.speed = 0 //移动速度
        targetEntity.componentForClass(BuffContainer)?.range = 0 //射程
        
        
        //辅助属性
        targetEntity.componentForClass(BuffContainer)?.critical = 0 //物理暴击率
        targetEntity.componentForClass(BuffContainer)?.spellCritical = 0 //法术暴击率
        targetEntity.componentForClass(BuffContainer)?.hitPenetration = 0 //物理穿透
        targetEntity.componentForClass(BuffContainer)?.spellPenetration = 0 //法术穿透
        targetEntity.componentForClass(BuffContainer)?.hitRating = 0 //物理命中
        targetEntity.componentForClass(BuffContainer)?.spellHitRating = 0 //法术命中
        targetEntity.componentForClass(BuffContainer)?.criticalDamage = 0 //物理暴击伤害
        targetEntity.componentForClass(BuffContainer)?.spellCriticalDamage = 0 //法术暴击伤害
        targetEntity.componentForClass(BuffContainer)?.dodge = 0 //闪避
        targetEntity.componentForClass(BuffContainer)?.strikeSpeed = 0 //攻速
        
        (entity as! SkillEntity).componentForClass(BasicNode)?.node.removeFromParent()
    }
    
    
}
