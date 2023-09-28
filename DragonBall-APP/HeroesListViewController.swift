//
//  HeroesListViewController.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 27/9/23.
//

import UIKit

class HeroesListViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300") else {
            return
        }
        imageView.setImage(for: url)
        
    }


   
}
