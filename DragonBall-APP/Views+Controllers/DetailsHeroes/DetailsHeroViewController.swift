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
    var transformations: [Transformations] = []
    
    init(heroes: Heroe) {
        self.heroes = heroes
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let model = ConnectivityModel()
    
    func configure() {
        nameHero.text = heroes.name
        descriptionHero.text = heroes.description
        if let imageUrl = URL(string: heroes.photo) {
            imageHero.setImage(for: imageUrl)
        }
    }
    func checkTransformations() {
        if transformations.isEmpty {
            model.getTransformations(for: heroes) { [weak self] result in
                switch result {
                case let .success(transformations):
                    self?.transformations = transformations
                    if transformations.isEmpty {
                        DispatchQueue.main.async {
                            self?.transformationsButton.isHidden = true
                        }
                    }
                case let .failure(error):
                    print("Lamentablemente este heroe no tiene transformaciones: \(error)")
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        checkTransformations()
    }
    
    
    
    @IBAction func buttonTransformaciones(_ sender: Any) {
       let transformationsViewController = TransformationsViewController(heroes: heroes, transformations: transformations)
        navigationController?.show(transformationsViewController, sender: nil)
    }
}
