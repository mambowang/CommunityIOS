//
//  ForumsListVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 19/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit

class ForumsListVctr: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    let KTAGFORPROFILEIMAGE:NSInteger =     10001
    let KTAGFORPROFILENAME:NSInteger  =     10002
    let KTAGFOREARLIERAGO:NSInteger   =     10003
    let KTAGFORFORUMTITLE:NSInteger   =     10004
    let KTAGFORFORUMIMAGE:NSInteger   =     10005
    let KTAGFORSTATUSTEXT:NSInteger   =     10006
    let KTAGFORGAINPOINTS:NSInteger   =     10007
    let KTAGFORTOTALPOINTS:NSInteger  =     10008
    let KTAGFORSUBTITLE:NSInteger    =      10009
    let KTAGFORTAGS:NSInteger        =      10010
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath)
        
        let objpost: POST = self.posts[indexPath.row]
        
        let imgForProfile : UIImageView = cell.viewWithTag(KTAGFORPROFILEIMAGE) as! UIImageView!
        imgForProfile.image = UIImage(named:objpost.profileImageName)
        
        let lblForProfileName : UILabel = cell.viewWithTag(KTAGFORPROFILENAME) as! UILabel!
        lblForProfileName.text = objpost.name
        
        let lblForEarlierAgo : UILabel = cell.viewWithTag(KTAGFOREARLIERAGO) as! UILabel!
        lblForEarlierAgo.text = objpost.posttimeline
        
        let lblForForumTitle : UILabel = cell.viewWithTag(KTAGFORFORUMTITLE) as! UILabel!
        lblForForumTitle.text = objpost.title
        
        let lblForForumSubTitle : UILabel = cell.viewWithTag(KTAGFORSUBTITLE) as! UILabel!
        lblForForumSubTitle.text = objpost.title
        
        let imgForForumImage : UIImageView = cell.viewWithTag(KTAGFORFORUMIMAGE) as! UIImageView!
        imgForForumImage.image = UIImage(named:objpost.statusImageName)
        
        let lblForStatusText : UILabel = cell.viewWithTag(KTAGFORSTATUSTEXT) as! UILabel
        lblForStatusText.text = objpost.statusText
        
        let lblForGainPoint : UILabel = cell.viewWithTag(KTAGFORGAINPOINTS) as! UILabel
        lblForGainPoint.text = objpost.gainpoints
        
        let lblForTotalPoint : UILabel = cell.viewWithTag(KTAGFORTOTALPOINTS) as! UILabel
        lblForTotalPoint.text = objpost.totalpoints
        
        let lblForSocialTags : UILabel = cell.viewWithTag(KTAGFORTAGS) as! UILabel
        lblForSocialTags.text = objpost.tags
        
                
        return cell
    }
    
    @IBOutlet var feedCollectionView: UICollectionView!
    var posts: [POST] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellWidth : CGFloat = self.view.frame.size.width
        
        let cellheight : CGFloat = 450
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        feedCollectionView.setCollectionViewLayout(layout, animated: true)
        
        if let path = Bundle.main.path(forResource: "all_posts", ofType: "json") {
            do {
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any]
                if let postsArray = jsonDictionary?["posts"] as? [[String: AnyObject]] {
                    self.posts = [POST]()
                    for dictionary in postsArray {
                        let user = POST()
                        user.setValuesForKeys(dictionary)
                        self.posts.append(user)
                    }
                }
            } catch let err {
                print(err)
            }
        }
        feedCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let objpost: POST = self.posts[indexPath.row]
        
        let labelNameFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        let labelNameHeight: CGFloat = self.getHeightForLable(labelWidth: self.view.frame.size.width,numberOfLines:0, labelText: objpost.statusText, labelFont: labelNameFont)
        
        let labelTagsHeight: CGFloat = self.getHeightForLable(labelWidth: self.view.frame.size.width,numberOfLines:0, labelText: objpost.tags, labelFont: labelNameFont)
        
         let cellHeight: CGFloat = labelNameHeight + labelTagsHeight + 328
    
        return CGSize(width: self.view.frame.width, height: cellHeight)
    }
    
    func getHeightForLable(labelWidth: CGFloat, numberOfLines: Int = 1, labelText: String, labelFont: UIFont) -> CGFloat {
        let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        tempLabel.numberOfLines = numberOfLines
        tempLabel.text = labelText
        tempLabel.font = labelFont
        tempLabel.sizeToFit()
        return tempLabel.frame.height
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

class POST: NSObject {
    @objc var name: String!
    @objc var email: String!
    @objc var statusText :String!
    @objc var profileImageName:String!
    @objc var title:String!
    @objc var statusImageName: String!
    @objc var tags: String!
    @objc var posttimeline: String!
    @objc var gainpoints: String!
    @objc var totalpoints: String!
    @objc var location:locations?
    @objc var ImageMedia:[String]!
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = locations()
            location?.setValuesForKeys(value as! [String:AnyObject])
        }
        else{
            super.setValue(value, forKey: key)
        }
    }
}
class locations:NSObject{
    @objc var city: String!
    @objc var state: String!
}
