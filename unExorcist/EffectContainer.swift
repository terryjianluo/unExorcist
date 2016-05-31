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
import CoreGraphics

class EffectContainer:GKComponent {
    
    var effects = Set<EffectEntity>()
    
    func addEffect(effect:EffectEntity){
        effects.insert(effect)
    }
    
    func removeEffect(effect:EffectEntity){
        effects.remove(effect)
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        for fx in effects {
            let position = fx.componentForClass(BasicNode)!.node.position
            let path = CGPathCreateMutable()
            let positionTarget = fx.componentForClass(Movement)?.myTarget.componentForClass(BasicNode)?.node.position
            CGPathAddArc(path, nil, positionTarget!.x, positionTarget!.y, 15, 0, CGFloat(2*M_PI), false)
            CGPathCloseSubpath(path)
            if CGPathContainsPoint(path, nil, position, false) {
                let damage = entity?.componentForClass(AttackComponent)?.damageOutput()
                entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(DamageComponent)?.damage(damage!)
                for (_,v) in damage!{
                    entity?.componentForClass(BasicProperty)?.threaten! += v
                }
                
                print("target HP = \(entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicProperty)?.HP) ")
                effects.remove(fx)
                fx.componentForClass(BasicNode)!.node.removeFromParent()
            }else{
                fx.componentForClass(Movement)!.updateWithDeltaTime(seconds)
            }
        }
    }
    
}