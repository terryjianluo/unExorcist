//
//  CoreDataManager.swift
//  Little Exorcist
//
//  Created by Terry-Patch on 15/6/8.
//  Copyright (c) 2015年 Terry. All rights reserved.
//

import Foundation
import CloudKit
import UIKit
import RealmSwift
import CryptoSwift

class CoreDataManager{
    //let app = UIApplication.sharedApplication().delegate as! AppDelegate
    //let uuid = UIDevice.currentDevice().identifierForVendor!.UUIDString
    let realm = try! Realm()
    
    let rabbitKey = "NxkVoKWJeMao9vUs"
    let rabbitIV = "AejqAXBfsGFspDrc"
    
    //数组和字典转为Json数据,并进行aes加密----暫時作廢
    func anyObject2Json(_ temp:AnyObject) -> NSString{
        let testJson = try? JSONSerialization.data(withJSONObject: temp, options: JSONSerialization.WritingOptions.prettyPrinted)
        let encrypt = testJson?.base64EncodedData(NSData.Base64EncodingOptions())
        print(encrypt)
        let strs = NSString(data: encrypt!, encoding: String.Encoding.utf8.rawValue)
        return strs!
    }
    
    //json转数组
    func json2Array(_ temp:String) -> [String]{
        let strs = NSString(string: temp).data(using: String.Encoding.utf8)
        let json = try? JSONSerialization.jsonObject(with: strs!, options:.allowFragments) as!  NSDictionary
        let array = json!["array"]
        return array! as! [String]
    }
    
    //加密方法
    func aesEncrypt(_ text:String) -> String{
        let str = try! text.encrypt(AES(key: rabbitKey, iv: rabbitIV)).toBase64()
        return str!
    }
    
    //解密方法
    func aesDecrypt(_ text:String) -> String {
        let str = try! text.decryptBase64ToString(AES(key: rabbitKey, iv: rabbitIV))
        return str
    }
    
 
    //csv数据转存realm
    func csv2Realm(_ csvFile:String){
        let fileLocation = Bundle.main().pathForResource(csvFile, ofType: "csv")!
        
        let error: NSErrorPointer? = nil
        
        if let csv = CSV(contentsOfFile: fileLocation, error: error!) {
            // Rows
            let rows = csv.rows
            for value in rows{
                var dataDecode = value
                for (key,dataV) in dataDecode{
                    if key != "id"{
                        //let encode = Base64codeFunc.base64StringFromText(dataV)
                        let encode = aesEncrypt(dataV)
                        //let content = encode as String
                        dataDecode[key] = encode
                    }
                }
            switch csvFile {
            case "save":
                let data = GameRecord(value:dataDecode)
                try! realm.write {
                    realm.add(data)
                }
                break
            case "playerProperty":
                let data = PlayerProperty(value:dataDecode)
                try! realm.write {
                    realm.add(data)
                }
                break
            case "skillConfig":
                let data = SkillConfigration(value:dataDecode)
                try! realm.write {
                    realm.add(data)
                }
                break
            default:
                break
                }
            }
            
        }
    }
    
    //realm数据查询
    func realmSerch(_ key:String,property:String,dataModel:RealmSwift.Object.Type) -> String{
        let data = realm.objects(dataModel).filter("id == %@",key)
        let results = data.value(forKey: property) as! [String]
        let result = aesDecrypt(results[0])
        return result
    }
    
    //查询结果输出数组
    func result2Array(_ result:String) -> [String]{
        let text = NSString(string: result)
        let textCache = text.replacingOccurrences(of: ";", with: "\",\"")
        let jsonText = "{\n\"array\":[\"\(textCache)\"]\n}"
        let json = json2Array(jsonText)
        return json
    }
    
