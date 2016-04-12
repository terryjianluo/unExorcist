//
//  WorldViewController.swift
//  unExorcist
//
//  Created by Terry on 15/10/5.
//  Copyright © 2015年 Terry. All rights reserved.
//

import UIKit
import WebKit

class WorldViewController: UIViewController , UITextViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet var sceneTextView: UITextView!
    @IBOutlet var sceneTitle: UILabel!
    var container:NSTextContainer!
    var layout:NSLayoutManager!
    var sceneIdCache = "s0001"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 1, green: 0.99, blue: 0.93, alpha: 1)
        sceneTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        sceneTextView.text = ">"
        sceneTextView.delegate = self
        
        //NSTextContainer
        container = NSTextContainer(size: sceneTextView.contentSize)
        container.widthTracksTextView = true
        
        //NSlayoutManager
        layout = NSLayoutManager()
        layout.addTextContainer(container)
        
        //NATextStorage
        sceneTextView.textStorage.addLayoutManager(layout)
        sceneTextView.layoutManager.allowsNonContiguousLayout = false
        
        sceneTextView.scrollRangeToVisible(sceneTextView.selectedRange)
        
        // Do any additional setup after loading the view.
        let sceneInit = CoreDataManager().realmSerch("terry", property: "scene", dataModel: GameRecord.self)
        let sceneID = CoreDataManager().idLocation(sceneInit)
        let sceneText = CoreDataManager().realmSerch(sceneID, property: "intro", dataModel: MapData.self)
        sceneIdCache = sceneID
        sceneTitle.text = CoreDataManager().realmSerch(sceneID, property: "name", dataModel: MapData.self)
        
        textOutput(sceneText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        print(URL)
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textOutput(inputText:String){
        sceneTextView.text = sceneTextView.text.stringByAppendingString(inputText)
        
        /*
        //NSTextContainer
        container = NSTextContainer(size: sceneTextView.contentSize)
        container.widthTracksTextView = true
        
        //NSlayoutManager
        layout = NSLayoutManager()
        layout.addTextContainer(container)
        
        //NATextStorage
        sceneTextView.textStorage.addLayoutManager(layout)
        sceneTextView.layoutManager.allowsNonContiguousLayout = false
        */
        
        let pattern = "(\\[\\w+(\\s\\w+)*\\])"
        let express = try? NSRegularExpression(pattern: pattern, options: [])
        let paragraph = inputText as NSString
        let textViewLengthText = sceneTextView.text as NSString
        
        let paraRange = NSMakeRange((textViewLengthText.length - paragraph.length), paragraph.length)

        sceneTextView.textStorage.fixAttributesInRange(paraRange)
        
        let mutStr = sceneTextView.attributedText.mutableCopy() as! NSMutableAttributedString
        express!.enumerateMatchesInString(sceneTextView.text, options: [], range: paraRange, usingBlock: {
            match, flags ,stop in
            _ = match!.rangeAtIndex(1)
            
            mutStr.addAttribute(NSLinkAttributeName, value: NSURL(string: "quest.npc")!, range: match!.range)
            mutStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: match!.range)
            self.sceneTextView.attributedText = mutStr
        })
        sceneTextView.scrollRangeToVisible(sceneTextView.selectedRange)
    }
    
    func moveScene(id:String){
       let result = CoreDataManager().realmSerch(id, property: "passway", dataModel: MapData.self)
        let passwayArray = CoreDataManager().result2Array(result)
        var passWayText = "\n=>"
        
        for v in passwayArray{
            let passId = CoreDataManager().idLocation(v)
            let passName = CoreDataManager().realmSerch(passId, property: "name", dataModel: MapData.self)
            passWayText = passWayText + ",[\(passName)]"
        }
        
        textOutput(passWayText)
    }
    
    func changeScene(id:String){
        let sceneText = CoreDataManager().realmSerch(id, property: "intro", dataModel: MapData.self)
        sceneTitle.text = CoreDataManager().realmSerch(id, property: "name", dataModel: MapData.self)
    }

}
