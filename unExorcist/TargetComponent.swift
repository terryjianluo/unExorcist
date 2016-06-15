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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //需增加切换目标重置攻击计时
    func targetChoose() -> HeroEntity{
        var target:HeroEntity!
        // 增加判断空值的逻辑
        if myEntity.componentForClass(BasicProperty)?.team == "partner"{
            let entities = entityManager.enemys
            for entity in entities{
                if entity.componentForClass(BasicProperty)?.team == "enemy"{
                target = entity
                }
            }
        }else{
            let entities = entityManager.teammates
            for entity in entities{
                if entity.componentForClass(BasicProperty)?.team == "partner"{
                    target = entity
                }
            }
        }
        if target == nil {
            target = myEntity
        }
        
        return target
    }
    
    override func update(withDeltaTime seconds: TimeInterval) {
        if myEntity.target != targetChoose() {
            myEntity.componentForClass(BasicProperty)?.updateTime = 0
            myEntity.target = targetChoose()
        }
        
    }
    
    
}
