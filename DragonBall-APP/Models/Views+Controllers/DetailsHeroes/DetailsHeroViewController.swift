//
//  DetailsHeroViewController.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 28/9/23.
//

import UIKit

class DetailsHeroViewController: UIViewController {
    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var descriptionHero: UITextView!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var transformationsButton: UIButton!
    
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
        nameHero.text = heroes.name
        descriptionHero.text = heroes.description
        if let imageUrl = URL(string: heroes.photo) {
            imageHero.setImage(for: imageUrl)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func buttonTransformaciones(_ sender: Any) {
        model.getTransformations(for: heroes) { [weak self] result in
            switch result {
            case let .success(transformations):
                DispatchQueue.main.async {
                    let transformationsViewController = TransformationsViewController(transformations: transformations)
                    self?.navigationController?.pushViewController(transformationsViewController, animated: true)
                }
            case let .failure(error):
                print("Error al obtener las transformaciones: \(error)")
            }
        }
        
        
    }
            
}
