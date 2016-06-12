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
    var fx:SkillEffectEntity!
    
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
            mySkill.casterEntity.componentForClass(BasicNode)?.node.parent?.addChild((fx.componentForClass(BasicNode)?.node)!)
            mySkill.componentForClass(SkillCooldownComponent)?.cd = mySkill.configData["coolDown"]! as NSTimeInterval
            
            stateMachine?.enterState(NormalSkillState)
        }
    }
    
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        // 技能初始化显示等方法; 监听ai，等待指令施法
    }
    
    override func willExitWithNextState(nextState: GKState) {
        (nextState as! NormalSkillState).mySkill = mySkill
        (nextState as! NormalSkillState).fx = fx
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        if (mySkill.cast == true) && (mySkill.componentForClass(SkillCooldownComponent)?.cd == 0) {
            castSkillCheck()
        }else{
            mySkill.updateWithDeltaTime(seconds)
        }
    }
    
}


class NormalSkillState:GKState{
    
    var mySkill:SkillEntity!
    var fx:SkillEffectEntity!
    
    
    func skillInit(){
        
        //组件列表(加载 即时生效 无计时的效果)
        let buff = BuffComponent(id: mySkill.configData, target: mySkill.target)
        let damage = SkillDamage(config:  mySkill.configData, target: mySkill.target)
        let aoe = AOEComponent()
        
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
            mySkill.addComponent(aoe)
        }else if skillConfig.rangeOfString(controlConfig).location != NSNotFound{
            
        }else if skillConfig.rangeOfString(damageConfg).location != NSNotFound{
            mySkill.addComponent(damage)            
        }else if skillConfig.rangeOfString(dotConfig).location != NSNotFound{
            
        }else if skillConfig.rangeOfString(healConfig).location != NSNotFound{
            
        }else if skillConfig.rangeOfString(moveConfig).location != NSNotFound{
            
        }
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        skillInit()
        if mySkill.artSpeed > 0{
            stateMachine?.enterState(SkillMoveState)
        }else {
            stateMachine?.enterState(SkillActiveState)
        }
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if mySkill.artSpeed > 0{
            (nextState as! SkillMoveState).mySkill = mySkill
            (nextState as! SkillMoveState).fx = fx
        }else {
            (nextState as! SkillActiveState).mySkill = mySkill
            (nextState as! SkillActiveState).fx = fx
        }
        
    }
    
}


class SkillMoveState:GKState{
    
    //需求增加碰撞检测方法
    
    var mySkill:SkillEntity!
    var fx:SkillEffectEntity!
    
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        
        
    }
    
    func effectMove(seconds: NSTimeInterval){
        let position = fx.componentForClass(BasicNode)!.node.position
        let path = CGPathCreateMutable()
        let positionTarget = fx.componentForClass(Movement)?.myTarget.componentForClass(BasicNode)?.node.position
        CGPathAddArc(path, nil, positionTarget!.x, positionTarget!.y, 15, 0, CGFloat(2*M_PI), false)
        CGPathCloseSubpath(path)
        if CGPathContainsPoint(path, nil, position, false) {
            
            stateMachine?.enterState(SkillActiveState)
            fx.componentForClass(BasicNode)!.node.removeFromParent()
        }else{
            fx.componentForClass(Movement)!.updateWithDeltaTime(seconds)
        }
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        //mySkill.updateWithDeltaTime(seconds)
        effectMove(seconds)
        mySkill.componentForClass(SkillCooldownComponent)?.updateWithDeltaTime(seconds)
    }
    
}

class SkillActiveState:GKState{
    
    var mySkill:SkillEntity!
    var fx:SkillEffectEntity!
    
    //编写技能结束进入下一步骤的方法，当前dot无法刷新
    override func didEnterWithPreviousState(previousState: GKState?) {
        
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        mySkill.updateWithDeltaTime(seconds)
    }
    
}
