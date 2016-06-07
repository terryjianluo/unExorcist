//
//  SkillManager.swift
//  unExorcist
//
//  Created by Terry on 16/6/3.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit
import UIKit

class SkillManager: GKComponent {
    
    var skillA:SkillEntity!
    var skillB:SkillEntity!
    var skillC:SkillEntity!
    var skillD:SkillEntity!
    var skillE:SkillEntity!
    
    var target:HeroEntity!
    
    init(id:String) {
        super.init()
        //技能列表初始化取自存档（未做成长前，写死）
        skillA = SkillEntity(id: id+"a1",caster:entity as! HeroEntity)
        skillB = SkillEntity(id: id+"b1",caster:entity as! HeroEntity)
        skillC = SkillEntity(id: id+"c1",caster:entity as! HeroEntity)
        skillD = SkillEntity(id: id+"d1",caster:entity as! HeroEntity)
        skillE = SkillEntity(id: id+"e1",caster:entity as! HeroEntity)
        
        skillA.skillCastStateMachine.enterState(SkillReadyState)
        skillB.skillCastStateMachine.enterState(SkillReadyState)
        skillC.skillCastStateMachine.enterState(SkillReadyState)
        skillD.skillCastStateMachine.enterState(SkillReadyState)
        skillE.skillCastStateMachine.enterState(SkillReadyState)
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        //施法方式为 修改Skillentity.cast =  true，并设定skillentity.target
        
        //刷新技能状态机
        let list = [skillA,skillB,skillC,skillD,skillE]
        for skill in list {
            skill.skillCastStateMachine.updateWithDeltaTime(seconds)
        }
        
    }
    
    
    
    
}