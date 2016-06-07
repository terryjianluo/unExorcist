//
//  DamageComponent.swift
//  unExorcist
//
//  Created by Terry on 16/4/1.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class DamageComponent: GKComponent{
    
    var lastAtk = NSTimeInterval(0)
    
    /*init(selfEntity:HeroEntity) {
        super.init()
        myEntity = selfEntity
    }*/
    
    func damage(damageInput:[String:Double]){
        var myHP = entity!.componentForClass(BasicProperty)?.HP
        let myDodge = (entity!.componentForClass(BasicProperty)?.dodge)! + (entity!.componentForClass(BuffContainer)?.dodge)!
        let myDef = (entity!.componentForClass(BasicProperty)?.DEF)! + (entity!.componentForClass(BuffContainer)?.DEF)! - damageInput["hitPenetration"]!
        let myMr = (entity!.componentForClass(BasicProperty)?.MR)! + (entity!.componentForClass(BuffContainer)?.MR)! - damageInput["spellPenetration"]!
        var shield = entity!.componentForClass(BasicProperty)?.shield
        let reducePhy = 100/(100 + myDef)
        let reduceSpell = 100/(100 + myMr)
        
        let random = GKRandomDistribution(randomSource: GKMersenneTwisterRandomSource(), lowestValue: 1, highestValue: 100).nextInt()
        
        for (k,v) in damageInput{
            switch k {
            case "hitDamage":
                if random >= Int(myDodge*100){
                    let damage = v - shield!
                    if damage > 0 {
                        entity!.componentForClass(BasicProperty)?.shield! = 0
                        shield = entity!.componentForClass(BasicProperty)?.shield
                        myHP = myHP! - (damage*reducePhy)
                    }else if damage <= 0{
                        entity!.componentForClass(BasicProperty)?.shield! -= v
                        shield = entity!.componentForClass(BasicProperty)?.shield
                    }
                }
                break
            case "spellDamage":
                let damage = v - shield!
                if damage > 0 {
                    entity!.componentForClass(BasicProperty)?.shield! = 0
                    shield = entity!.componentForClass(BasicProperty)?.shield
                    myHP = myHP! - (damage*reduceSpell)
                }else if damage <= 0{
                    entity!.componentForClass(BasicProperty)?.shield! -= v
                    shield = entity!.componentForClass(BasicProperty)?.shield
                }
                break
            default:
                break
            }
        }
        
        if myHP > 0{
            let hp = Int(myHP!)
            entity!.componentForClass(BasicProperty)?.HP = Double(hp)
        }else{
            //die
            entity!.componentForClass(BasicProperty)?.HP = 0
        }
        
    }
    
}