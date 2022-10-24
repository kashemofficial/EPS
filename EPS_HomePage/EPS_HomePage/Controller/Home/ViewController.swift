//
//  ViewController.swift
//  EPS_HomePage
//
//  Created by Abul Kashem on 10/10/22.
//

import UIKit


class ViewController: UIViewController{
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var userData = [User]()
    var selectData : String = ""

    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = [
            User(userNames: "Tarik Anam", currentDates: "January 15,2022", userId: "022920202", userAmmount: "৳ 12000.00", userAddress: "Chandpur,Chittagong,Dhaka,Bangladesh"),
            User(userNames: "MD Abul Kashem", currentDates: "February 10,2022", userId: "022920202", userAmmount: "৳ 5020.00", userAddress: "Subidpur,Faridgong,Chandpur,Chittagong"),
            User(userNames: "Hosne Mobarak", currentDates: "March 20,2022", userId: "022920202", userAmmount: "৳ 1000.00", userAddress: "Chandpur,Chittagong,Dhaka,Bangladesh"),
            User(userNames: "Halal Uddin", currentDates: "April 12,2022", userId: "022920202", userAmmount: "৳ 12000.00", userAddress: "Chandpur,Chittagong,Dhaka"),
            User(userNames: "Tarif Khan", currentDates: "May 11,2022", userId: "022920202", userAmmount: "৳ 10000.00", userAddress: "Chandpur,Chittagong,Bangladesh"),
            User(userNames: "MD Murad", currentDates: "June 9,2022", userId: "022920202", userAmmount: "৳ 1500.00", userAddress: "Chandpur,Chittagong,Dhaka"),
            User(userNames: "Chinmoy Bissas", currentDates: "July 29,2022", userId: "022920202", userAmmount: "৳ 50000.00", userAddress: "Chandpur,Chittagong,Dhaka"),
            User(userNames: "Jallal Uddin", currentDates: "July 29,2022", userId: "022920202", userAmmount: "৳ 1200.00", userAddress: "Chandpur,Chittagong,Dhaka")
        ]
        
        setupUI()
        setupTableVeiw()
    }
    
    func setupUI() {
        addButton.layer.cornerRadius = addButton.frame.size.width / 2
    }
    
    func setupTableVeiw(){
        let nib = UINib(nibName: "sendInTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "sendInCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: addButtonAction
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "UserAddViewController") as! UserAddViewController
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var returnCell = UITableViewCell()
        returnCell.selectionStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "sendInCell", for: indexPath) as! sendInTableViewCell
        
        if indexPath.row % 2 == 0 {
            let user = userData[indexPath.row]
            cell.nameLabel?.text = user.userNames
            cell.dateLabel.text = user.currentDates
            cell.idLabel.text = user.userId
            cell.amountLabel.text = user.userAmmount
            cell.addressLabel.text = user.userAddress
            cell.mButton.setTitle("In", for: .normal)
            cell.mButton.backgroundColor = UIColor(red: 0.8902, green: 0.9765, blue: 0.8784, alpha: 1)
            cell.mButton.setTitleColor(UIColor(red: 0.0588, green: 0.6, blue: 0, alpha: 1), for: .normal)
            returnCell = cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendInCell", for: indexPath) as! sendInTableViewCell
            let user = userData[indexPath.row]
            cell.nameLabel?.text = user.userNames
            cell.dateLabel.text = user.currentDates
            cell.idLabel.text = user.userId
            cell.amountLabel.text = user.userAmmount
            cell.addressLabel.text = user.userAddress
            cell.mButton.setTitleColor(UIColor(red: 1, green: 0.1373, blue: 0.1529, alpha: 1), for: .normal)
            returnCell = cell
        }
        
        return returnCell
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Delete = userData[indexPath.row]
        
        //MARK: cell delete Action
    
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){(action, indexPath) in
            self.deleteAction(updateDelete: Delete, indexPath: indexPath)
        }
        deleteAction.backgroundColor = .red
        return[deleteAction]
    }
        
        //MARK: deleteAction success
    
         func deleteAction(updateDelete: User, indexPath: IndexPath){
            let alert = UIAlertController(title: "Delete", message: "are you sure your information deletion?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Yes", style: .default){(action)in
                self.userData.remove(at: indexPath.row)
                self.tableView?.deleteRows(at: [indexPath], with: .automatic)
            }
            let cancelAction = UIAlertAction(title: "No", style: .default,handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            present(alert,animated: true)
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "UserAddViewController") as! UserAddViewController
            vc.modalPresentationStyle = .fullScreen
            vc.updateDelegate = self
            vc.comeFromDidselect = true
            vc.urName = userData[indexPath.row].userNames
            vc.address = userData[indexPath.row].userAddress
            self.present(vc, animated: true)
    }
}


extension ViewController: GetData {
    func getData(uid: String, date: String, userName: String, ammount: String, btnMode: Bool,address: String) {
        userData.append(User(userNames: userName, currentDates: date, userId: uid, userAmmount: "৳ " + ammount, userAddress: address))
        tableView.reloadData()
    }
    
}

extension ViewController: updateData {
    func userUpdateData(name: String, address: String) {
        userData[selectedIndex ?? 0].userNames = name
        userData[selectedIndex ?? 0].userAddress = address
        
        let indexPath = IndexPath(item: selectedIndex ?? 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .top)
        selectedIndex = nil
    }
}
