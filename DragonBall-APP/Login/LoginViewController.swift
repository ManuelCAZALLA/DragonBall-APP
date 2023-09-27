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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func continueButton(_ sender: Any) {
        
        let model = ConnectivityModel()
        model.login(
            user: userName.text ?? "",
            password: password.text ?? "")
        { result in
            
            switch result {
                case let .success(token):
                    
                    model.getHeroes(token: token) { result in
                        switch result {
                            case let .success(heroes):
                                let heroeTableView = HeroesDataSource()
                               
                                navigationController?.pushViewController([heroeTableView], animated: true)
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
            
            
            
        
        
    
    

    

    


