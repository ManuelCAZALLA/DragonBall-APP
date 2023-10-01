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
    
    
    var transformation: Transformations
    
    init(transformation: Transformations) {
        self.transformation = transformation
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let model = ConnectivityModel()
   
    func configure() {
        nameTransformations.text = transformation.name
        descriptionTransformations.text = transformation.description
        if let imageUrl = URL(string: transformation.photo) {
            imageTansformations.setImage(for: imageUrl)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

