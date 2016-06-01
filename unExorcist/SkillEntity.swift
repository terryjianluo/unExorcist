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
    var skillMode:String!
    var timeCount = NSTimeInterval(0)
    
    init(cast:HeroEntity,config:[String:String],targets:[HeroEntity]) {
        super.init()
        //test dic
        let dic = ["test":Double(0)]
        
        caster = cast
        name = config["name"]
        skillDescription = config["description"]
        skillMode = config["mode"]
        
        let node = BasicNode(code: "Smoke")
        addComponent(node)
        
        let time = SkillTimeCountComponent(config:dic)
        addComponent(time)
        let buff = BuffComponent()
        addComponent(buff)
        
       
    }
    

}
