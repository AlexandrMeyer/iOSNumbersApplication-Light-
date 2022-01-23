//
//  NumbersTableViewCell.swift
//  iOSNumbersApplication(Light)
//
//  Created by Александр on 17/01/2022.
//

import UIKit

class NumbersTableViewCell: UITableViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews(image, label)
        setImageConstraints()
        setLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subView in
            contentView.addSubview(subView)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            label.textColor = .white
            contentView.backgroundColor = .systemRed
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            label.textColor = .white
            contentView.backgroundColor = .systemBlue
        } else {
            label.textColor = .black
            contentView.backgroundColor = .clear
        }
    }
    
    func configure(with number: Number) {
        NetworkManager.shared.fetchData(from: number.image) { [unowned self] result in
            switch result {
            case .success(let data):
                self.image.image = UIImage(data: data)
                self.label.text = number.name
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension NumbersTableViewCell {
    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setLabelConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
