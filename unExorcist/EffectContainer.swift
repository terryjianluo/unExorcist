//
//  EffectContainer.swift
//  unExorcist
//
//  Created by Terry on 16/4/19.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit
import UIKit
import SpriteKit

class EffectContainer:GKComponent {
    
    var effects = Set<EffectEntity>()
    
    func addEffect(effect:EffectEntity){
        effects.insert(effect)
    }
    
    func removeEffect(effect:EffectEntity){
        effects.remove(effect)
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        for effect in effects {
            
            if CGPathContainsPoint(pointAnylazy(effect), nil, effect.componentForClass(BasicNode)!.node.position, false) {
                effects.remove(effect)
                effect.componentForClass(BasicNode)!.node.removeFromParent()
                let damage = entity?.componentForClass(AttackComponent)?.damageOutput()
                entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(DamageComponent)?.damage(damage!)
                print("target HP = \(entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicProperty)?.HP) \n team = \(entity!.componentForClass(BasicProperty)?.team)")
            }else{
                effect.updateWithDeltaTime(seconds)
            }
        }
    }
    
    func pointAnylazy(effectEntity:EffectEntity) -> CGPath {
        let pathRef = CGPathCreateMutable()
        let position = (effectEntity.parentEntity.target.componentForClass(BasicNode)?.node.position)!
        CGPathAddArc(pathRef, nil, position.x, position.y, 5, 0, CGFloat(2*M_PI), false)
        CGPathCloseSubpath(pathRef)
        
        return pathRef
    }
}