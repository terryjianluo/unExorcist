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
    func anyObject2Json(temp:AnyObject) -> NSString{
        let testJson = try? NSJSONSerialization.dataWithJSONObject(temp, options: NSJSONWritingOptions.PrettyPrinted)
        let encrypt = testJson?.base64EncodedDataWithOptions(NSDataBase64EncodingOptions())
        print(encrypt)
        let strs = NSString(data: encrypt!, encoding: NSUTF8StringEncoding)
        return strs!
    }
    
    //json转数组
    func json2Array(temp:String) -> [String]{
        let strs = NSString(string: temp).dataUsingEncoding(NSUTF8StringEncoding)
        let json = try? NSJSONSerialization.JSONObjectWithData(strs!, options:.AllowFragments) as!  NSDictionary
        let array = json!["array"]
        return array! as! [String]
    }
    
    //加密方法
    func aesEncrypt(text:String) -> String{
        let str = try! text.encrypt(AES(key: rabbitKey, iv: rabbitIV)).toBase64()
        return str!
    }
    
    //解密方法
    func aesDecrypt(text:String) -> String {
        let str = try! text.decryptBase64ToString(AES(key: rabbitKey, iv: rabbitIV))
        return str
    }
    
 
    //csv数据转存realm
    func csv2Realm(csvFile:String){
        let fileLocation = NSBundle.mainBundle().pathForResource(csvFile, ofType: "csv")!
        
        let error: NSErrorPointer = nil
        
        if let csv = CSV(contentsOfFile: fileLocation, error: error) {
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
    func realmSerch(key:String,property:String,dataModel:Object.Type) -> String{
        let data = realm.objects(dataModel).filter("id == %@",key)
        let results = data.valueForKey(property) as! [String]
        let result = aesDecrypt(results[0])
        return result
    }
    
    //查询结果输出数组
    func result2Array(result:String) -> [String]{
        let text = NSString(string: result)
        let textCache = text.stringByReplacingOccurrencesOfString(";", withString: "\",\"")
        let jsonText = "{\n\"array\":[\"\(textCache)\"]\n}"
        let json = json2Array(jsonText)
        return json
    }
    
    //英雄属性输出NSDictionary供组件使用
    func PropertyDictionary(key:String,dataModel:Object.Type) -> NSDictionary{
        let data = realm.objects(dataModel).filter("id == %@",key)
        let cache = NSMutableDictionary(dictionary: ["id":key])
        
        let name = data.valueForKey("name") as! [String]
        let name1 = aesDecrypt(name[0])
        cache.setValue(name1, forKey: "name")
        
        let level = data.valueForKey("level") as! [String]
        let level1 = aesDecrypt(level[0])
        let level2 = Int(level1)
        cache.setValue(level2, forKey: "level")
        
        let hp = data.valueForKey("HP") as! [String]
        let hp1 = aesDecrypt(hp[0])
        let hp2 = Double(hp1)
        cache.setValue(hp2, forKey: "HP")
        
        let MP = data.valueForKey("MP") as! [String]
        let MP1 = aesDecrypt(MP[0])
        let MP2 = Double(MP1)
        cache.setValue(MP2, forKey: "MP")
        
        let ATK = data.valueForKey("ATK") as! [String]
        let ATK1 = aesDecrypt(ATK[0])
        let ATK2 = Double(ATK1)
        cache.setValue(ATK2, forKey: "ATK")
        
        let DEF = data.valueForKey("DEF") as! [String]
        let DEF1 = aesDecrypt(DEF[0])
        let DEF2 = Double(DEF1)
        cache.setValue(DEF2, forKey: "DEF")
        
        let MR = data.valueForKey("MR") as! [String]
        let MR1 = aesDecrypt(MR[0])
        let MR2 = Double(MR1)
        cache.setValue(MR2, forKey: "MR")
        
        let SP = data.valueForKey("SP") as! [String]
        let SP1 = aesDecrypt(SP[0])
        let SP2 = Double(SP1)
        cache.setValue(SP2, forKey: "SP")
        
        let speed = data.valueForKey("speed") as! [String]
        let speed1 = aesDecrypt(speed[0])
        let speed2 = Double(speed1)
        cache.setValue(speed2, forKey: "speed")
        
        let range = data.valueForKey("range") as! [String]
        let range1 = aesDecrypt(range[0])
        let range2 = Double(range1)
        cache.setValue(range2, forKey: "range")
        
        let critical = data.valueForKey("critical") as! [String]
        let critical1 = aesDecrypt(critical[0])
        let critical2 = Double(critical1)
        cache.setValue(critical2, forKey: "critical")
        
        let spellCritical = data.valueForKey("spellCritical") as! [String]
        let spellCritical1 = aesDecrypt(spellCritical[0])
        let spellCritical2 = Double(spellCritical1)
        cache.setValue(spellCritical2, forKey: "spellCritical")
        
        let hitPenetration = data.valueForKey("hitPenetration") as! [String]
        let hitPenetration1 = aesDecrypt(hitPenetration[0])
        let hitPenetration2 = Double(hitPenetration1)
        cache.setValue(hitPenetration2, forKey: "hitPenetration")
        
        let spellPenetration = data.valueForKey("spellPenetration") as! [String]
        let spellPenetration1 = aesDecrypt(spellPenetration[0])
        let spellPenetration2 = Double(spellPenetration1)
        cache.setValue(spellPenetration2, forKey: "spellPenetration")
        
        let hitRating = data.valueForKey("hitRating") as! [String]
        let hitRating1 = aesDecrypt(hitRating[0])
        let hitRating2 = Double(hitRating1)
        cache.setValue(hitRating2, forKey: "hitRating")
        
        let spellHitRating = data.valueForKey("spellHitRating") as! [String]
        let spellHitRating1 = aesDecrypt(spellHitRating[0])
        let spellHitRating2 = Double(spellHitRating1)
        cache.setValue(spellHitRating2, forKey: "spellHitRating")
        
        let criticalDamage = data.valueForKey("criticalDamage") as! [String]
        let criticalDamage1 = aesDecrypt(criticalDamage[0])
        let criticalDamage2 = Double(criticalDamage1)
        cache.setValue(criticalDamage2, forKey: "criticalDamage")
        
        let spellCriticalDamage = data.valueForKey("spellCriticalDamage") as! [String]
        let spellCriticalDamage1 = aesDecrypt(spellCriticalDamage[0])
        let spellCriticalDamage2 = Double(spellCriticalDamage1)
        cache.setValue(spellCriticalDamage2, forKey: "spellCriticalDamage")
        
        let dodge = data.valueForKey("dodge") as! [String]
        let dodge1 = aesDecrypt(dodge[0])
        let dodge2 = Double(dodge1)
        cache.setValue(dodge2, forKey: "dodge")
        
        let strikeSpeed = data.valueForKey("strikeSpeed") as! [String]
        let strikeSpeed1 = aesDecrypt(strikeSpeed[0])
        let strikeSpeed2 = Double(strikeSpeed1)
        cache.setValue(strikeSpeed2, forKey: "strikeSpeed")
        
        let shield = data.valueForKey("shield") as! [String]
        let shield1 = aesDecrypt(shield[0])
        let shield2 = Double(shield1)
        cache.setValue(shield2, forKey: "shield")
        
        let powerRank = data.valueForKey("powerRank") as! [String]
        let powerRank1 = aesDecrypt(powerRank[0])
        let powerRank2 = Double(powerRank1)
        cache.setValue(powerRank2, forKey: "powerRank")
        
        let threaten = data.valueForKey("threaten") as! [String]
        let threaten1 = aesDecrypt(threaten[0])
        let threaten2 = Double(threaten1)
        cache.setValue(threaten2, forKey: "threaten")
        
        let assist = data.valueForKey("assist") as! [String]
        let assist1 = aesDecrypt(assist[0])
        let assist2 = Double(assist1)
        cache.setValue(assist2, forKey: "assist")
        
        let phyle = data.valueForKey("phyle") as! [String]
        let phyle1 = aesDecrypt(phyle[0])
        let phyle2 = Int(phyle1)
        cache.setValue(phyle2, forKey: "phyle")
        
        let career = data.valueForKey("career") as! [String]
        let career1 = aesDecrypt(career[0])
        let career2 = Int(career1)
        cache.setValue(career2, forKey: "career")
        
        let HPup = data.valueForKey("HPup") as! [String]
        let HPup1 = aesDecrypt(HPup[0])
        let HPup2 = Double(HPup1)
        cache.setValue(HPup2, forKey: "HPup")
        
        let MPup = data.valueForKey("MPup") as! [String]
        let MPup1 = aesDecrypt(MPup[0])
        let MPup2 = Double(MPup1)
        cache.setValue(MPup2, forKey: "MPup")
        
        let ATKup = data.valueForKey("ATKup") as! [String]
        let ATKup1 = aesDecrypt(ATKup[0])
        let ATKup2 = Double(ATKup1)
        cache.setValue(ATKup2, forKey: "ATKup")
        
        let DEFup = data.valueForKey("DEFup") as! [String]
        let DEFup1 = aesDecrypt(DEFup[0])
        let DEFup2 = Double(DEFup1)
        cache.setValue(DEFup2, forKey: "DEFup")
        
        let dic = cache as NSDictionary
        return dic
    }
    
    //ID本地化方法
    func idLocation(id:String) -> String{
       let languages = NSLocale.preferredLanguages()
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
    func spellConfig(key:String,dataModel:Object.Type) -> NSDictionary{
        let data = realm.objects(dataModel).filter("id == %@",key)
        let cache = NSMutableDictionary(dictionary: ["id":key])
        
        
        
        
        
        let dic = cache as NSDictionary
        return dic
    }
    
}
