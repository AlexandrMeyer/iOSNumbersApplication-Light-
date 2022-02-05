//
//  MasterTableViewController.swift
//  iOSNumbersApplication(Light)
//
//  Created by Александр on 17/01/2022.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    private let reuseIdentifier = "Cell"
    
    var numbers: [Number] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NumbersTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Number List"
        
        fetchData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NumbersTableViewCell
        
        let number = numbers[indexPath.row]
        cell.configure(with: number)
        
        return cell
    }
    
    func fetchData() {
        NetworkManager.shared.fetchInfo { [unowned self] result in
            switch result {
            case .success(let numbers):
                self.numbers = numbers
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(50)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let number = numbers[indexPath.row]
        detailVC.number = number
        showDetailViewController(UINavigationController(rootViewController: detailVC), sender: nil)
    }
}

