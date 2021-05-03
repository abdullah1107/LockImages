//  HomeVC.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 18/4/21.

import UIKit

class HomeVC: UIViewController {
    
    var homeCV: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var folders = [Folders]()
    var documents = [Documents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallary/Home"
        self.setCollectionView()
        self.baseFolderWrite()
       
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        debugPrint("view willAppear")
        
        DispatchQueue.main.async {
            self.readDB()
            self.homeCV.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        debugPrint("view didAppear")
    }
    
    override func viewWillLayoutSubviews() {
        debugPrint("will subview")
    }
    
    override func viewDidLayoutSubviews() {
        debugPrint("did subview")
    }
    
    
    func baseFolderWrite(){
        debugPrint("baseFolderWrite")
        
        var rawImages: [UIImage] = [UIImage]()
        
        let Names = ["Photo Album", "Documents", "Videos", "NewFolder"]
        var basefolderNames: [String] = [String]()
        let images = ["photoalbum", "document", "video", "newfolder"]
        for i in 0...3{
            rawImages.insert(UIImage(named: images[i]) ?? UIImage(), at: i)
            basefolderNames.append(Names[i])
        }
        //debugPrint(rawImages.count)
        
        for rawImage in 0...rawImages.count - 1  {
            
            debugPrint(rawImage)
            
            if let imageData = rawImages[rawImage].jpegData(compressionQuality: 0.9) {
                
                self.writeFolderToRealm(folderName: basefolderNames[rawImage], folderData: imageData)
                
                
            }
        }
        
    }
    
    func readDB(){
        
        debugPrint("readDB")
        self.folders.removeAll()
        self.folders = self.readFolderFromRealm()
        //print("Folders Count", folders.count)
    }
    
    
    @IBAction func addNewAction(_ sender: UIBarButtonItem) {
        debugPrint("addNewAction")
        
        if let addNew = self.storyboard?.instantiateViewController(withIdentifier: "AddNewFolderVC") as? AddNewFolderVC {
            self.navigationController?.pushViewController(addNew, animated: true)
        }
    }
    
    
    @IBAction func settingButtonAction(_ sender: UIBarButtonItem) {
        debugPrint("settingButtonAction")
    }
    
    
    
}


