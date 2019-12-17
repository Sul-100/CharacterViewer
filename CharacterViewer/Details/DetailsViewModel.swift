//
//  DetailsViewModel.swift
//  SimpsonsViewer
//
//  Created by Sultan R. Sultan on 12/17/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import Foundation

class DetailsViewModel {
  
  func getCharacterName(from text: String) -> String{
    return text.components(separatedBy: "-").first ?? "Name can't be found" //TODO:- Fix Me
  }
  
  func getCharacterDescription(from text: String) -> String{
    return text.components(separatedBy: "-").last ?? "Description can't be found" //TODO:- Fix Me
  }
}
