//
//  LoginViewController.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 21/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let model = ConnectivityModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidesWhenStopped = true
        
    }
    @IBAction func continueButton(_ sender: Any) {
        self.activityIndicator.startAnimating()
        model.login(
            user: userName.text ?? "",
            password: password.text ?? ""
        ) { [weak self] result in
            
           
                self?.activityIndicator.stopAnimating()
            
            
            switch result {
                case .success:
                    self?.model.getHeroes() { [weak self] result in
                        switch result {
                            case let .success(heroes):
                                DispatchQueue.main.async {
                                    let tableViewController = HeroesListTableViewController(heroes: heroes)
                                    
                                    self?.navigationController?.pushViewController(tableViewController, animated: true)
                                    print("Debe navegar")
                                }
                            case let .failure(error):
                                print("Error \(error)")
                        }
                    }
                case let .failure(error):
                    print("Error \(error)")
            }
        }
    }
    
}
