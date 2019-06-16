//
//  MyPostVCtr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 22/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit

class MyPostVCtr: UIViewController {

    @IBOutlet var btnForFirstPost: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnForFirstPost?.layer.cornerRadius = (self.btnForFirstPost?.frame.size.height)! / 2
        self.btnForFirstPost?.layer.borderWidth = 1.0
        self.btnForFirstPost?.layer.borderColor = UIColor.darkGray.cgColor
        // Do any additional setup after loading the view.
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
