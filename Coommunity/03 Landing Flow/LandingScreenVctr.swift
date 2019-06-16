//
//  LandingScreenVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 16/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit
import SwiftHEXColors
import CarbonKit

class LandingScreenVctr: NavigationBaseCntrl,CarbonTabSwipeNavigationDelegate {

    @IBOutlet var floatView: UIView!
    var currentSliderIndex: NSInteger = 0
    func generateImage(for view: UIView) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.floatView.layer.cornerRadius = self.floatView.frame.size.height / 2
        self.itemsOnRightBar(isForum: true);
        
        let tabSwipe = CarbonTabSwipeNavigation(items: [ "Forums", "Spots", "Events","Routes"], delegate: self)
        
        tabSwipe.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        tabSwipe.insert(intoRootViewController: self)
        tabSwipe.toolbar.isTranslucent = true
        
        styleTabSwipe(tabSwipe: tabSwipe)
        self.view.bringSubview(toFront: floatView)
        currentSliderIndex = 0
    }
    
    @IBAction func floatViewAction(sender: UIButton) {
        switch currentSliderIndex  {
        case 0:
            if Constant.GlobalConstants.APP_DELEGATE.checkUserIsLoggedIn(){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "navNewForumVctrID") as? UINavigationController {
                    self.navigationController?.present(viewController, animated: true, completion: nil)
                }
            }else{
                Constant.GlobalConstants.APP_DELEGATE.logInToApplication()
            }
            break
        case 1:
            if Constant.GlobalConstants.APP_DELEGATE.checkUserIsLoggedIn(){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "navNewSpotVctrID") as? UINavigationController {
                    self.navigationController?.present(viewController, animated: true, completion: nil)
                }
            }else{
                Constant.GlobalConstants.APP_DELEGATE.logInToApplication()
            }
            break
        case 2:
            if Constant.GlobalConstants.APP_DELEGATE.checkUserIsLoggedIn(){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "navNewEventVctrID") as? UINavigationController {
                    self.navigationController?.present(viewController, animated: true, completion: nil)
                }
            }else{
                Constant.GlobalConstants.APP_DELEGATE.logInToApplication()
            }
            break
        case 3:
            if Constant.GlobalConstants.APP_DELEGATE.checkUserIsLoggedIn(){
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "navNewRouteVctrID") as? UINavigationController {
                    self.navigationController?.present(viewController, animated: true, completion: nil)
                }
            }else{
                Constant.GlobalConstants.APP_DELEGATE.logInToApplication()
            }
            break
        default:
            print("Nothing happend")
        }
    }
    func styleTabSwipe(tabSwipe:CarbonTabSwipeNavigation)  {
//        tabSwipe.setTabExtraWidth(35)
        
        if Constant.DeviceType.IS_IPHONE_5 {
            tabSwipe.setTabExtraWidth(25)
        }else if Constant.DeviceType.IS_IPHONE_7 {
            tabSwipe.setTabExtraWidth(35)
        }else{
            tabSwipe.setTabExtraWidth(40)
        }
        
        // With hash
        let carbonKitColor: UIColor = UIColor(hexString: "#664ad3")!
        tabSwipe.setIndicatorColor(carbonKitColor)
        tabSwipe.setIndicatorHeight(2)
        tabSwipe.setSelectedColor(carbonKitColor)
    
        tabSwipe.setNormalColor(UIColor(hexString: "#00d3f1")!)
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
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        guard let storyboard = storyboard else { return UIViewController() }
        if index == 0 {
            currentSliderIndex = 0
             itemsOnRightBar(isForum: true);
            return storyboard.instantiateViewController(withIdentifier: "ForumsListVctrID")
           
        }else if index == 1{
            currentSliderIndex = 1
            itemsOnRightBar(isForum: false);
            return storyboard.instantiateViewController(withIdentifier: "SpotsVctrID")
        }else if index == 2{
            currentSliderIndex = 2
            itemsOnRightBar(isForum: false);
            return storyboard.instantiateViewController(withIdentifier: "EventsVctrID")
        }else if index == 3{
            currentSliderIndex = 3
            itemsOnRightBar(isForum: false);
            return storyboard.instantiateViewController(withIdentifier: "RoutesVctrID")
            
        }
        return storyboard.instantiateViewController(withIdentifier: "SecondTableViewController")
    }

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt) {

        if index == 0 {
            itemsOnRightBar(isForum: true);
        }else if index == 1{
            itemsOnRightBar(isForum: false);
        }else if index == 2{
            itemsOnRightBar(isForum: false);
        }else if index == 3{
            itemsOnRightBar(isForum: false);
        }
    }
    
    
    

}
