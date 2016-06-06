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
    var skillCastStateMachine:GKStateMachine!
    var casterEntity:HeroEntity!
    var target:HeroEntity!
    
    var config:NSDictionary!
    var configData:[String:Double]!
    
    var cast:Bool!
    
    init(id:String,caster:HeroEntity) {
        super.init()
        casterEntity = caster
        
        //根据id设定素材名称
        let node = BasicNode(code: "Smoke")
        addComponent(node)
        
        //增加多种配置
        config = CoreDataManager().spellConfig(id, dataModel: SkillConfigration.self)
        for (k,v) in config {
            if v is Double  {
                configData[k as! String] = v as? Double
            }
        }
        
        skillCastStateMachine = GKStateMachine(states: [SkillReadyState(id:id,caster:caster),NormalSkillState(),SkillCooldowntate(),SkillEndState()])
        
        cast = false
        
    }
    

}
