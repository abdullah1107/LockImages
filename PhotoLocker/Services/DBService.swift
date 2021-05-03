//
//  DBService.swift
//  PhotoLocker
//  Created by Muhammad Abdullah Al Mamun on 22/4/21.
//

import Foundation
import UIKit
import RealmSwift
import AVFoundation

extension UIViewController{
    
    func writeFolderToRealm(folderName: String, folderData: Data){
        
        let realm = try! Realm() // realm object
        let disk = listFolder() // disk object
        let myFolder = Folders() // folder object
        
        realm.beginWrite()
        
        let folder = realm.objects(Folders.self).filter("folderName == '\(folderName)'")
        
        if folderName != folder.first?.folderName {
            
            myFolder.folderName = folderName
            myFolder.editablefolderName = folderName
            myFolder.folderDateAndTime = Date.getCurrentDateAndTime()
            myFolder.isPasswordProtected = false
            myFolder.folderData = folderData
            
            disk.folders.append(myFolder)
            
            realm.add(disk)
            do {
                try realm.commitWrite()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        else {
            realm.cancelWrite()
        }
    }//write folder into db
    
    
    // MARK: - Write Document To Realm
    
    func writeDocumentToRealm(folderName: String, documentName: String, documentData: Data, documentSize: Int) {
        
        
        
        let realm = try! Realm() // realm object
        let document = Documents() // document object
        
        realm.beginWrite()
        
        let filteredfolder = realm.objects(Folders.self).filter("folderName == '\(folderName)'")
        let filteredDocument = realm.objects(Documents.self).filter("documentName == '\(documentName)'")
        
        if documentName != filteredDocument.first?.documentName {
            
            document.documentName = documentName + Date.getCurrentTime()
            document.editabledocumentName = document.documentName
            document.documentData = documentData
            document.documentSize = documentSize
            document.documentDateAndTime = Date.getCurrentDateAndTime()
            document.isPasswordProtected = false
            filteredfolder.first?.documents.append(document)
            
            realm.add(document)
            do {
                try realm.commitWrite()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        else {
      
            realm.cancelWrite()
        }
    }// write image into db
    
   
    // MARK: - Read Folder From Realm
    
    func readFolderFromRealm() -> [Folders] {
        
        let realm = try! Realm() // realm object
        
        var myFolders = [Folders]()
        
        let folders = realm.objects(Folders.self)
        
        for folder in folders {
            
            if folder.folderName != "Default" {
                myFolders.append(folder)
            }
        }
        return myFolders
    }//read folder from db
    
    
    // MARK: - Read Document From Realm
    func readDocumentFromRealm(folderName: String, sortBy: String) -> [Documents] {
        
        let realm = try! Realm() // realm object
        var myDocuments = [Documents]()
        
        let folders = realm.objects(Folders.self).filter("folderName == '\(folderName)'")
       // print(folders[0].editablefolderName!)
        
        for folder in folders {
            
            for document in folder.documents.sorted(byKeyPath: sortBy, ascending: false) {
                
                myDocuments.append(document)
            }
        }
        return myDocuments
    }//read document from db
   
    
    
    
}
