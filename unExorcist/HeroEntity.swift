//
//  HeroEntity.swift
//  unExorcist
//
//  Created by Terry on 16/3/28.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class HeroEntity:GKEntity{

    init(id:String,team:String) {
        super.init()
        let spriteComponent = BasicNode(code: id)
        let propertyComponent = BasicProperty(id: id,team:team)
        addComponent(spriteComponent)
        addComponent(propertyComponent)
        let attackComponent = AttackComponent(selfEntity: self)
        addComponent(attackComponent)
        let damageComponent = DamageComponent(selfEntity: self)
        addComponent(damageComponent)
        let effect = 
        addComponent(effect)
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        self.componentForClass(AttackComponent)?.damageOutput()
    }
    
}
