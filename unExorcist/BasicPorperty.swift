//
//  BasicPlayer.swift
//  unExorcist
//
//  Created by Terry on 16/3/28.
//  Copyright © 2016年 Terry. All rights reserved.
//

import UIKit
import GameplayKit

class BasicProperty: GKComponent {
    
    var name:String!
    
    var HP:Double!
    var maxHP:Double!
    var maxMP:Double!
    var MP:Double!
    
    var level:Int!
    
    var ATK:Double!
    var DEF:Double!
    var MR:Double!      //魔抗
    var SP:Double!     //魔攻
    
    var HPup:Double! //生命成长
    var MPup:Double! //蓝条成长
    var ATKup:Double! //估计成长
    var DEFup:Double! //护甲成长
    
    var speed:Double! //移动速度
    var range:Double! //射程
    
    
    //辅助属性
    var critical:Double! //物理暴击率
    var spellCritical:Double! //法术暴击率
    var hitPenetration:Double! //物理穿透
    var spellPenetration:Double! //法术穿透
    var hitRating:Double! //物理命中
    var spellHitRating:Double! //法术命中
    var criticalDamage:Double! //物理暴击伤害
    var spellCriticalDamage:Double! //法术暴击伤害
    var dodge:Double! //闪避
    var strikeSpeed:Double! //攻速
    var shield:Double! //护盾
    //战斗力
    var powerRank:Int!
    
    //扩展 技能 天赋
    //var status = "正常"
    
    var threaten:Double! //威胁值
    var assist:Double! //协助值
    
    //种族
    var phyle:Int!
    
    //职业
    var career:Int!
    
    //队伍
    var team:String!
    
    //攻速刷新时间
    var updateTime = TimeInterval(0)
    
    init(id:String,team:String) {
        super.init()
        self.name = propertyDic(id).value(forKey: "name") as! String
        self.level = propertyDic(id).value(forKey: "level") as! Int
        self.HP = propertyDic(id).value(forKey: "HP") as! Double
        self.MP = propertyDic(id).value(forKey: "MP") as! Double
        self.maxHP = HP
        self.maxMP = MP
        self.ATK = propertyDic(id).value(forKey: "ATK") as! Double
        self.DEF = propertyDic(id).value(forKey: "DEF") as! Double
        self.MR = propertyDic(id).value(forKey: "MR") as! Double
        self.SP = propertyDic(id).value(forKey: "SP") as! Double
        self.speed = propertyDic(id).value(forKey: "speed") as! Double
        self.range = propertyDic(id).value(forKey: "range") as! Double
        self.critical = propertyDic(id).value(forKey: "critical") as! Double
        self.spellCritical = propertyDic(id).value(forKey: "spellCritical") as! Double
        self.hitPenetration = propertyDic(id).value(forKey: "hitPenetration") as! Double
        self.spellPenetration = propertyDic(id).value(forKey: "spellPenetration") as! Double
        self.hitRating = propertyDic(id).value(forKey: "hitRating") as! Double
        self.spellHitRating = propertyDic(id).value(forKey: "spellHitRating") as! Double
        self.criticalDamage = propertyDic(id).value(forKey: "criticalDamage") as! Double
        self.spellCriticalDamage = propertyDic(id).value(forKey: "spellCriticalDamage") as! Double
        self.dodge = propertyDic(id).value(forKey: "dodge") as! Double
        self.strikeSpeed = propertyDic(id).value(forKey: "strikeSpeed") as! Double
        self.shield = 0
        self.powerRank = propertyDic(id).value(forKey: "powerRank") as! Int
        self.threaten = propertyDic(id).value(forKey: "threaten") as! Double
        self.assist = propertyDic(id).value(forKey: "assist") as! Double
        self.phyle = propertyDic(id).value(forKey: "phyle") as! Int
        self.career = propertyDic(id).value(forKey: "career") as! Int
        
        self.HPup = propertyDic(id).value(forKey: "HPup") as! Double
        self.MPup = propertyDic(id).value(forKey: "MPup") as! Double
        self.ATKup = propertyDic(id).value(forKey: "ATKup") as! Double
        self.DEFup = propertyDic(id).value(forKey: "DEFup") as! Double
        
        self.team = team
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func propertyDic(_ id:String) -> NSDictionary{
        let dic = CoreDataManager().PropertyDictionary(id, dataModel: PlayerProperty.self)
        return dic
    }

}
