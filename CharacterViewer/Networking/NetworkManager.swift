//
//  NetworkManager.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/14/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation
import Alamofire


/// An enum to get the current app from plist file . E.X, Wire, Simpsons
public enum Config {
    
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  static let appType: String = {
    guard let appTypeString = Config.infoDictionary["AppType"] as? String else {
      fatalError("App Type not set in plist for this scheme")
    }

    return appTypeString
  }()
}

class NetworkManager: NSObject {
    
    // MARK: - Properties
    static let sharedInstance = NetworkManager()
    
     func fetchDictFrom(url: String?, cache: Bool, completion: @escaping (Any) -> Void)  {
           
           // No URL, no point of proceeding so early exit
           guard let url = url else{
               return
           }
           // Request data from Almo
           AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response  in
               
               switch response.result {
               case .success(let payload):
                   guard let jsonArray = payload as? [String: Any] else { return }
                   completion(jsonArray)
               case .failure(let error):
                   print("Request failed with error: \(error)")
               }
           }
       }
    
    func getURL() -> String {
        let factory = URLFactory()
        return (factory.getURLForAppType())
    }
}


struct URLFactory {
    
    /// Base URLS
    internal let charactersBaseURL = "https://api.duckduckgo.com/"

    /// Characters URL Path
    public enum charactersURLPath: String {
        // For specfic launch append the number to the end. example: /30
       case wire = "?q=the+wire+characters&format=json"
       case simpsons = "?q=simpsons+characters&format=json"
    }
    
    func getURLForAppType() -> String {
        
        switch Config.appType {
        case "Wire": return charactersBaseURL + charactersURLPath.wire.rawValue
        case "Simpsons" : return charactersBaseURL + charactersURLPath.simpsons.rawValue
        default:
            return charactersBaseURL + charactersURLPath.wire.rawValue
        }
    }
}

