//
//  NewRouteVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 26/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit
import TagListView

class NewRouteVctr: UIViewController,TagListViewDelegate {
    
    @IBOutlet var tagView : TagListView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tagView.textFont = UIFont.systemFont(ofSize: 16)
        self.tagView.addTags(["Design", "Agora", "Architecture","Art","Fashion","Finance","Kitchen","Literature"])
        
        self.tagView.addTag("Nature").isSelected = true
        self.tagView.addTags(["Health","Music","Cinema","Theater","Travel","Welcome","Sports","Science and Technology"])
        
    }
    
    @IBAction func backBtnAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


