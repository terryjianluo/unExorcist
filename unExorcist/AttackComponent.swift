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
    
    /*
    init(selfEntity:HeroEntity){
        super.init()
        myEntity = selfEntity
    }*/
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        let strikeSpeed = entity!.componentForClass(BasicProperty)?.strikeSpeed
        if (CACurrentMediaTime() - lastAtk > strikeSpeed) {
            lastAtk = CACurrentMediaTime()
            damage()
        }
    }
    
    func damageOutput() -> [String:Double]{
        var damage:[String:Double]!
        let critical = Int((entity!.componentForClass(BasicProperty)?.critical)! * 100)
        let missRating = Int(100 - ((entity!.componentForClass(BasicProperty)?.hitRating)! * 100))
        let atk = entity!.componentForClass(BasicProperty)?.ATK
        let criticalDamage = entity!.componentForClass(BasicProperty)?.criticalDamage
        
        let random = GKRandomDistribution(randomSource: GKMersenneTwisterRandomSource(), lowestValue: 1, highestValue: 100).nextInt()
        print("random-\(random)||miss\(missRating)||cri\(critical)")
        switch random {
        case 1...missRating:
            //未命中
            damage = ["miss":0]
            break
        case (missRating + 1) ... (critical + missRating):
            //未命中
            let d = atk! * criticalDamage!
            damage = ["critical":d]
            break
        default:
            damage = ["normal":atk!]
            break
        }
        print(damage)
        
        return damage
    }
    
    
    func damage(){
        let range = entity!.componentForClass(BasicProperty)?.range
        let myEntityPosition = entity!.componentForClass(BasicNode)?.node.position
        let targetPosition = entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicNode)?.node.position
        
        let distance = Double(sqrt(pow(((myEntityPosition?.x)! - (targetPosition?.x)!), 2) + pow(((myEntityPosition?.y)! - (targetPosition?.y)!), 2)))
        
        if range >= distance {
            let effect = EffectEntity(parent:entity as! HeroEntity)
            entity!.componentForClass(BasicNode)?.node.parent?.addChild((effect.componentForClass(BasicNode)?.node)!)
            entity?.componentForClass(EffectContainer)?.addEffect(effect)
            
            //let damage = self.damageOutput()
            //entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(DamageComponent)?.damage(damage)
            //print("target HP = \(entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicProperty)?.HP) \n team = \(entity!.componentForClass(BasicProperty)?.team)")
        }else{
            //out of range
            print("Out of range || distance \(distance)")
        }

    }
    
    
}