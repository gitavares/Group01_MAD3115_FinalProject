//
//  MenuTableTableViewController.swift
//  FinalProject
//
//  Created by Gurjeet kaur on 2018-11-06.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit
import Firebase

class MenuTableTableViewController: UITableViewController {
    
    var ref: DatabaseReference = Database.database().reference()
    var alert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            // do something
        } else {
            backToLogin()
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section == 0 ? 4 : 3
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.indexPathForSelectedRow?.section == 0 {
            switch indexPath.row {
            case 0:
                home()
            case 1:
                print("Add Ticket")
            case 2:
                guard let uid = Auth.auth().currentUser?.uid else { return }
                ref.child("users/profile/\(uid)/tickets").observe(.value, with: { snapshot in
                    if snapshot.childrenCount > 0 {
                        self.report()
                    } else {
                        self.alert = UIAlertController(title: "No tickets", message: "You don't have any ticket to open the Report", preferredStyle: .alert)
                        self.alert!.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(self.alert!, animated: true)
                    }
                })
            case 3:
                location()
            default:
                print("none")
            }
        } else if tableView.indexPathForSelectedRow?.section == 1 {
            switch indexPath.row {
                case 0:
                    editProfile()
                case 1:
                    instructions()
                case 2:
                    contact()
                case 3:
                    try! Auth.auth().signOut()
                    backToLogin()
                default:
                    print("none")
            }
        }
    }
    
    func backToLogin() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "loginVC")
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func editProfile() {
        self.performSegue(withIdentifier: "editUserVC", sender: self)
    }
    
    func location() {
        self.performSegue(withIdentifier: "locationVC", sender: self)
    }
    
    func contact() {
        self.performSegue(withIdentifier: "contactVC", sender: self)
    }
    
    func instructions() {
        self.performSegue(withIdentifier: "instructionVC", sender: self)
    }
  
    func report() {
        self.performSegue(withIdentifier: "reportVC", sender: self)
    }
    
    func home() {
        self.performSegue(withIdentifier: "homeVC", sender: self)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
