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
    
    var skillId:String!
    var artSpeed:Float!
    var artCollision:Bool!
    var artID:String!
    
    init(id:String,caster:HeroEntity) {
        super.init()
        casterEntity = caster
        skillId = id
        
        //增加多种配置
        config = CoreDataManager().spellConfig(id, dataModel: SkillConfigration.self)
        for (k,v) in config {
            if v is Double  {
                configData[k as! String] = v as? Double
            }
        }
        
        skillCastStateMachine = GKStateMachine(states: [SkillReadyState(id:id,caster:caster),NormalSkillState(),SkillMoveState(),SkillActiveState(),SkillEndState()])
        
        cast = false
        
        artSpeed = Float(CoreDataManager().realmSerch(id, property: "speed", dataModel: SkillArt.self))
        let artCollision1 = CoreDataManager().realmSerch(id, property: "collision", dataModel: SkillArt.self)
        if artCollision1 == "yes"{
            artCollision = true
        }else{
            artCollision = false
        }
        
        artID = CoreDataManager().realmSerch(id, property: "fileName", dataModel: SkillArt.self)
        
        let cd = SkillCooldownComponent()
        addComponent(cd)
    }
    

}
