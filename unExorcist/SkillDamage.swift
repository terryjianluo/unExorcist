//
//  SkillDamage.swift
//  unExorcist
//
//  Created by Terry on 16/6/7.
//  Copyright © 2016年 Terry. All rights reserved.
//

import UIKit
import GameplayKit

class SkillDamage: GKComponent {
    
    var skillConfig:[String:Double]!
    var targetEntity:HeroEntity!
    var time = NSTimeInterval(0)
    
    //var effect:SkillEffectEntity!
    
    init(config:[String:Double],target:HeroEntity) {
        super.init()
        skillConfig = config
        targetEntity = target
        //effect = SkillEffectEntity(parent: entity as! SkillEntity)
    }
    
    func damage() -> [String:Double]{
        var damage:[String:Double]!
        
        let critical1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.critical
        let critical2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.critical
        let critical = Int((critical1! + critical2!) * 100)
        
        let atk1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.ATK
        let atk2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.ATK
        let atk = atk1! + atk2!
        
        let criticalDamage1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.criticalDamage
        let criticalDamage2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.criticalDamage
        let criticalDamage =  criticalDamage1! + criticalDamage2!
        
        let spellCritical1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.spellCritical
        let spellCritical2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.spellCritical
        let spellCritical = Int((spellCritical1! + spellCritical2!) * 100)
        
        let spellMissrating1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.spellHitRating
        let spellMissrating2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.spellHitRating
        let spellMissrating = Int(100 - ((spellMissrating1! + spellMissrating2!) * 100))
        
        let sp1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.SP
        let sp2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.SP
        let sp = sp1! + sp2!
        
        let spellCriticalDamage1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.spellCriticalDamage
        let spellCriticalDamage2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.spellCriticalDamage
        let spellCriticalDamage =  spellCriticalDamage1! + spellCriticalDamage2!
        
        let penetration1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.hitPenetration
        let penetration2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.hitPenetration
        let penetration = penetration1! + penetration2!
        
        let spellPenetration1 = (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.spellPenetration
        let spellPenetration2 = (entity as! SkillEntity).casterEntity.componentForClass(BuffContainer)?.spellPenetration
        let spellPenetration = spellPenetration1! + spellPenetration2!
        
        
        let hitRandom = GKRandomDistribution(randomSource: GKMersenneTwisterRandomSource(), lowestValue: 1, highestValue: 100).nextInt()
        let spellRandom = GKRandomDistribution(randomSource: GKMersenneTwisterRandomSource(), lowestValue: 1, highestValue: 100).nextInt()
        
        //hitDamage,hitDamageUp,spDamage,spDamageUp
        
        switch hitRandom {
        case 1...spellMissrating:
            //未命中
            damage["miss"] = 0
            break
        case (spellMissrating + 1) ... (critical + spellMissrating):
            let d = (atk * skillConfig["hitDamageUp"]! + skillConfig["hitDamage"]!) * criticalDamage
            damage["hitDamage"] = d
            break
        default:
            damage = ["hitDamage":(atk * skillConfig["hitDamageUp"]! + skillConfig["hitDamage"]!)]
            break
        }
        
        switch spellRandom {
        case 1...spellMissrating:
            damage["miss"] = 0
            break
        case (spellMissrating + 1) ... (spellCritical + spellMissrating):
            let d = (sp * skillConfig["spDamageUp"]! + skillConfig["spDamage"]!) * spellCriticalDamage
            damage["spellDamage"] = d
            break
        default:
            damage["spellDamage"] = (sp * skillConfig["hitDamageUp"]! + skillConfig["hitDamage"]!)
            break
        }
        
        damage["hitPenetration"] = penetration
        damage["spellPenetration"] = spellPenetration
        
        return damage
    }
    
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        if time == 0 {
            let damage = self.damage()
            (entity as! SkillEntity).target.componentForClass(DamageComponent)?.damage(damage)
            for (k,v) in damage{
                if k == "hitDamage" {
                    (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.threaten! += v
                }else if k == "spellDamage"{
                    (entity as! SkillEntity).casterEntity.componentForClass(BasicProperty)?.threaten! += v
                }
            }
        }
        
        time += seconds
    
    }
}
