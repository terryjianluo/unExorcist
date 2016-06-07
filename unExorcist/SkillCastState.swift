//
//  SkillCastState.swift
//  unExorcist
//
//  Created by Terry on 16/6/2.
//  Copyright © 2016年 Terry. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

//ready->normal->circle->end->cooldown , 增加初始化skillentity
class SkillReadyState:GKState{
    
    var mySkill:SkillEntity!
    
    init(id:String,caster:HeroEntity){
        super.init()
        mySkill = SkillEntity(id: id, caster: caster)
    }
    
    func castSkillCheck() {
        let manaCost = mySkill.configData["manaCost"]
        let heroMP = mySkill.casterEntity.componentForClass(BasicProperty)?.MP
        let range = mySkill.configData["skillRange"]
        let myEntityPosition = mySkill.casterEntity.componentForClass(BasicNode)?.node.position
        let targetPosition = mySkill.target.componentForClass(TargetComponent)?.targetChoose().componentForClass(BasicNode)?.node.position
        
        let distance = Double(sqrt(pow(((myEntityPosition?.x)! - (targetPosition?.x)!), 2) + pow(((myEntityPosition?.y)! - (targetPosition?.y)!), 2)))
        
        
        if (manaCost <= heroMP) && (range >= distance){
            
            mySkill.casterEntity.componentForClass(BasicProperty)?.MP = heroMP! - manaCost!
            
            stateMachine?.enterState(NormalSkillState)
        }
    }
    
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        // 技能初始化显示等方法; 监听ai，等待指令施法
    }
    
    override func willExitWithNextState(nextState: GKState) {
        (nextState as! NormalSkillState).mySkill = mySkill
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        if mySkill.cast == true {
            castSkillCheck()
        }
    }
    
}


class NormalSkillState:GKState{
    
    var mySkill:SkillEntity!
    
    
    func skillInit(){
        
        //组件列表(加载 即时生效 无计时的效果)
        let buff = BuffComponent(id: mySkill.configData, target: mySkill.target)
        let damage = SkillDamage(config:  mySkill.configData, target: mySkill.target)
        
        let skillConfig = mySkill.config.valueForKey("description") as! NSString
        let buffConfig = SkillType.buff.rawValue
        let aoeConfig = SkillType.aoe.rawValue
        let controlConfig = SkillType.control.rawValue
        let damageConfg = SkillType.damage.rawValue
        let dotConfig = SkillType.dot.rawValue
        let healConfig = SkillType.heal.rawValue
        let moveConfig = SkillType.move.rawValue
        
        if skillConfig.rangeOfString(buffConfig).location != NSNotFound{
            mySkill.addComponent(buff)
        }else if skillConfig.rangeOfString(aoeConfig).location != NSNotFound{
            
        }else if skillConfig.rangeOfString(controlConfig).location != NSNotFound{
            
        }else if skillConfig.rangeOfString(damageConfg).location != NSNotFound{
            mySkill.addComponent(damage)            
        }else if skillConfig.rangeOfString(dotConfig).location != NSNotFound{
            
        }else if skillConfig.rangeOfString(healConfig).location != NSNotFound{
            
        }else if skillConfig.rangeOfString(moveConfig).location != NSNotFound{
            
        }
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        mySkill.updateWithDeltaTime(seconds)
    }
    
    override func willExitWithNextState(nextState: GKState) {
        (nextState as! SkillEndState).mySkill = mySkill
    }
    
}

/*
class CircleSkillState:GKState{
    
    var mySkill:SkillEntity!
    
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        mySkill.updateWithDeltaTime(seconds)
    }
    
}
*/

class SkillEndState:GKState{
    
    var mySkill:SkillEntity!
    
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
    }
    
}

class SkillCooldowntate:GKState{
    
    var mySkill:SkillEntity!
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
    }
    
}