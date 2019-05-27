//
//  ViewController.swift
//  MTestApp
//
//  Created by John Raja on 25/05/19.
//  Copyright © 2019 John Raja. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ListArray = [SampleStructData02]()
    var tbListArray = [SampleStructData02SubData]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //GetFriendsList()
        
        self.myTableView.register(UINib(nibName : "MyTableViewCell", bundle : nil), forCellReuseIdentifier: "MyTableViewCell")
        
        CheckUserStatus()
    }

    func GetFriendsList() {
        
        ViewDataModel.sharedInstance.getList(completionHandler: { (message, response) in
            
            if message != nil {
                print(message!)
            }
            else {
                print(response!)
                
                //self.ListArray = response!
                
                DispatchQueue.main.async {
                    //self.myTableView.reloadData()
                }
            }
        })
    }
    
    func CheckUserStatus() {
        
        //["Email": "suresh@rgmobiles.com", "Access_Token": "fcuz4idsqj6jjp0u4gx8s75rfrjjr9d7v48as4qronayhic56wiqjwqihdun94arg9ypqzb90ftf6hj7oom51xx9n03pkcsumtsi", "LanguageID": "4"]
        //["Access_Token": "fcuz4idsqj6jjp0u4gx8s75rfrjjr9d7v48as4qronayhic56wiqjwqihdun94arg9ypqzb90ftf6hj7oom51xx9n03pkcsumtsi", "Country": "IN", "Email": "suresh@rgmobiles.com", "LanguageID": "4"]
        
        let request = GetUserStatusRequest(email:"suresh@rgmobiles.com", accessToken: "fcuz4idsqj6jjp0u4gx8s75rfrjjr9d7v48as4qronayhic56wiqjwqihdun94arg9ypqzb90ftf6hj7oom51xx9n03pkcsumtsi")
        
        ViewDataModel.sharedInstance.CheckUserStatus(request, completionHandler: { (message, response) in
            
            if message != nil {
                print(message!)
            }
            else {
                print(response!)
                
                self.ListArray = [response!]
                print(self.ListArray.count)
                print(self.ListArray[0].Data)
                
                self.tbListArray = [self.ListArray[0].Data]
                
                print(self.tbListArray.count)
                
                //print(responseList.IsPaidPremiumUser)
                //print(responseList.NotSubscriberNtucMessage)
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
        })
        
    }
}

// MARK: - UITableViewDelegate
extension ViewController  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.tbListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            return 75.0
        } else {
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.tbListArray[section].AvailablePlans.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        /*
        let sectionName: String
        switch section {
        case 0:
            sectionName = NSLocalizedString("mySectionName", comment: "mySectionName")
        case 1:
            sectionName = NSLocalizedString("myOtherSectionName", comment: "myOtherSectionName")
        // ...
        default:
            sectionName = ""
        }
         */
        return "Available Plans"
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
        
        cell.titleLabel?.text = ("\(self.tbListArray[indexPath.section].AvailablePlans[indexPath.row].TitleKey)")
        
        
        cell.imageView!.image = nil; // [UIImage imageNamed:@"default.png"];
        
        
 
        //if products.productImage.isEmpty{
            cell.imgView.image = UIImage(named:"AppIcon.png")
        //}else{
            cell.imgView.kf.setImage(with: URL(string: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg"), completionHandler: {
                (image, error, cacheType, imageUrl) in
                if error != nil{
                    cell.imgView.image = UIImage(named:"AppIcon.png")
                }
            })
        
        
        //}
        
        return cell
    }
    
}
