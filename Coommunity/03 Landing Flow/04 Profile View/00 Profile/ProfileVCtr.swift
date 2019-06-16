//
//  ProfileVCtr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 22/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit
import CarbonKit

class ProfileVCtr: UIViewController,CarbonTabSwipeNavigationDelegate {
   
    var carbonTabSwipeNavigation :CarbonTabSwipeNavigation!
    @IBOutlet var toolbar : UIToolbar?
    @IBOutlet var targetedView : UIView?
    @IBOutlet var avatarBoxView : UIView?
    @IBOutlet var btnEditProfile : UIView?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear
//        self.navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
        
        let items: [String] = ["Following","My Posts","My Maps"]
        self.carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items,toolBar:toolbar!, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: targetedView!)
        styleTabSwipe(tabSwipe: self.carbonTabSwipeNavigation)
        
        self.avatarBoxView?.layer.shadowOpacity = 0.7
        self.avatarBoxView?.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.avatarBoxView?.layer.shadowRadius = 15.0
        self.avatarBoxView?.layer.shadowColor = UIColor.gray.cgColor
        self.avatarBoxView?.layer.cornerRadius = 6.0
        self.btnEditProfile?.layer.cornerRadius = (self.btnEditProfile?.frame.size.height)! / 2
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        // return viewController at index
        guard let storyboard = storyboard else { return UIViewController() }
        if index == 0 {
            return storyboard.instantiateViewController(withIdentifier: "FollowingListVctrID")
        }else if index == 1{
            return storyboard.instantiateViewController(withIdentifier: "MyPostVCtrID")
        }else{
            return storyboard.instantiateViewController(withIdentifier: "MyMapsVctrID")
        }
    }

    
    func styleTabSwipe(tabSwipe:CarbonTabSwipeNavigation)  {
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.size.width / 3, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.size.width / 3, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(self.view.frame.size.width / 3, forSegmentAt: 2)

        // With hash
        let carbonKitColor: UIColor = UIColor(hexString: "#664ad3")!
        tabSwipe.setIndicatorColor(carbonKitColor)
        tabSwipe.setIndicatorHeight(2)
        tabSwipe.setSelectedColor(carbonKitColor)
        tabSwipe.setNormalColor(UIColor(hexString: "#000000")!)
    }
    
    @IBAction func backBtnAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func settingBtnAction(sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileSettingsVctrID") as? ProfileSettingsVctr {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
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
