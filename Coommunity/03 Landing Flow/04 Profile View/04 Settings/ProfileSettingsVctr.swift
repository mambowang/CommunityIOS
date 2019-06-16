//
//  ProfileSettingsVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 23/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit

class ProfileSettingsVctr: UIViewController {

    var arForData: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dicForAccountData: Dictionary = [String: String]()
        dicForAccountData["Name"] = "Lillie Swanson"
        dicForAccountData["Email"] = "lillieswan@yahoo.com"
        dicForAccountData["Email"] = "lillieswan@yahoo.com"
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Settings"
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let btnForProfile = UIButton(type: .custom)
        btnForProfile.setImage(UIImage(named: "ic_back_profile"), for: .normal)
        btnForProfile.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnForProfile.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        let backBtn = UIBarButtonItem(customView: btnForProfile)
        self.navigationItem.setLeftBarButtonItems([backBtn], animated: true)
        
        let saveSettings = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveSettingsAction))
        saveSettings.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [saveSettings]
    }
    
    @objc func saveSettingsAction(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "profileNavCntrlID") as? UINavigationController {
            self.navigationController?.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    @objc func backBtnAction(){
        self.navigationController?.popViewController(animated: true)
        
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
