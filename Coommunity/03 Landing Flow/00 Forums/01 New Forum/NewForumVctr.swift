//
//  newForumVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 26/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit
import TagListView

class NewForumVctr: UIViewController,TagListViewDelegate {

    @IBOutlet var viewForAddImage : UIView!
    @IBOutlet var tagView : TagListView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tagView.textFont = UIFont.systemFont(ofSize: 16)
        self.tagView.addTags(["Design", "Agora", "Architecture","Art","Fashion","Finance","Kitchen","Literature"])
        
        self.tagView.addTag("Nature").isSelected = true
       self.tagView.addTags(["Health","Music","Cinema","Theater","Travel","Welcome","Sports","Science and Technology"])
        
//        tagListView.setTitle("Nature", at:8)
        
        
         let dottedBorderColor: UIColor = UIColor(hexString: "#00d3f1")!
        // Do any additional setup after loading the view.
        self.borderDashLine(withRadius: 8.0,borderWidth: 2,borderColor: dottedBorderColor,dashSize: 3,view: self.viewForAddImage)
    }
    
    public func borderDashLine(withRadius cornerRadius: Float, borderWidth: Float, borderColor: UIColor, dashSize: Int,view:UIView) {
        let currentFrame = view.bounds
        let shapeLayer = CAShapeLayer()
        let path = CGMutablePath()
        let radius = CGFloat(cornerRadius)
        
        // Points - Eight points that define the round border. Each border is defined by two points.
        let topLeftPoint = CGPoint(x: radius, y: 0)
        let topRightPoint = CGPoint(x: currentFrame.size.width - radius, y: 0)
//        let middleRightTopPoint = CGPoint(x: currentFrame.size.width, y: radius)
        let middleRightBottomPoint = CGPoint(x: currentFrame.size.width, y: currentFrame.size.height - radius)
//        let bottomRightPoint = CGPoint(x: currentFrame.size.width - radius, y: currentFrame.size.height)
        let bottomLeftPoint = CGPoint(x: radius, y: currentFrame.size.height)
//        let middleLeftBottomPoint = CGPoint(x: 0, y: currentFrame.size.height - radius)
        let middleLeftTopPoint = CGPoint(x: 0, y: radius)
        
        // Points - Four points that are the center of the corners borders.
        let cornerTopRightCenter = CGPoint(x: currentFrame.size.width - radius, y: radius)
        let cornerBottomRightCenter = CGPoint(x: currentFrame.size.width - radius, y: currentFrame.size.height - radius)
        let cornerBottomLeftCenter = CGPoint(x: radius, y: currentFrame.size.height - radius)
        let cornerTopLeftCenter = CGPoint(x: radius, y: radius)
        
        // Angles - The corner radius angles.
        let topRightStartAngle = CGFloat(Double.pi * 3 / 2)
        let topRightEndAngle = CGFloat(0)
        let bottomRightStartAngle = CGFloat(0)
        let bottmRightEndAngle = CGFloat(Double.pi / 2)
        let bottomLeftStartAngle = CGFloat(Double.pi / 2)
        let bottomLeftEndAngle = CGFloat(Double.pi)
        let topLeftStartAngle = CGFloat(Double.pi)
        let topLeftEndAngle = CGFloat(Double.pi * 3 / 2)
        
        // Drawing a border around a view.
        path.move(to: topLeftPoint)
        path.addLine(to: topRightPoint)
        path.addArc(center: cornerTopRightCenter,
                    radius: radius,
                    startAngle: topRightStartAngle,
                    endAngle: topRightEndAngle,
                    clockwise: false)
        path.addLine(to: middleRightBottomPoint)
        path.addArc(center: cornerBottomRightCenter,
                    radius: radius,
                    startAngle: bottomRightStartAngle,
                    endAngle: bottmRightEndAngle,
                    clockwise: false)
        path.addLine(to: bottomLeftPoint)
        path.addArc(center: cornerBottomLeftCenter,
                    radius: radius,
                    startAngle: bottomLeftStartAngle,
                    endAngle: bottomLeftEndAngle,
                    clockwise: false)
        path.addLine(to: middleLeftTopPoint)
        path.addArc(center: cornerTopLeftCenter,
                    radius: radius,
                    startAngle: topLeftStartAngle,
                    endAngle: topLeftEndAngle,
                    clockwise: false)
        
        // Path is set as the shapeLayer object's path.
        shapeLayer.path = path;
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.frame = currentFrame
        shapeLayer.masksToBounds = false
        shapeLayer.setValue(0, forKey: "isCircle")
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.lineWidth = CGFloat(borderWidth)
        shapeLayer.lineDashPattern = [NSNumber(value: dashSize), NSNumber(value: dashSize)]
        shapeLayer.lineCap = kCALineCapRound
        
        view.layer.addSublayer(shapeLayer)
        view.layer.cornerRadius = radius;
    }
    
    @IBAction func backBtnAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
