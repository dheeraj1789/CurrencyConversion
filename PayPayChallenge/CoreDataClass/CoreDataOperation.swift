//
//  CoreDataOperation.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataOperation
{
    
    static let shared = CoreDataOperation()
  
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getContext()->NSManagedObjectContext
    {
     return appDelegate.persistentContainer.viewContext
    }
    
    func saveUpdateData(entityName:String,attributeName:String,dataObject:String)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
      request.returnsObjectsAsFaults = false
        do {
            let result = try getContext().fetch(request)
            if result.count>0
            {
       self.updateData(entityName:entityName,attributeName:attributeName,dataObject:dataObject)
           
            
            }else
            {
           saveData(entityName:entityName,attributeName:attributeName,dataObject:dataObject)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    func updateData(entityName:String,attributeName:String,dataObject:String)
   {
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
   
    request.returnsObjectsAsFaults = false
    
    do {
        let result = try getContext().fetch(request)
     let object = result[0] as! NSManagedObject
        object.setValue(dataObject, forKey: attributeName)
        do {
            try getContext().save()
        } catch {
            print("Failed saving")
        }
        
    } catch {
        
        print("Failed")
    }
    
    }
    func saveData(entityName:String,attributeName:String,dataObject:String){
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: getContext())
        let newUser = NSManagedObject(entity: entity!, insertInto:getContext())
        newUser.setValue(dataObject, forKey: attributeName)
        do {
            try getContext().save()
        } catch {
            print("Failed saving")
        }
        
    }
    func fetchData(entityName:String,attributeName:String)->String
    {
        var dataString:String=""
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
     
        request.returnsObjectsAsFaults = false
        do {
            let result = try getContext().fetch(request)
          
            for data in result as! [NSManagedObject] {
                print("Data fetched from Core Data \(data.value(forKey: attributeName) as! String)")
                dataString = data.value(forKey: attributeName) as! String
            }
            
            
        } catch {
            
            print("Failed")
        }
        return dataString
        
    }
   
    func getParsedData<T: Decodable>(entityName:String,attributeName:String, completion: @escaping (T?) -> ()) {
        do{
            let urlString = fetchData(entityName:entityName,attributeName:attributeName)
            let jsonData = urlString.data(using: .utf8)!
            do {
                let responseModel = try JSONDecoder().decode(T.self, from: jsonData)
                completion(responseModel)
            } catch let jsonErr {
                print("Failed to serialize json:", jsonErr)
                completion(nil)
            }
        }
    }
}
