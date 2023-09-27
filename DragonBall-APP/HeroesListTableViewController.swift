//
//  HeroesListTableViewController.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 27/9/23.
//

import UIKit



class HeroesDataSource: NSObject, UITableViewDataSource {
   private let heroes: [Heroe] = []
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        let hero = heroes[indexPath.row]
       
        return cell
    }
}

