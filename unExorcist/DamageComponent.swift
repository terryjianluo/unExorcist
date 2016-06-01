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
        let myDef = (entity!.componentForClass(BasicProperty)?.DEF)! + (entity!.componentForClass(BuffContainer)?.DEF)! - damageInput["penetration"]!
        let myMr = (entity!.componentForClass(BasicProperty)?.MR)! + (entity!.componentForClass(BuffContainer)?.MR)! - damageInput["penetration"]!
        let shield = entity!.componentForClass(BasicProperty)?.shield
        let reducePhy = 100/(100 + myDef)
        let reduceSpell = 100/(100 + myMr)
        
        let random = GKRandomDistribution(randomSource: GKMersenneTwisterRandomSource(), lowestValue: 1, highestValue: 100).nextInt()
        
        for (k,v) in damageInput{
            switch k {
            case "normal":
                if random >= Int(myDodge*100){
                    let damage = v - shield!
                    if damage > 0 {
                        myHP = myHP! - (damage*reducePhy)
                    }else if damage <= 0{
                        entity!.componentForClass(BasicProperty)?.shield! -= v
                    }
                }
                break
            case "critical":
                if random >= Int(myDodge*100){
                    let damage = v - shield!
                    if damage > 0 {
                        myHP = myHP! - (damage*reducePhy)
                    }else if damage <= 0{
                        entity!.componentForClass(BasicProperty)?.shield! -= v
                    }
                }
                break
            case "spell":
                myHP = myHP! - (v*reduceSpell)
                break
            case "spellCritical":
                myHP = myHP! - (v*reduceSpell)
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