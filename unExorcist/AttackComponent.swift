//
//  HeroComponent.swift
//  unExorcist
//
//  Created by Terry on 16/3/28.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class AttackComponent: GKComponent{
    
    var lastAtk = NSTimeInterval(0)
    
    func damageOutput() -> [String:Double]{
        var damage:[String:Double]!
        
        let critical1 = entity!.componentForClass(BasicProperty)?.critical
        let critical2 = entity!.componentForClass(BuffContainer)?.critical
        let critical = Int((critical1! + critical2!) * 100)
        
        let missrating1 = entity!.componentForClass(BasicProperty)?.hitRating
        let missrating2 = entity!.componentForClass(BuffContainer)?.hitRating
        let missRating = Int(100 - ((missrating1! + missrating2!) * 100))
        
        let atk1 = entity!.componentForClass(BasicProperty)?.ATK
        let atk2 = entity!.componentForClass(BuffContainer)?.ATK
        let atk = atk1! + atk2!
        
        let criticalDamage1 = entity!.componentForClass(BasicProperty)?.criticalDamage
        let criticalDamage2 = entity!.componentForClass(BuffContainer)?.criticalDamage
        let criticalDamage =  criticalDamage1! + criticalDamage2!
        
        let random = GKRandomDistribution(randomSource: GKMersenneTwisterRandomSource(), lowestValue: 1, highestValue: 100).nextInt()
        print("random-\(random)||miss\(missRating)||cri\(critical)")
        switch random {
        case 1...missRating:
            //未命中
            damage["miss"] = 0
            break
        case (missRating + 1) ... (critical + missRating):
            //未命中
            let d = atk * criticalDamage
            damage["hitDamage"] = d
            break
        default:
            damage["hitDamage"] = atk
            break
        }
        let penetration1 = entity!.componentForClass(BasicProperty)?.hitPenetration
        let penetration2 = entity!.componentForClass(BuffContainer)?.hitPenetration
        let penetration = penetration1! + penetration2!
        damage["hitPenetration"] = penetration
        print(damage)
        
        return damage
    }
    
    
    func damage(){
        let range1 = entity!.componentForClass(BasicProperty)?.range
        let range2 = entity!.componentForClass(BuffContainer)?.range
        let range = range1! + range2!
        let myEntityPosition = entity!.componentForClass(BasicNode)?.node.position
        let targetPosition = entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicNode)?.node.position
        
        let distance = Double(sqrt(pow(((myEntityPosition?.x)! - (targetPosition?.x)!), 2) + pow(((myEntityPosition?.y)! - (targetPosition?.y)!), 2)))
        
        if (range >= distance) && ((entity as! HeroEntity).target != entity) == true {
            let effect = EffectEntity(parent:entity as! HeroEntity)
                        entity!.componentForClass(BasicNode)?.node.parent?.addChild((effect.componentForClass(BasicNode)?.node)!)
            entity?.componentForClass(EffectContainer)?.addEffect(effect)
            
        }else if range < distance{
            //out of range
            print("Out of range || distance \(distance)")
        }

    }
    
    
}