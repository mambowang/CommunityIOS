//
//  LoginVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 15/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit


class LoginVctr: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnFB: UIButton!
    @IBOutlet weak var logoVerticleSpaceConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btnLogin.layer.cornerRadius = self.btnLogin.frame.size.height / 2;
        self.btnGoogle.layer.cornerRadius = self.btnGoogle.frame.size.height / 2;
        self.btnFB.layer.cornerRadius = self.btnFB.frame.size.height / 2;
        
        self.title = "Login";
        if Constant.DeviceType.IS_IPHONE_X  && Constant.DeviceType.IS_IPHONE_7P && Constant.DeviceType.IS_IPHONE_6P{
            logoVerticleSpaceConstraint.constant = 120;
        }else if Constant.DeviceType.IS_IPHONE_7 && Constant.DeviceType.IS_IPHONE_6{
            logoVerticleSpaceConstraint.constant = 80;
        }else{
            logoVerticleSpaceConstraint.constant = 50;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginAction(sender: UIButton) {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LandingScreenVctrID") as? LandingScreenVctr {
//            navigationController?.pushViewController(viewController, animated: true)
//        
//        }
        UserDefaults.standard.register(defaults: ["isLoggedIn" : true])
        self.dismiss(animated: true, completion: nil);
    }
    @IBAction func backButtonActionMethod(){
        self.dismiss(animated: true, completion: nil)
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
