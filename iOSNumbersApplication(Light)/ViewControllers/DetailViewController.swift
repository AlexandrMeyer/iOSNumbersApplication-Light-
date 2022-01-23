//
//  DetailViewController.swift
//  iOSNumbersApplication(Light)
//
//  Created by Александр on 17/01/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var number: Number?
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        addSubviews(imageView, label)
        setImageConstraint()
        setLabelConstraint()
        updateUI()
    }
    
    private func addSubviews(_ subViews: UIView...) {
        subViews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setImageConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.size.height / 1.5)
        ])
    }
    
    private func setLabelConstraint() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func updateUI() {
        NetworkManager.shared.fetchData(from: number?.image ?? "") { [unowned self] result in
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
                self.label.text = number?.name
            case .failure(let error):
                print(error)
            }
        }
    }
}
