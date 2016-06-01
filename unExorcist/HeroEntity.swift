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
    
    let agent = GKAgent2D()
    var target:HeroEntity!
    
    init(id:String,team:String) {
        super.init()
        let spriteComponent = BasicNode(code: id)
        let propertyComponent = BasicProperty(id: id,team:team)
        addComponent(spriteComponent)
        addComponent(propertyComponent)
        let buffContainer = BuffContainer(initNum: 0)
        addComponent(buffContainer)
        let effect = EffectContainer()
        addComponent(effect)
        let attackComponent = AttackComponent()
        addComponent(attackComponent)
        let damageComponent = DamageComponent()
        addComponent(damageComponent)
        addComponent(agent)
        target = self
    }
    
}
