//
//  EmptyView.swift
//  ProductMarket
//
//  Created by Polina on 29.01.2024.
//

import UIKit

final class EmptyView: UIView {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Ничего не нашли"
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bag")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        image.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        image.layer.shadowOpacity = 1.0
        image.layer.shadowRadius = 2.0
        image.layer.masksToBounds = false
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.spacing = 28
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Constrains
extension EmptyView{
    func setConstrains(){
        self.backgroundColor = .white
        stackView.addArrangedSubview(emptyImage)
        stackView.addArrangedSubview(textLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 244),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 86),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 86),
        ])
    }
}
