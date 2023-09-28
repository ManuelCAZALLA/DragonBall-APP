//
//  CustomCellTableViewCell.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 27/9/23.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descriptionHero: UILabel!
    @IBOutlet weak var nameHero: UILabel!
    
    @IBOutlet weak var imageHero: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with heroe: Heroe) {
        nameHero.text = heroe.name
        descriptionHero.text = heroe.description
        if let imageUrl = URL(string: heroe.photo) {
            imageHero.setImage(for: imageUrl)
        }
    }
    
}
