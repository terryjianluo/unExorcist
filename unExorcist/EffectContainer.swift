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
            let path = pointAnylazy()
            if CGPathContainsPoint(path, nil, position, false) {
                effects.remove(fx)
                fx.componentForClass(BasicNode)!.node.removeFromParent()
                fx.removeComponentForClass(BasicNode)
                fx.removeComponentForClass(Movement)
                
                let damage = entity?.componentForClass(AttackComponent)?.damageOutput()
                entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(DamageComponent)?.damage(damage!)
                print("target HP = \(entity!.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicProperty)?.HP) ")
            }else{
                fx.updateWithDeltaTime(seconds)
            }
            
            
        }
    }
    
    func pointAnylazy() -> CGPath {
        let pathRef = CGPathCreateMutable()
        let position = ((entity as! HeroEntity).target.componentForClass(BasicNode)?.node.position)!
        CGPathAddArc(pathRef, nil, position.x, position.y, 5, 0, CGFloat(2*M_PI), false)
        CGPathCloseSubpath(pathRef)
        
        return pathRef
    }
}