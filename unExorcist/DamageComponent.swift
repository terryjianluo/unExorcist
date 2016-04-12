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
    
    let myEntity:HeroEntity
    
    
    var lastAtk = NSTimeInterval(0)
    
    init(selfEntity:HeroEntity) {
        myEntity = selfEntity
    }
    
    func damage(damageInput:[String:Double]){
        var myHP = myEntity.componentForClass(BasicProperty)?.HP
        let myDodge = myEntity.componentForClass(BasicProperty)?.dodge
        let myDef = myEntity.componentForClass(BasicProperty)?.DEF
        let myMr = myEntity.componentForClass(BasicProperty)?.MR
        let reducePhy = 100/(100 + myDef!)
        let reduceSpell = 100/(100 + myMr!)
        
        let random = GKRandomDistribution(randomSource: GKMersenneTwisterRandomSource(), lowestValue: 1, highestValue: 100).nextInt()
        
        for (k,v) in damageInput{
            switch k {
            case "normal":
                if random >= Int(myDodge!*100){
                    myHP = myHP! - (v*reducePhy)
                }
                break
            case "critical":
                if random >= Int(myDodge!*100){
                    myHP = myHP! - (v*reducePhy)
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
            myEntity.componentForClass(BasicProperty)?.HP = Double(hp)
        }else{
            //die
            myEntity.componentForClass(BasicProperty)?.HP = 0
        }
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        //let strikeSpeed = myEntity.componentForClass(BasicProperty)?.strikeSpeed
        //if (CACurrentMediaTime() - lastAtk > strikeSpeed) {
        //    lastAtk = CACurrentMediaTime()
        //}

    }
    
}