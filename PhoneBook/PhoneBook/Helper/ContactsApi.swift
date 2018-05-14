//
//  ContactsApi.swift
//  PhoneBook
//
//  Created by Neelam on 13/05/18.
//  Copyright © 2018 Neelam. All rights reserved.
//

import Foundation
import CoreData

class ContactsApi {
    
    static let GetContacts = "http://gojek-contacts-app.herokuapp.com/contacts.json"
    
    static let GetContactDetailBaseUrlString = "http://gojek-contacts-app.herokuapp.com/contacts"
    
    static let EditContactDetailsBaseUrlString = "http://gojek-contacts-app.herokuapp.com/contacts"
    
    static let AddContact = "http://gojek-contacts-app.herokuapp.com/contacts.json"
    
    
    
    class func loadContacts(completion: @escaping (_ contacts: [Contact]) -> ()) {
        
        var contacts =  [Contact]()
        
        var request = URLRequest(url: URL(string: ContactsApi.GetContacts)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, let _ = data else {
                print("error: not a valid http response")
                return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                do {
                    let contactJson = try JSONSerialization.jsonObject(with: data!) as! Array<Dictionary<String,Any>>
                    
                    for contact in contactJson {
                        for (_,_) in contact {
                            let entity = NSEntityDescription.entity(forEntityName: "Contact", in: PersistenceService.context)
                            let newContact = NSManagedObject(entity: entity!, insertInto: PersistenceService.context)
                            
                            newContact.setValue(contact["favorite"] as! Int32, forKey: "favorite")
                            newContact.setValue(contact["id"] as! Int32, forKey: "id")
                            newContact.setValue(contact["first_name"] as? String, forKey: "firstName")
                            newContact.setValue(contact["last_name"] as? String, forKey: "lastName")
                            newContact.setValue(contact["profile_pic"] as? String, forKey: "profilePic")
                            newContact.setValue(contact["url"] as? String, forKey: "url")
                            
                            contacts.append(newContact as! Contact)
                        }
                    }
                    PersistenceService.saveContext()
                    completion(contacts)
                    
                }catch {
                    print("error")
                }
                break
            case 404:
                print("Not Found")
                break
            case 500:
                print("Internal Server Error")
                break
            case 422:
                print("Validation Errors")
                break
            default:
                print("contacts GET request got response \(httpResponse.statusCode)")
            }
        })
        task.resume()
    }
    
    class func loadContactDetailById(id: Int, completion: @escaping (_ contactDetails: ContactDetailModel) -> ()) {
        
        var request = URLRequest(url: URL(string: ContactsApi.GetContactDetailBaseUrlString + "/\(id).json")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, let _ = data else {
                print("error: not a valid http response")
                return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                do {
                    let contactDetailJson = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,Any>
                    let contactDetails = ContactDetailModel(with: contactDetailJson)
                    completion(contactDetails)
                    
                }catch {
                    print("error")
                }
                break
            case 404:
                print("Not Found")
                break
            case 500:
                print("Internal Server Error")
                break
            case 422:
                print("Validation Errors")
                break
            default:
                print("contacts GET request got response \(httpResponse.statusCode)")
            }
        })
        task.resume()
    }
    
    class func EditContactDetailsById(id: Int, headers: Dictionary<String, Any>, completion: @escaping (_ updatedContactDetails: ContactDetailModel) -> ()) {
        
        var request = URLRequest(url: URL(string: ContactsApi.EditContactDetailsBaseUrlString + "/\(id).json")!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: headers)
        
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, let _ = data else {
                print("error: not a valid http response")
                return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                do {
                    let contactDetailJson = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,Any>
                    let contactDetails = ContactDetailModel(with: contactDetailJson)
                    completion(contactDetails)
                    
                }catch {
                    print("error")
                }
                break
            case 404:
                print("Not Found")
                break
            case 500:
                print("Internal Server Error")
                break
            case 422:
                print("Validation Errors")
                break
            default:
                print("contacts GET request got response \(httpResponse.statusCode)")
            }
        })
        task.resume()
    }
    
    class func addContactDetails(headers: [String: Any], completion: @escaping (_ status: String) -> ()) {
        
        var request = URLRequest(url: URL(string: ContactsApi.AddContact)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: headers)
        
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, let _ = data else {
                print("error: not a valid http response")
                return
            }
            
            switch (httpResponse.statusCode) {
            case 201:
                completion("Contact successfully created")
                break
            case 404:
                completion("Not Found")
                break
            case 500:
                completion("Internal Server Error")
                break
            case 422:
                completion("Validation Errors")
                break
            default:
                print("contacts GET request got response \(httpResponse.statusCode)")
            }
        })
        task.resume()
    }
}
