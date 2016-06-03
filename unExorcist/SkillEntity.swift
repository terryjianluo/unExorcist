//
//  SkillEntity.swift
//  unExorcist
//
//  Created by Terry on 16/5/30.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class SkillEntity:GKEntity{
    
    //ready->normal->circle->end->cooldown , 增加初始化skillentity
    let skillCastStateMachine = GKStateMachine(states: [SkillReadyState(),NormalSkillState(),CircleSkillState(),SkillCooldowntate(),SkillEndState()])
    var casterEntity:HeroEntity!
    
    var config:NSDictionary!
    var configData:[String:Double]!
    
    init(id:String,caster:HeroEntity) {
        super.init()
        casterEntity = caster
        
        let node = BasicNode(code: "Smoke")
        addComponent(node)
        
        //增加多种配置
        config = CoreDataManager().spellConfig(id, dataModel: SkillConfigration.self)
        for (k,v) in config {
            if v is Double  {
                configData[k as! String] = v as? Double
            }
        }
        
        skillCastStateMachine.enterState(SkillReadyState)
    }
    

}