    //英雄属性输出NSDictionary供组件使用
    func PropertyDictionary(_ key:String,dataModel:RealmSwift.Object.Type) -> NSDictionary{
        let data = realm.objects(dataModel).filter("id == %@",key)
        let cache = NSMutableDictionary(dictionary: ["id":key])
        
        let name = data.value(forKey: "name") as! [String]
        let name1 = aesDecrypt(name[0])
        cache.setValue(name1, forKey: "name")
        
        let level = data.value(forKey: "level") as! [String]
        let level1 = aesDecrypt(level[0])
        let level2 = Int(level1)
        cache.setValue(level2, forKey: "level")
        
        let hp = data.value(forKey: "HP") as! [String]
        let hp1 = aesDecrypt(hp[0])
        let hp2 = Double(hp1)
        cache.setValue(hp2, forKey: "HP")
        
        let MP = data.value(forKey: "MP") as! [String]
        let MP1 = aesDecrypt(MP[0])
        let MP2 = Double(MP1)
        cache.setValue(MP2, forKey: "MP")
        
        let ATK = data.value(forKey: "ATK") as! [String]
        let ATK1 = aesDecrypt(ATK[0])
        let ATK2 = Double(ATK1)
        cache.setValue(ATK2, forKey: "ATK")
        
        let DEF = data.value(forKey: "DEF") as! [String]
        let DEF1 = aesDecrypt(DEF[0])
        let DEF2 = Double(DEF1)
        cache.setValue(DEF2, forKey: "DEF")
        
        let MR = data.value(forKey: "MR") as! [String]
        let MR1 = aesDecrypt(MR[0])
        let MR2 = Double(MR1)
        cache.setValue(MR2, forKey: "MR")
        
        let SP = data.value(forKey: "SP") as! [String]
        let SP1 = aesDecrypt(SP[0])
        let SP2 = Double(SP1)
        cache.setValue(SP2, forKey: "SP")
        
        let speed = data.value(forKey: "speed") as! [String]
        let speed1 = aesDecrypt(speed[0])
        let speed2 = Double(speed1)
        cache.setValue(speed2, forKey: "speed")
        
        let range = data.value(forKey: "range") as! [String]
        let range1 = aesDecrypt(range[0])
        let range2 = Double(range1)
        cache.setValue(range2, forKey: "range")
        
        let critical = data.value(forKey: "critical") as! [String]
        let critical1 = aesDecrypt(critical[0])
        let critical2 = Double(critical1)
        cache.setValue(critical2, forKey: "critical")
        
        let spellCritical = data.value(forKey: "spellCritical") as! [String]
        let spellCritical1 = aesDecrypt(spellCritical[0])
        let spellCritical2 = Double(spellCritical1)
        cache.setValue(spellCritical2, forKey: "spellCritical")
        
        let hitPenetration = data.value(forKey: "hitPenetration") as! [String]
        let hitPenetration1 = aesDecrypt(hitPenetration[0])
        let hitPenetration2 = Double(hitPenetration1)
        cache.setValue(hitPenetration2, forKey: "hitPenetration")
        
        let spellPenetration = data.value(forKey: "spellPenetration") as! [String]
        let spellPenetration1 = aesDecrypt(spellPenetration[0])
        let spellPenetration2 = Double(spellPenetration1)
        cache.setValue(spellPenetration2, forKey: "spellPenetration")
        
        let hitRating = data.value(forKey: "hitRating") as! [String]
        let hitRating1 = aesDecrypt(hitRating[0])
        let hitRating2 = Double(hitRating1)
        cache.setValue(hitRating2, forKey: "hitRating")
        
        let spellHitRating = data.value(forKey: "spellHitRating") as! [String]
        let spellHitRating1 = aesDecrypt(spellHitRating[0])
        let spellHitRating2 = Double(spellHitRating1)
        cache.setValue(spellHitRating2, forKey: "spellHitRating")
        
        let criticalDamage = data.value(forKey: "criticalDamage") as! [String]
        let criticalDamage1 = aesDecrypt(criticalDamage[0])
        let criticalDamage2 = Double(criticalDamage1)
        cache.setValue(criticalDamage2, forKey: "criticalDamage")
        
        let spellCriticalDamage = data.value(forKey: "spellCriticalDamage") as! [String]
        let spellCriticalDamage1 = aesDecrypt(spellCriticalDamage[0])
        let spellCriticalDamage2 = Double(spellCriticalDamage1)
        cache.setValue(spellCriticalDamage2, forKey: "spellCriticalDamage")
        
        let dodge = data.value(forKey: "dodge") as! [String]
        let dodge1 = aesDecrypt(dodge[0])
        let dodge2 = Double(dodge1)
        cache.setValue(dodge2, forKey: "dodge")
        
        let strikeSpeed = data.value(forKey: "strikeSpeed") as! [String]
        let strikeSpeed1 = aesDecrypt(strikeSpeed[0])
        let strikeSpeed2 = Double(strikeSpeed1)
        cache.setValue(strikeSpeed2, forKey: "strikeSpeed")
        
        let shield = data.value(forKey: "shield") as! [String]
        let shield1 = aesDecrypt(shield[0])
        let shield2 = Double(shield1)
        cache.setValue(shield2, forKey: "shield")
        
        let powerRank = data.value(forKey: "powerRank") as! [String]
        let powerRank1 = aesDecrypt(powerRank[0])
        let powerRank2 = Double(powerRank1)
        cache.setValue(powerRank2, forKey: "powerRank")
        
        let threaten = data.value(forKey: "threaten") as! [String]
        let threaten1 = aesDecrypt(threaten[0])
        let threaten2 = Double(threaten1)
        cache.setValue(threaten2, forKey: "threaten")
        
        let assist = data.value(forKey: "assist") as! [String]
        let assist1 = aesDecrypt(assist[0])
        let assist2 = Double(assist1)
        cache.setValue(assist2, forKey: "assist")
        
        let phyle = data.value(forKey: "phyle") as! [String]
        let phyle1 = aesDecrypt(phyle[0])
        let phyle2 = Int(phyle1)
        cache.setValue(phyle2, forKey: "phyle")
        
        let career = data.value(forKey: "career") as! [String]
        let career1 = aesDecrypt(career[0])
        let career2 = Int(career1)
        cache.setValue(career2, forKey: "career")
        
        let HPup = data.value(forKey: "HPup") as! [String]
        let HPup1 = aesDecrypt(HPup[0])
        let HPup2 = Double(HPup1)
        cache.setValue(HPup2, forKey: "HPup")
        
        let MPup = data.value(forKey: "MPup") as! [String]
        let MPup1 = aesDecrypt(MPup[0])
        let MPup2 = Double(MPup1)
        cache.setValue(MPup2, forKey: "MPup")
        
        let ATKup = data.value(forKey: "ATKup") as! [String]
        let ATKup1 = aesDecrypt(ATKup[0])
        let ATKup2 = Double(ATKup1)
        cache.setValue(ATKup2, forKey: "ATKup")
        
        let DEFup = data.value(forKey: "DEFup") as! [String]
        let DEFup1 = aesDecrypt(DEFup[0])
        let DEFup2 = Double(DEFup1)
        cache.setValue(DEFup2, forKey: "DEFup")
        
        let dic = cache as NSDictionary
        return dic
    }
    
