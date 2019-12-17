//
//  HomeViewModel.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/14/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation

protocol CharacterViewModelDelegateProtocol: class {
    func didRecieveData(chararcters:[Character])
}

class CharacterHomeViewModel: NSObject {
    private let networkManager = NetworkManager.sharedInstance
    weak var delegate: CharacterHomeViewController?
    /**
        Method to fetch all launches from the space x API
        */
       func fetchAllCharacters()  {
                    networkManager.fetchDictFrom(url: NetworkManager.sharedInstance.getURL(), cache: true, completion: { (response) in
                    guard  let jsonData = try? JSONSerialization.data(withJSONObject:response) else { return}
               
                      do {
                            let jsonDecoder = JSONDecoder()
                            let topLevelDictionary = try jsonDecoder.decode(TopLevelDictionary.self, from: jsonData)
                            self.delegate?.didRecieveData(chararcters: topLevelDictionary.televisionCharacters)
                      } catch { /* Report the decoding error */ print("can't decode Character json data",error) }
        })
    }
    
    
    func getName(from text: String) -> String? {
        return text.components(separatedBy: "-").first
    }
    
}
