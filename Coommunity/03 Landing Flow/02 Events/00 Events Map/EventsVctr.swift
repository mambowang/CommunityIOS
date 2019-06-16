//
//  EventsVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 19/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import GoogleMaps
import UIKit

/// Point of Interest Item which implements the GMUClusterItem protocol.
class EventPOIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}

let kEventClusterItemCount = 50
let kEventCameraLatitude = -33.8
let kEventCameraLongitude = 151.2

class EventsVctr: UIViewController, GMUClusterManagerDelegate, GMSMapViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    @IBOutlet var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    @IBOutlet var viewForCollection: UIView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshContentOfView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: kSpotCameraLatitude,
                                              longitude: kSpotCameraLongitude, zoom: 10)
        self.mapView.camera = camera
        
        // Set up the cluster manager with default icon generator and renderer.
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        
        // Generate and add random items to the cluster manager.
        generateClusterItems()
        
        // Call cluster() after items have been added to perform the clustering and rendering on map.
        clusterManager.cluster()
        
        // Register self to listen to both GMUClusterManagerDelegate and GMSMapViewDelegate events.
        clusterManager.setDelegate(self, mapDelegate: self)
        
        utilityForCollection()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.receiveNotificationMethod(notification:)),
                                               name: Notification.MyApp.Something,
                                               object: nil)
        
    }
    
    
    func utilityForCollection()  {
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
    }
    
    @objc func receiveNotificationMethod(notification:NSNotification) {
        //        print("notification received")
        //        let userInfo = notification.userInfo!
        //        let key = Notification.MyApp.Something
        //        let something = userInfo[key]! as! String //Yes, this works :)
        //        print(something)
        refreshContentOfView()
        
    }
    func refreshContentOfView()  {
        if Constant.GlobalConstants.APP_DELEGATE.postDisplayType == FeedType.MapType {
            //change view for list
            mapView.isHidden = false
            viewForCollection.isHidden = true
        }else{
            //change view for Map
            mapView.isHidden = true
            viewForCollection.isHidden = false
        }
    }
    
    // MARK: - GMUClusterManagerDelegate
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return false
    }
    
    // MARK: - GMUMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? EventPOIItem {
            NSLog("Did tap marker for cluster item \(poiItem.name)")
        } else {
            NSLog("Did tap a normal marker")
        }
        return false
    }
    
    // MARK: - Private
    
    /// Randomly generates cluster items within some extent of the camera and adds them to the
    /// cluster manager.
    private func generateClusterItems() {
        let extent = 0.2
        for index in 1...kEventClusterItemCount {
            let lat = kEventCameraLatitude + extent * randomScale()
            let lng = kEventCameraLongitude + extent * randomScale()
            let name = "Item \(index)"
            let item = EventPOIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name)
            clusterManager.add(item)
        }
    }
    
    /// Returns a random value between -1.0 and 1.0.
    private func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
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
}

