//
//  SignUpVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 16/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit

class SignUpVctr: UIViewController {
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnFB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up";
        // Do any additional setup after loading the view.
        self.btnSignUp.layer.cornerRadius = self.btnSignUp.frame.size.height / 2;
        self.btnGoogle.layer.cornerRadius = self.btnGoogle.frame.size.height / 2;
        self.btnFB.layer.cornerRadius = self.btnFB.frame.size.height / 2;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func popToLoginView(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    @IBAction func submitAction(sender: UIButton) {
        //        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LandingScreenVctrID") as? LandingScreenVctr {
        //            navigationController?.pushViewController(viewController, animated: true)
        //
        //        }
        UserDefaults.standard.register(defaults: ["isLoggedIn" : true])
        self.dismiss(animated: true, completion: nil);
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
