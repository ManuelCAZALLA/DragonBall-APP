//
//  TransformationDetailViewController.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 29/9/23.
//

import UIKit

class TransformationDetailViewController: UIViewController {

    @IBOutlet weak var descriptionTransformations: UITextView!
    @IBOutlet weak var nameTransformations: UILabel!
    @IBOutlet weak var imageTansformations: UIImageView!
    
   var heroes: Heroe
    var transformation: [Transformations] = []
    
    init(heroes: Heroe) {
        self.heroes = heroes
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let model = ConnectivityModel()
    var transformations = [Transformations]?.self
    
    func configure() {
        nameTransformations.text = heroes.name
        descriptionTransformations.text = heroes.description
        if let imageUrl = URL(string: heroes.photo) {
            imageTansformations.setImage(for: imageUrl)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        
        
    }
}
