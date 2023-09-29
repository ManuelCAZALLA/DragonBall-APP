//
//  TransformationViewController.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 29/9/23.
//

import UIKit

class TransformationsViewController: UIViewController {
    
    @IBOutlet weak var transformationTableView: UITableView!
    var transformations: [Transformations]

    init(transformations: [Transformations]) {
        self.transformations = transformations
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones"

        
        transformationTableView.dataSource = self
        transformationTableView.delegate = self
        
        transformationTableView.register(UINib(nibName: "CustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
    }
}

// MARK: - Table View DataSource
extension TransformationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? CustomCellTableViewCell else {
            return UITableViewCell()
        }
        let transformation = transformations[indexPath.row]
        cell.configure(with: transformation)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - Table View Delegate
extension TransformationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    }

