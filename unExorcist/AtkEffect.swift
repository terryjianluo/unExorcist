//
//  AtkEffect.swift
//  unExorcist
//
//  Created by Terry on 16/4/14.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class AtkEffect: GKComponent {
    let effect:EffectEntity
    let myEntity:HeroEntity
    
    init(selfEntity:HeroEntity , effectEntity:EffectEntity) {
        super.init()
        myEntity = selfEntity
        effect = effectEntity
        effect.componentForClass(BasicNode)?.node.color = UIColor.redColor()
        effect.componentForClass(BasicNode)?.node.colorBlendFactor = 1
        effect.componentForClass(BasicNode)?.node.position = (myEntity.componentForClass(BasicNode)?.node.position)!
    }
}

