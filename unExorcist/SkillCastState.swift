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
            mySkill.componentForClass(SkillCooldownComponent)?.cd = mySkill.configData["coolDown"]! as TimeInterval
            
            stateMachine?.enterState(NormalSkillState)
        }
    }
    
    
    override func didEnter(withPreviousState previousState: GKState?) {
        // 技能初始化显示等方法; 监听ai，等待指令施法
    }
    
    override func willExit(withNextState nextState: GKState) {
        (nextState as! NormalSkillState).mySkill = mySkill
        (nextState as! NormalSkillState).fx = fx
    }
    
    override func update(withDeltaTime seconds: TimeInterval) {
        if (mySkill.cast == true) && (mySkill.componentForClass(SkillCooldownComponent)?.cd == 0) {
            castSkillCheck()
        }else{
            mySkill.update(withDeltaTime: seconds)
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
        //临时位置输入
        let aoe = AOEComponent(config: mySkill.configData, startPoint: (mySkill.target.componentForClass(BasicNode)?.node.position)!)
        
        let skillConfig = mySkill.config.value(forKey: "description") as! NSString
        let buffConfig = SkillType.buff.rawValue
        let aoeConfig = SkillType.aoe.rawValue
        let controlConfig = SkillType.control.rawValue
        let damageConfg = SkillType.damage.rawValue
        let dotConfig = SkillType.dot.rawValue
        let healConfig = SkillType.heal.rawValue
        let moveConfig = SkillType.move.rawValue
        
        if skillConfig.range(of: buffConfig).location != NSNotFound{
            mySkill.addComponent(buff)
        }else if skillConfig.range(of: aoeConfig).location != NSNotFound{
            mySkill.addComponent(aoe)
        }else if skillConfig.range(of: controlConfig).location != NSNotFound{
            
        }else if skillConfig.range(of: damageConfg).location != NSNotFound{
            mySkill.addComponent(damage)            
        }else if skillConfig.range(of: dotConfig).location != NSNotFound{
            
        }else if skillConfig.range(of: healConfig).location != NSNotFound{
            
        }else if skillConfig.range(of: moveConfig).location != NSNotFound{
            
        }
    }
    
    override func didEnter(withPreviousState previousState: GKState?) {
        skillInit()
        if mySkill.artSpeed > 0{
            stateMachine?.enterState(SkillMoveState)
        }else {
            stateMachine?.enterState(SkillActiveState)
        }
    }
    
    override func willExit(withNextState nextState: GKState) {
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
    
    
    override func didEnter(withPreviousState previousState: GKState?) {
        
        
    }
    
    func effectMove(_ seconds: TimeInterval){
        let position = fx.componentForClass(BasicNode)!.node.position
        let path = CGMutablePath()
        let positionTarget = fx.componentForClass(Movement)?.myTarget.componentForClass(BasicNode)?.node.position
        path.addArc(nil, x: positionTarget!.x, y: positionTarget!.y, radius: 15, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: false)
        path.closeSubpath()
        if path.containsPoint(nil, point: position, eoFill: false) {
            
            stateMachine?.enterState(SkillActiveState)
            fx.componentForClass(BasicNode)!.node.removeFromParent()
        }else{
            fx.componentForClass(Movement)!.update(withDeltaTime: seconds)
        }
    }
    
    override func update(withDeltaTime seconds: TimeInterval) {
        //mySkill.updateWithDeltaTime(seconds)
        effectMove(seconds)
        mySkill.componentForClass(SkillCooldownComponent)?.update(withDeltaTime: seconds)
    }
    
}

class SkillActiveState:GKState{
    
    var mySkill:SkillEntity!
    var fx:SkillEffectEntity!
    
    //编写技能结束进入下一步骤的方法，当前dot无法刷新
    override func didEnter(withPreviousState previousState: GKState?) {
        
    }
    
    override func update(withDeltaTime seconds: TimeInterval) {
        mySkill.update(withDeltaTime: seconds)
    }
    
}
