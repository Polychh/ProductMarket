//
//  ProductCardDetailVC.swift
//  ProductMarket
//
//  Created by Polina on 27.01.2024.
//

import UIKit

final class ProductCardDetailVC: UIViewController {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        button.addTarget(nil, action: #selector(dismissVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Const.colorGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.67, green: 0.67, blue: 0.68, alpha: 1)
        label.numberOfLines = 4
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = Const.colorGreen
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(nil, action: #selector(handleAddButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrains()
      
    }
    
    @objc private func handleAddButtonTapped() {
         print("Add button tapped1...")
      }
    @objc private func dismissVC() {
        dismiss(animated: true)
      }

}
//MARK: - Configure UI
extension ProductCardDetailVC{
    func configProductLabel(productText: String){
        productLabel.text = productText
    }
    
    func configPricetLabel(price: String){
        priceLabel.text = price + " rub"
    }
    
    func configDescriptLabel(descText: String){
        descriptLabel.text = descText
    }
    
    func configProductImage(image: UIImage?){
        if let image = image{
            productImage.image = image
        } else{
            productImage.image = UIImage(named: "defaultCategoryImage")
        }
    }
}

//MARK: - Constrains
extension ProductCardDetailVC{
    func setConstrains(){
        view.addSubview(backView)
        view.addSubview(dismissButton)
        view.addSubview(containerView)
        containerView.addSubview(productImage)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(productLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(descriptLabel)
        containerView.addSubview(addButton)
        
        let pad: CGFloat = 16
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 484),
            
            dismissButton.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            dismissButton.topAnchor.constraint(equalTo: backView.topAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            productImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: pad),
            productImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -pad),
            productImage.topAnchor.constraint(equalTo: containerView.topAnchor,constant: pad / 2),
            productImage.heightAnchor.constraint(equalToConstant: 208),
            
            stackView.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: pad),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -pad),
            stackView.bottomAnchor.constraint(equalTo: addButton.topAnchor , constant: -24),
           
            addButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: pad),
            addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -pad),
            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            addButton.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
}
