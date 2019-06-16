//
//  RoutesVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 19/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//
import GoogleMaps
import UIKit

/// Point of Interest Item which implements the GMUClusterItem protocol.
class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}

let kClusterItemCount = 50
let kCameraLatitude = -33.8
let kCameraLongitude = 151.2

class RoutesVctr: UIViewController, GMUClusterManagerDelegate, GMSMapViewDelegate {

    @IBOutlet var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    
//    override func loadView() {
//        let camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude,
//                                              longitude: kCameraLongitude, zoom: 8)
//        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        self.view = mapView
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
//        // Set up the cluster manager with default icon generator and renderer.
//        let iconGenerator = GMUDefaultClusterIconGenerator()
//        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
//        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
//        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
//
//        // Generate and add random items to the cluster manager.
//        generateClusterItems()
//
//        // Call cluster() after items have been added to perform the clustering and rendering on map.
//        clusterManager.cluster()
//
//        // Register self to listen to both GMUClusterManagerDelegate and GMSMapViewDelegate events.
//        clusterManager.setDelegate(self, mapDelegate: self)
//
        

        
        let sourceLoc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(23.0697691, 72.522774)
        let destinationLoc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(22.957917,72.498753)
        let sourceLoc1:CLLocationCoordinate2D = CLLocationCoordinate2DMake(21.188398, 72.894177)
        let destinationLoc1:CLLocationCoordinate2D = CLLocationCoordinate2DMake(19.196930,73.018859)
        
        
//        getPolylineRoute(from: sourceLoc, to: destinationLoc)

        genratePin(pinTitle: "1", position: sourceLoc)
        genratePin(pinTitle: "2", position: destinationLoc)
        genratePin(pinTitle: "3", position: sourceLoc1)
        genratePin(pinTitle: "4", position: destinationLoc1)
        
        let camera = GMSCameraPosition.camera(withLatitude: sourceLoc.latitude,
                                              longitude: sourceLoc.longitude, zoom: 10)
        
        
        self.mapView.camera = camera
        showPath(polyStr: "")
        

        
    }
    
    func drawText(text:NSString, inImage:UIImage) -> UIImage? {
        
        let font = UIFont.systemFont(ofSize: 14)
        let size = inImage.size
        
        UIGraphicsBeginImageContext(size)
        
        inImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = .center
        let attributes:NSDictionary = [ NSAttributedStringKey.font : font, NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.foregroundColor : UIColor.white ]
        
    

        let textSize = text.size(withAttributes: attributes as? [NSAttributedStringKey : Any])
        let rect = CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height)
        let textRect = CGRect(x: (rect.size.width - textSize.width)/2, y: (rect.size.height - textSize.height)/2 - 2, width: textSize.width, height: textSize.height)
        text.draw(in: textRect.integral, withAttributes: attributes as? [NSAttributedStringKey : Any])
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    func genratePin(pinTitle: String,position: CLLocationCoordinate2D)  {
        let center = CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude)
        let markerPin = GMSMarker(position: position)
//        markerPin.opacity = 0.8
        markerPin.position = center
//        markerPin.title = pinTitle
        markerPin.snippet = ""
        markerPin.icon = drawText(text: pinTitle as NSString, inImage: UIImage(named:"icon-marker")!)
        markerPin.map = self.mapView
    }
    
    // Pass your source and destination coordinates in this method.
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        
                        let routes = json["routes"] as? [Any]
                        let overview_polyline = routes?[0] as? NSDictionary
                        let polyString = overview_polyline?["overview_polyline"] as? NSDictionary
                        let polyStringValue = polyString?["points"] as? String
                        //Call this method to draw path on map
                        
                        self.showPath(polyStr: polyStringValue!)
                    }
                    
                }catch{
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    func showPath(polyStr :String){
    DispatchQueue.main.async(execute: {
//        let path = GMSPath(fromEncodedPath: polyStr)
//        let polyline = GMSPolyline(path: path)
//        polyline.strokeWidth = 3.0
//        polyline.strokeColor = UIColor.red
//        polyline.map = self.mapView // Your map view
        
        
        let path = GMSMutablePath()
        path.addLatitude(23.0697691, longitude:72.522774) // Sydney
        path.addLatitude(22.957917, longitude:72.498753) // Fiji
        path.addLatitude(21.188398, longitude: 72.894177) // Hawaii
        path.addLatitude(19.196930, longitude:73.018859) // Mountain View
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .blue
        polyline.strokeWidth = 5.0
        polyline.map = self.mapView
        
        })
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
        if let poiItem = marker.userData as? POIItem {
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
        for index in 1...kClusterItemCount {
            let lat = kCameraLatitude + extent * randomScale()
            let lng = kCameraLongitude + extent * randomScale()
            let name = "Item \(index)"
            let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name)
            clusterManager.add(item)
        }
    }
    
    /// Returns a random value between -1.0 and 1.0.
    private func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
}

