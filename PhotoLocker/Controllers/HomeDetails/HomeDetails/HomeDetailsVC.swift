//  HomeDetailsVC.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 23/4/21.


import UIKit

class HomeDetailsVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, FMPhotoPickerViewControllerDelegate {
    
    var Index:Int = Int()
    var primaryKey:String = String()
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var bottomView: UIView!
    
    var customViewOne:UIView = UIView()
    var customViewTwo:UIView = UIView()
    var customViewThree:UIView = UIView()
    
    var fourgridCV: UICollectionView!
    var twogridCV:UICollectionView!
    var listTV:UITableView = UITableView()
    
    var gridButtonClicked:Int = Int()
    private var maxImage: Int = 5
    private var maxVideo: Int = 5


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("Index",Index)
        //print("primaryKey:",primaryKey)
        //readDBDetails()
        

        gridButtonClicked =  ConfigHomeDetails.fourCVTag
        self.setfourCollectionView()
        self.settwoCollectionView()
        self.setTableView()
    
    }
    
    
    
    @IBAction func changeButtonLayout(_ sender: UIButton) {
        sender.tag += 1
        
        if sender.tag > 3 { sender.tag = 0 }

        switch sender.tag {
        case 1:
            print("sender.tag:",sender.tag)
            customViewTwo.isHidden = true
            customViewThree.isHidden = true
            gridButtonClicked =  ConfigHomeDetails.fourCVTag
            self.setfourCollectionView()
            
            break
          
        
        case 2:
            print("sender.tag:",sender.tag)
            customViewOne.isHidden = true
            customViewThree.isHidden = true
            gridButtonClicked =  ConfigHomeDetails.twoCVTag
            self.settwoCollectionView()
            break
          
        
        case 3:
            print("sender.tag:",sender.tag)
            customViewOne.isHidden = true
            customViewTwo.isHidden = true
           
            gridButtonClicked = ConfigHomeDetails.threeTVTag
            self.setTableView()
            break
        
        default:
            break
            
        }
    }
    
    func config() -> FMPhotoPickerConfig {
        let selectMode: FMSelectMode = (.multiple)
        
        var mediaTypes = [FMMediaType]()
        mediaTypes.append(.image)
        mediaTypes.append(.video)
       
        
        var config = FMPhotoPickerConfig()
        
        config.selectMode = selectMode
        config.mediaTypes = mediaTypes
        config.maxImage = self.maxImage
        config.maxVideo = self.maxVideo
       
        // in force crop mode, only the first crop option is available
        config.availableCrops = [
            FMCrop.ratioSquare,
            FMCrop.ratioCustom,
            FMCrop.ratio4x3,
            FMCrop.ratio16x9,
            FMCrop.ratio9x16,
            FMCrop.ratioOrigin,
        ]
        
        // all available filters will be used
        config.availableFilters = []
        
        return config
    }
    
    
    
    
    

    @IBAction func plusButtonClicked(_ sender: UIButton) {
        
   
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.showsCameraControls = true
        //vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
  
    @IBAction func importButtonClicked(_ sender: UIButton) {
        //debugPrint("importButtonClicked", sender.tag)
        //let config = FMPhotoPickerConfig()
        
        let picker = FMPhotoPickerViewController(config: config())
        picker.delegate = self
        self.present(picker, animated: true)
        
        
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = false
//        self.present(imagePicker, animated: true, completion: nil)

    }
    
//    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
//            //self.imageViews[count].image = chosenImage
//            debugPrint("size", chosenImage.size)
//            count = count + 1
//            dismiss(animated: true, completion: nil)
//     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        debugPrint("print")
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
    }
    
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]){
        
        debugPrint("didFinishPickingPhotoWith")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
}

extension HomeDetailsVC:DBHomeDetails{
    
    func readDBDetails() {
       debugPrint("readDBDetails")
    }
    
    func writeDBDetails() {
        
    }
    
    func updateDBDetails() {
        
    }
    
    func deleteDBDetails() {
        
    }
    
    
}

