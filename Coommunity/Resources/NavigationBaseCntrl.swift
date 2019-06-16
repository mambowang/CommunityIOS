//
//  NavigationBaseCntrl.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 16/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit

class NavigationBaseCntrl: UIViewController {
    
let btnForViewChange = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "ic_title_navigation")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // Do any additional setup after loading the view.
        
        
    }
    @objc func profileClickAction(){
        if Constant.GlobalConstants.APP_DELEGATE.checkUserIsLoggedIn(){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "profileNavCntrlID") as? UINavigationController {
                self.navigationController?.present(viewController, animated: true, completion: nil)
            }
        }else{
            Constant.GlobalConstants.APP_DELEGATE.logInToApplication()
        }
    }
    
    func itemsOnRightBar(isForum : Bool)  {
        let btnForProfile = UIButton(type: .custom)
        btnForProfile.setImage(UIImage(named: "ic_user_profile"), for: .normal)
        btnForProfile.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnForProfile.addTarget(self, action: #selector(profileClickAction), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnForProfile)
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
        
        
        if Constant.GlobalConstants.APP_DELEGATE.postDisplayType == FeedType.MapType {
            //change view for list
            btnForViewChange.setImage(UIImage(named: "ic_map_marker"), for: .normal)
        }else{
            //change view for Map
            btnForViewChange.setImage(UIImage(named: "ic_grid_view"), for: .normal)
        }
        
        
        btnForViewChange.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnForViewChange.addTarget(self, action: #selector(changePostViewType), for: .touchUpInside)
        let itemForViewChange = UIBarButtonItem(customView: btnForViewChange)
        
        let btnForSearch = UIButton(type: .custom)
        btnForSearch.setImage(UIImage(named: "ic_search"), for: .normal)
        btnForSearch.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnForSearch.addTarget(self, action: #selector(searchClickAction), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btnForSearch)
        
        if isForum == true {
            self.navigationItem.setRightBarButtonItems([item2], animated: true)
        }else{
            self.navigationItem.setRightBarButtonItems([item2,itemForViewChange], animated: true)
        }
    }
    
    @objc func changePostViewType(){
        if Constant.GlobalConstants.APP_DELEGATE.postDisplayType == FeedType.MapType {
            //change view for list
            btnForViewChange.setImage(UIImage(named: "ic_grid_view"), for: .normal)
            Constant.GlobalConstants.APP_DELEGATE.postDisplayType = FeedType.FullLength
        }else{
            //change view for Map
            btnForViewChange.setImage(UIImage(named: "ic_map_marker"), for: .normal)
            Constant.GlobalConstants.APP_DELEGATE.postDisplayType = FeedType.MapType
        }
        NotificationCenter.default.post(name: Notification.MyApp.Something,
                                        object: self,
                                        userInfo: [Notification.MyApp.Something:"foo"])
    }
    
    @objc func searchClickAction(){
        //SearchVctrID
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SearchVctrID") as? SearchVctr {
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
