
//  AddNewFolderVC.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 24/4/21.


import UIKit

class AddNewFolderVC: UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtField.addBottomBorder()
        self.title = "Add New"
        print("temp")
        
    }
    
    // MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        if traitCollection.userInterfaceStyle == .light {
            print("Light mode")
        } else {
            print("Dark mode")
        }
        
       // self.setAddKeyboardObserver(controller: self)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if traitCollection.userInterfaceStyle == .light {
//            print("Light mode")
//        } else {
//            print("Dark mode")
//        }
//    }
    
    
    
    // MARK: - View Will Disappear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setRemoveKeyboardObserver()
        
        if isBeingDismissed {
           
            print("user is dismissing the vc")
         
            
        }
    }
    
   
    
    
    
    
    
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        let image:UIImage = UIImage(named: "photoalbum")!
        //let imageName:String = "Photo Album"
 
        if self.txtField.text != "" {
            
            if  let imageData = image.jpegData(compressionQuality: 0.9) {
                self.writeFolderToRealm(folderName: self.txtField.text!, folderData:imageData)
                
               
            }
            
            self.txtField.resignFirstResponder()
        }
       // self.txtField.resignFirstResponder()
        
        self.navigationController?.popViewController(animated: true)
    }
    
 
  
    
    
    
}


extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        
        if traitCollection.userInterfaceStyle == .light {
            
            bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height:1)
            bottomLine.backgroundColor = UIColor.black.cgColor
        } else {
            bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
            bottomLine.backgroundColor = UIColor.white.cgColor
            
        }
        borderStyle = .none
        
        layer.addSublayer(bottomLine)
    }
    

    
}
