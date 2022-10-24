//
//  userDataAddController.swift
//  EPS
//
//  Created by Abul Kashem on 22/10/22.
//

import UIKit

protocol GetData {
    func getData(uid: String, date: String, userName: String, ammount: String, btnMode: Bool,address: String)
}

protocol updateData {
    func userUpdateData(name: String, address: String)
}

class UserAddViewController: UIViewController{
    
    var delegate: GetData?
    var updateDelegate: updateData?
    
    @IBOutlet weak var navNameLable: UILabel!
    @IBOutlet weak var userNameTextView: UITextView!
    @IBOutlet weak var useramountTextView: UITextView!
    @IBOutlet weak var userAddressTextView: UITextView!
    @IBOutlet weak var saveOrUpdateButton: UIButton!
    
    var comeFromDidselect = false
    var urName: String?
    var address: String?

//    let userNamePlaceHolder = ""
//    let userAmountPlaceHolder = ""
//    let userAddressPlaceHolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        userNameTextView.delegate = self
//        userNameTextView.text = userNamePlaceHolder
//        userNameTextView.textColor = .lightGray
//        useramountTextView.delegate = self
//        useramountTextView.text = userAmountPlaceHolder
//        useramountTextView.textColor = .lightGray
//        userAddressTextView.delegate = self
//        userAddressTextView.text = userAddressPlaceHolder
//        userAddressTextView.textColor = .lightGray
//
        if comeFromDidselect {
            navNameLable.text = "Update Data"
            saveOrUpdateButton.setTitle("Update", for: .normal)
            useramountTextView.isHidden = true
            
            userNameTextView.text = urName ?? ""
            userAddressTextView.text = address ?? ""
        }
    }
    
    // MARK: touchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        
    func randomString(length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func currentData() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        formatter.dateFormat = "MMMM dd,YYYY"
        return formatter.string(from: currentDateTime)
    }
    
    @IBAction func BackButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SaveButtonAction(_ sender: UIButton) {
        guard let userName = userNameTextView.text else { return }
        guard let amount = useramountTextView.text else { return }
        guard let userAddress = userAddressTextView.text else{ return }
        
        //MARK: User ID RandomNumber
        
        let uid = randomString(length: 9)
        
        //MARK: Current DateTime
        
        let cdate = currentData()
        
        if comeFromDidselect {
            if let updateDelegate = updateDelegate {
                updateDelegate.userUpdateData(name: userNameTextView.text ?? "", address: userAddressTextView.text ?? "")
            }
            
        }else{
            if let delegate = delegate {
                delegate.getData(uid: uid, date: cdate, userName: userName, ammount: amount, btnMode: true, address: userAddress)
            }
        }
        self.dismiss(animated: true)
    }
}


//extension UserAddViewController : UITextViewDelegate{
//    func textViewDidBeginEditing(_ textView: UITextView){
//        if userNameTextView.textColor == .lightGray{
//            userNameTextView.text = ""
//            userNameTextView.textColor = .black
//        }
//        else if useramountTextView.textColor == .lightGray{
//            useramountTextView.text = ""
//            useramountTextView.textColor = .black
//        }
//        else{
//            userAddressTextView.text = ""
//            userAddressTextView.textColor = .black
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if userNameTextView.text == ""{
//            userNameTextView.text = userNamePlaceHolder
//            userNameTextView.textColor = .lightGray
//        }
//        else if useramountTextView.text == ""{
//            useramountTextView.text = userAmountPlaceHolder
//            useramountTextView.textColor = .lightGray
//        }else{
//            userAddressTextView.text = userAddressPlaceHolder
//            userAddressTextView.textColor = .lightGray
//        }
//    }
//}

