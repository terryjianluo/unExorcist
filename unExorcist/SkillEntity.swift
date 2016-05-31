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
    var skillMode:String!
    var timeCount = NSTimeInterval(0)
    
    init(cast:HeroEntity,config:[String:String],targets:[HeroEntity]) {
        super.init()
        caster = cast
        name = config["name"]
        skillDescription = config["description"]
        skillMode = config["mode"]
        let time = SkillTime()
        addComponent(time)
        
        //根据类型选择来加载不同的组件
        let skillType = config["type"]!
        switch skillType {
            case "buff":
            break
            case "damage":
                
            break
            case "aoe":
                //let aoe = AOEComponent(targets: targets)
                //addComponent(aoe)
            break
            case "heal":
            break
            case "support":
            break
            case "halo":
            break
            case "cantrol":
            break
            case "transform":
            break
            default:
            break
        }
    }
    

}
