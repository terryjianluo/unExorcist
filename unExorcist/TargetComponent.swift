//
//  TargetComponent.swift
//  unExorcist
//
//  Created by Terry on 16/4/5.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class TargetComponent:GKComponent{
    
    var myEntity:HeroEntity!
    var entityManager:EntityManager!
    
    init(selfEntity:HeroEntity ,manager:EntityManager) {
        super.init()
        myEntity = selfEntity
        entityManager = manager
        myEntity.target = targetChoose()
    }
    
    func targetChoose() -> HeroEntity{
        var target:HeroEntity!
        let entities = entityManager.entities
        
        for entity in entities{
            if entity.componentForClass(BasicProperty)?.team != myEntity.componentForClass(BasicProperty)?.team{
                target = entity
            }
        }
        return target
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        myEntity.target = targetChoose()
    }
    
    
}