//
//  HeroesListTableViewController.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 28/9/23.
//

import UIKit

class HeroesListTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var heroes: [Heroe]
    
    init(heroes: [Heroe]) {
        self.heroes = heroes
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dragon Ball Heroes"
        
      //  navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "CustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Table View DataSource
extension HeroesListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? CustomCellTableViewCell else {
            return UITableViewCell()
        }
        
        let heroe = heroes[indexPath.row]
        cell.configure(with: heroe)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}


// MARK: - Table View Delegate
extension HeroesListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroe = heroes[indexPath.row]
        let detailViewController = DetailsHeroViewController(heroes: heroe)
        navigationController?.setViewControllers([detailViewController], animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

