//
//  EffectEntity.swift
//  unExorcist
//
//  Created by Terry on 16/4/14.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EffectEntity:GKEntity{
    
    var parentEntity:HeroEntity!
    var node:SKSpriteNode!
    var agent:GKAgent2D!
    
    init(parent:HeroEntity) {
        super.init()
        parentEntity = parent
        let spriteComponent = BasicNode(code: "UIAni_1")
        addComponent(spriteComponent)
        node = self.componentForClass(BasicNode)?.node
        self.componentForClass(BasicNode)?.node.color = UIColor.redColor()
        self.componentForClass(BasicNode)?.node.colorBlendFactor = 1
        self.componentForClass(BasicNode)?.node.zPosition = 10
        self.componentForClass(BasicNode)?.node.position = (parent.componentForClass(BasicNode)?.node.position)!
        let moveComponent = Movement(targetEntity: parent.target)
        //effect.agent = moveComponent
        self.addComponent(moveComponent)
        //self.componentForClass(Movement)?.delegate = self
        
        //let seek = GKGoal(toSeekAgent: parent.target.agent)
        //print("test target ----- \(parent.target.agent) \(self.componentForClass(Movement))")
        //self.componentForClass(Movement)!.behavior = GKBehavior(goal: seek, weight: 1)
        //self.componentForClass(Movement)!.maxSpeed = 4000
        //self.componentForClass(Movement)!.maxAcceleration = 4000
        //self.componentForClass(Movement)!.mass = 0.4
        
    }
       
}
