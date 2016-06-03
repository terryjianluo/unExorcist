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
    
    var name:String!
    var skillDescription: String!
    var caster:HeroEntity!
    var targetHero:HeroEntity!
    //var skillMode:String!
    var timeCount = NSTimeInterval(0)
    
    init(cast:HeroEntity,config:[String:String],target:HeroEntity) {
        super.init()
        //test dic
        let dic = ["test":Double(0)]
        targetHero = target
        caster = cast
        name = config["name"]
        skillDescription = config["description"]
        //skillMode = config["mode"]
        
        let node = BasicNode(code: "Smoke")
        addComponent(node)
        
        let buff = BuffComponent()
        addComponent(buff)
        
        let move = Movement(targetEntity: targetHero)
        addComponent(move)
        
        let castSkill = SkillCastComponent(config: dic)
        addComponent(castSkill)
       
    }
    

}
