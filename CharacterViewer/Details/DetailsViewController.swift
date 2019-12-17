//
//  DetailsViewController.swift
//  SimpsonsViewer
//
//  Created by Sultan Sultan on 12/14/19.
//  Copyright © 2019 Sultan Sultan. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var characterImage: UIImageView!
    var character: Character? {
        didSet {
            refershUI()
        }
    }
    
    func refershUI() {
        loadViewIfNeeded()
        titleLabel.text = character?.text.components(separatedBy: "-").first
        characterDescription.text = character?.text.components(separatedBy: "-").last
        // Set the image
        let url = URL(string: character?.imageURLString ?? "")
        characterImage.kf.setImage(with: url)
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CharacterDetailsViewController: CellSelectionDelegate {
    func cellSelected(with data: Character?) {
        character = data
    }
}
