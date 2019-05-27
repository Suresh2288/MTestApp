//
//  RootViewController.swift
//  MTestApp
//
//  Created by John Raja on 27/05/19.
//  Copyright © 2019 John Raja. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    var ListArray = [SampleStructData02]()
    var tbListArray = [SampleStructData02SubData]()
    
    @IBOutlet weak var MyTableViewCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //tableView.register(UINib(nibName : "MyTableViewCell", bundle : nil), forCellReuseIdentifier: "MyTableViewCell")
        
        CheckUserStatus()
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
                    self.tableView.reloadData()
                }
            }
        })
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.tbListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)

        cell.textLabel?.text = ("\(self.tbListArray[indexPath.row].AvailablePlans[indexPath.row].TitleKey)")
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
