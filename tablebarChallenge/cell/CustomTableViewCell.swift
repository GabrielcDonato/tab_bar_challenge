//
//  CustomTableViewCell.swift
//  tablebarChallenge
//
//  Created by Premiersoft on 17/09/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier: String = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        //comando para remover fundo cinza da cell
    }

 
    public func setupCell(profile: Profile) {
        userImageVIew.image = profile.photo
        nameLabel.text = profile.name
    }
    
}
