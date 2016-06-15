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

//有运动后生效、无运动生效、碰撞生效以及混合模式
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(withDeltaTime seconds: TimeInterval) {
        //施法方式为 修改Skillentity.cast =  true，并设定skillentity.target
        target = (entity as! HeroEntity).componentForClass(TargetComponent)?.targetChoose()
        
        skillA.cast = true
        
        //刷新技能状态机
        let list = [skillA,skillB,skillC,skillD,skillE]
        for skill in list {
            skill?.target = target
            skill?.skillCastStateMachine.update(withDeltaTime: seconds)
        }
        
    }
    
}
