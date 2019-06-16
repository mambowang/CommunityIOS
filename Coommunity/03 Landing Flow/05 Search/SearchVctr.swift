//
//  SearchVctr.swift
//  Coommunity
//
//  Created by ZSOAHM-24 on 27/02/18.
//  Copyright © 2018 Magic tech. All rights reserved.
//

import UIKit
import TagListView

class SearchVctr: UIViewController,TagListViewDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tagView : TagListView!
    @IBOutlet var tblView : UITableView!
    @IBOutlet var dropBoxView : UIView!
    @IBOutlet var tableContainerView : UIView!
    var arForSearchData: [String] = []
    var newTag :TagView?
    
    let textCellIdentifier = "CCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arForSearchData = ["All","American football","American Badminton","Bandy","Body building"]
        
        self.tagView.textFont = UIFont.systemFont(ofSize: 18)
        
        self.tableContainerView.layer.borderColor = UIColor.lightGray.cgColor
        self.tableContainerView.layer.borderWidth = 1.0
        self.dropBoxView.layer.cornerRadius = self.dropBoxView.frame.size.height/2

        
        newTag = self.tagView.addTag("Agora")
        tagCustomization(tag: newTag!, colorHEX: "01ACEF")
        
        newTag = self.tagView.addTag("Welcome")
        tagCustomization(tag: newTag!, colorHEX: "D81059")
        
        newTag = self.tagView.addTag("  Art  ")
        tagCustomization(tag: newTag!, colorHEX: "EC008B")
        
        newTag = self.tagView.addTag("  Design  ")
        tagCustomization(tag: newTag!, colorHEX: "F8A62A")
        
        newTag = self.tagView.addTag("  Fashion  ")
        tagCustomization(tag: newTag!, colorHEX: "F57B71")
        
        newTag = self.tagView.addTag("  Finance  ")
        tagCustomization(tag: newTag!, colorHEX: "E1D505")
        
        newTag = self.tagView.addTag("  Kitechen  ")
        tagCustomization(tag: newTag!, colorHEX: "9B1560")
        
        newTag = self.tagView.addTag("  Literature  ")
        tagCustomization(tag: newTag!, colorHEX: "225974")
        
        newTag = self.tagView.addTag("  Music  ")
        tagCustomization(tag: newTag!, colorHEX: "D81059")
        
        newTag = self.tagView.addTag("  Nature  ")
        tagCustomization(tag: newTag!, colorHEX: "3FBB69")
        
        newTag = self.tagView.addTag("Health")
        tagCustomization(tag: newTag!, colorHEX: "EC1B24")
        
        newTag = self.tagView.addTag("  Cinema  ")
        tagCustomization(tag: newTag!, colorHEX: "EC1B24")
        
        newTag = self.tagView.addTag("  Theater  ")
        tagCustomization(tag: newTag!, colorHEX: "9B1560")
        
        newTag = self.tagView.addTag("Science and Technology")
        tagCustomization(tag: newTag!, colorHEX: "24255C")
        
        newTag = self.tagView.addTag("  Travels  ")
        tagCustomization(tag: newTag!, colorHEX: "3871C1")
        
        newTag = self.tagView.addTag("  Architecture  ")
        tagCustomization(tag: newTag!, colorHEX: "F04523")
        
        // Do any additional setup after loading the view.
        addSearchbar()
    }
    func tagCustomization(tag: TagView,colorHEX: String)  {
        let carbonKitColor: UIColor = UIColor(hexString: colorHEX)!
//        tag.selectedBackgroundColor = carbonKitColor
        tag.backgroundColor = carbonKitColor

    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        
        if sender.selectedTags().contains(tagView) {
            print("Yes It's contain")
        }else{
            switch tagView.titleLabel?.text{
            case "Agora"?:
                tagView.backgroundColor = UIColor.brown
//                tagCustomization(tag: tagView, colorHEX: "01ACEF")
                break
            case .none:
                print("Yes It's not contain")
            case .some(_):
                print("Yes It's not contain")
            }
        }
    }
    func addSearchbar(){

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: (self.view.frame.width-50), height: 44.0)
        let barContainer = UIView(frame: searchController.searchBar.frame)
        barContainer.backgroundColor = UIColor.clear
        barContainer.addSubview(searchController.searchBar)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barContainer)
        
    }
    
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }

//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.arForSearchData.count
//    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arForSearchData.count
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    
    
    let KTAGFORITEMNAME:NSInteger =     10001
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        let row = indexPath.row
        
        let lblForItem : UILabel = cell.viewWithTag(KTAGFORITEMNAME) as! UILabel!
        lblForItem.text = self.arForSearchData[row]
        
        return cell
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
