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
    
    func addEffect(_ effect:EffectEntity){
        effects.insert(effect)
    }
    
    func removeEffect(_ effect:EffectEntity){
        effects.remove(effect)
    }
    
    override func update(withDeltaTime seconds: TimeInterval) {
        for fx in effects {
            let position = fx.componentForClass(BasicNode)!.node.position
            let path = CGMutablePath()
            let positionTarget = fx.componentForClass(Movement)?.myTarget.componentForClass(BasicNode)?.node.position
            path.addArc(nil, x: positionTarget!.x, y: positionTarget!.y, radius: 15, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: false)
            path.closeSubpath()
            if path.containsPoint(nil, point: position, eoFill: false) {
                
                let damage = entity?.componentForClass(AttackComponent)?.damageOutput()
                entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(DamageComponent)?.damage(damage!)
                for (k,v) in damage!{
                    if k == "hitDamage" {
                        entity?.componentForClass(BasicProperty)?.threaten! += v
                    }
                }
                
                print("target HP = \(entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicProperty)?.HP) ")
                effects.remove(fx)
                fx.componentForClass(BasicNode)!.node.removeFromParent()
            }else{
                fx.componentForClass(Movement)!.update(withDeltaTime: seconds)
            }
        }
    }
    
}
