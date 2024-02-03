//
//  BusketView.swift
//  ProductMarket
//
//  Created by Polina on 27.01.2024.
//

import UIKit

final class BusketView: UIView {
    private let basketButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.addTarget(nil, action: #selector(handleAddButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = Const.colorGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let busketImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "basket")?.withTintColor(.white)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Добавить"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .horizontal
        stack.spacing = 6
        stack.distribution = .fillProportionally
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
    
    @objc private func handleAddButtonTapped() {
         print("Add button tapped2...")
      }
}


//MARK: - Constrains
extension BusketView{
    func setConstrains(){
        addSubview(backView)
        addSubview(stackView)
        stackView.addArrangedSubview(busketImage)
        stackView.addArrangedSubview(label)
        addSubview(basketButton)
        
        let padH: CGFloat = 16
        let padV: CGFloat = 12
        
        NSLayoutConstraint.activate([
            backView.widthAnchor.constraint(equalToConstant: 168),
            backView.heightAnchor.constraint(equalToConstant: 48),
            
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor,constant: padH),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor,constant: -padH),
            stackView.topAnchor.constraint(equalTo: backView.topAnchor,constant: padV),
            stackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: -padV),
            
            basketButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            basketButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            basketButton.widthAnchor.constraint(equalToConstant: 168),
            basketButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