    //ID本地化方法
    func idLocation(_ id:String) -> String{
       let languages = Locale.preferredLanguages()
        let currentLanguage = languages[0]
        var ID = id
        switch currentLanguage{
        case "zh-Hans":
            ID = id + "CN"
            break
        case "zh-Hant":
            ID = id + "TW"
            break
        case "en-US":
            ID = id + "CN"
            break
        default:
            ID = id + "EN"
            break
        }
        
        return ID
    }
    
    //技能配置输出NSDictionary供组件使用
    func spellConfig(_ key:String,dataModel:RealmSwift.Object.Type) -> NSDictionary{
        let data = realm.objects(dataModel).filter("id == %@",key)
        let cache = NSMutableDictionary(dictionary: ["id":key])
        
        let name = data.value(forKey: "name") as! [String]
        let name1 = aesDecrypt(name[0])
        cache.setValue(name1, forKey: "name")
        
        let skillDescription = data.value(forKey: "skillDescription") as! [String]
        let skillDescription1 = aesDecrypt(skillDescription[0])
        cache.setValue(skillDescription1, forKey: "skillDescription")
        
        let team = data.value(forKey: "team") as! [String]
        let team1 = aesDecrypt(team[0])
        cache.setValue(team1, forKey: "team")
        
        let coolDown = data.value(forKey: "coolDown") as! [String]
        let coolDown1 = aesDecrypt(coolDown[0])
        let coolDown2 = TimeInterval(coolDown1)
        cache.setValue(coolDown2, forKey: "coolDown")
        
        let manaCost = data.value(forKey: "manaCost") as! [String]
        let manaCost1 = aesDecrypt(manaCost[0])
        let manaCost2 = Double(manaCost1)
        cache.setValue(manaCost2, forKey: "manaCost")
        
        let hitDamage = data.value(forKey: "hitDamage") as! [String]
        let hitDamage1 = aesDecrypt(hitDamage[0])
        let hitDamage2 = Double(hitDamage1)
        cache.setValue(hitDamage2, forKey: "hitDamage")
        
        let hitDamageUp = data.value(forKey: "hitDamageUp") as! [String]
        let hitDamageUp1 = aesDecrypt(hitDamageUp[0])
        let hitDamageUp2 = Double(hitDamageUp1)
        cache.setValue(hitDamageUp2, forKey: "hitDamageUp")
        
        let spDamage = data.value(forKey: "spDamage") as! [String]
        let spDamage1 = aesDecrypt(spDamage[0])
        let spDamage2 = Double(spDamage1)
        cache.setValue(spDamage2, forKey: "spDamage")
        
        let spDamageUp = data.value(forKey: "spDamageUp") as! [String]
        let spDamageUp1 = aesDecrypt(spDamageUp[0])
        let spDamageUp2 = Double(spDamageUp1)
        cache.setValue(spDamageUp2, forKey: "spDamageUp")
        
        let sumTime = data.value(forKey: "sumTime") as! [String]
        let sumTime1 = aesDecrypt(sumTime[0])
        let sumTime2 = TimeInterval(sumTime1)
        cache.setValue(sumTime2, forKey: "coolDown")
        
        let timePerEffect = data.value(forKey: "timePerEffect") as! [String]
        let timePerEffect1 = aesDecrypt(timePerEffect[0])
        let timePerEffect2 = TimeInterval(timePerEffect1)
        cache.setValue(timePerEffect2, forKey: "timePerEffect")
        
        let sumPerEffect = data.value(forKey: "sumPerEffect") as! [String]
        let sumPerEffect1 = aesDecrypt(sumPerEffect[0])
        let sumPerEffect2 = TimeInterval(sumPerEffect1)
        cache.setValue(sumPerEffect2, forKey: "sumPerEffect")
        
        let spDamagePerEffect = data.value(forKey: "spDamagePerEffect") as! [String]
        let spDamagePerEffect1 = aesDecrypt(spDamagePerEffect[0])
        let spDamagePerEffect2 = Double(spDamagePerEffect1)
        cache.setValue(spDamagePerEffect2, forKey: "spDamagePerEffect")
        
        let hitDamagePerEffect = data.value(forKey: "hitDamagePerEffect") as! [String]
        let hitDamagePerEffect1 = aesDecrypt(hitDamagePerEffect[0])
        let hitDamagePerEffect2 = Double(hitDamagePerEffect1)
        cache.setValue(hitDamagePerEffect2, forKey: "hitDamagePerEffect")
        
        let skillRange = data.value(forKey: "skillRange") as! [String]
        let skillRange1 = aesDecrypt(skillRange[0])
        let skillRange2 = Double(skillRange1)
        cache.setValue(skillRange2, forKey: "skillRange")
        
        let aoeRange = data.value(forKey: "aoeRange") as! [String]
        let aoeRange1 = aesDecrypt(aoeRange[0])
        let aoeRange2 = Double(aoeRange1)
        cache.setValue(aoeRange2, forKey: "aoeRange")
        
        let move = data.value(forKey: "move") as! [String]
        let move1 = aesDecrypt(move[0])
        let move2 = Double(move1)
        cache.setValue(move2, forKey: "move")
        
        let direction = data.value(forKey: "direction") as! [String]
        let direction1 = aesDecrypt(direction[0])
        cache.setValue(direction1, forKey: "direction")
        
        let maxHP = data.value(forKey: "maxHP") as! [String]
        let maxHP1 = aesDecrypt(maxHP[0])
        let maxHP2 = Double(maxHP1)
        cache.setValue(maxHP2, forKey: "maxHP")
        
        let maxMP = data.value(forKey: "maxMP") as! [String]
        let maxMP1 = aesDecrypt(maxMP[0])
        let maxMP2 = Double(maxMP1)
        cache.setValue(maxMP2, forKey: "maxHP")
        
        let ATK = data.value(forKey: "ATK") as! [String]
        let ATK1 = aesDecrypt(ATK[0])
        let ATK2 = Double(ATK1)
        cache.setValue(ATK2, forKey: "ATK")
        
        let DEF = data.value(forKey: "DEF") as! [String]
        let DEF1 = aesDecrypt(DEF[0])
        let DEF2 = Double(DEF1)
        cache.setValue(DEF2, forKey: "DEF")
        
        let MR = data.value(forKey: "MR") as! [String]
        let MR1 = aesDecrypt(MR[0])
        let MR2 = Double(MR1)
        cache.setValue(MR2, forKey: "MR")
        
        let SP = data.value(forKey: "SP") as! [String]
        let SP1 = aesDecrypt(SP[0])
        let SP2 = Double(SP1)
        cache.setValue(SP2, forKey: "SP")
        
        let speed = data.value(forKey: "speed") as! [String]
        let speed1 = aesDecrypt(speed[0])
        let speed2 = Double(speed1)
        cache.setValue(speed2, forKey: "speed")
        
        let range = data.value(forKey: "range") as! [String]
        let range1 = aesDecrypt(range[0])
        let range2 = Double(range1)
        cache.setValue(range2, forKey: "range")
        
        let critical = data.value(forKey: "critical") as! [String]
        let critical1 = aesDecrypt(critical[0])
        let critical2 = Double(critical1)
        cache.setValue(critical2, forKey: "critical")
        
        let spellCritical = data.value(forKey: "spellCritical") as! [String]
        let spellCritical1 = aesDecrypt(spellCritical[0])
        let spellCritical2 = Double(spellCritical1)
        cache.setValue(spellCritical2, forKey: "spellCritical")
        
        let hitPenetration = data.value(forKey: "hitPenetration") as! [String]
        let hitPenetration1 = aesDecrypt(hitPenetration[0])
        let hitPenetration2 = Double(hitPenetration1)
        cache.setValue(hitPenetration2, forKey: "hitPenetration")
        
        let spellPenetration = data.value(forKey: "spellPenetration") as! [String]
        let spellPenetration1 = aesDecrypt(spellPenetration[0])
        let spellPenetration2 = Double(spellPenetration1)
        cache.setValue(spellPenetration2, forKey: "spellPenetration")
        
        let hitRating = data.value(forKey: "hitRating") as! [String]
        let hitRating1 = aesDecrypt(hitRating[0])
        let hitRating2 = Double(hitRating1)
        cache.setValue(hitRating2, forKey: "hitRating")
        
        let spellHitRating = data.value(forKey: "spellHitRating") as! [String]
        let spellHitRating1 = aesDecrypt(spellHitRating[0])
        let spellHitRating2 = Double(spellHitRating1)
        cache.setValue(spellHitRating2, forKey: "spellHitRating")
        
        let criticalDamage = data.value(forKey: "criticalDamage") as! [String]
        let criticalDamage1 = aesDecrypt(criticalDamage[0])
        let criticalDamage2 = Double(criticalDamage1)
        cache.setValue(criticalDamage2, forKey: "criticalDamage")
        
        let spellCriticalDamage = data.value(forKey: "spellCriticalDamage") as! [String]
        let spellCriticalDamage1 = aesDecrypt(spellCriticalDamage[0])
        let spellCriticalDamage2 = Double(spellCriticalDamage1)
        cache.setValue(spellCriticalDamage2, forKey: "spellCriticalDamage")
        
        let dodge = data.value(forKey: "dodge") as! [String]
        let dodge1 = aesDecrypt(dodge[0])
        let dodge2 = Double(dodge1)
        cache.setValue(dodge2, forKey: "dodge")
        
        let strikeSpeed = data.value(forKey: "strikeSpeed") as! [String]
        let strikeSpeed1 = aesDecrypt(strikeSpeed[0])
        let strikeSpeed2 = Double(strikeSpeed1)
        cache.setValue(strikeSpeed2, forKey: "strikeSpeed")
        
        let shield = data.value(forKey: "shield") as! [String]
        let shield1 = aesDecrypt(shield[0])
        let shield2 = Double(shield1)
        cache.setValue(shield2, forKey: "shield")
        
        let control = data.value(forKey: "control") as! [String]
        let control1 = aesDecrypt(control[0])
        cache.setValue(control1, forKey: "control")
        
        let controlTime = data.value(forKey: "controlTime") as! [String]
        let controlTime1 = aesDecrypt(controlTime[0])
        let controlTime2 = TimeInterval(controlTime1)
        cache.setValue(controlTime2, forKey: "coolDown")
        
        let dic = cache as NSDictionary
        return dic
    }
    
}
