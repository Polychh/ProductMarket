//
//  DetailProdCardVC.swift
//  ProductMarket
//
//  Created by Polina on 26.01.2024.
//

import UIKit

final class DetailProdCardVC: UIViewController {
    
    let heighImage: CGFloat
    let heightDescriptlabel: CGFloat
    
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
        label.backgroundColor = .brown
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
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(heighImage: CGFloat, heightLabel: CGFloat) {
        self.heighImage = heighImage
        self.heightDescriptlabel = heightLabel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrains()
    }
    
    @objc private func handleAddButtonTapped() {
         print("Add button tapped1...")
      }
}

//MARK: - Configure UI
extension DetailProdCardVC{
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
extension DetailProdCardVC{
    func setConstrains(){
        view.backgroundColor = .white
        view.addSubview(productImage)
        view.addSubview(stackView)
        stackView.addArrangedSubview(productLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(descriptLabel)
        view.addSubview(addButton)
        
        let pad: CGFloat = 16
        
        NSLayoutConstraint.activate([
            productImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: pad),
            productImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -pad),
            productImage.topAnchor.constraint(equalTo: view.topAnchor,constant: pad / 2),
            productImage.heightAnchor.constraint(equalToConstant: heighImage),
            
            stackView.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: pad),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -pad),
            stackView.bottomAnchor.constraint(equalTo: addButton.topAnchor , constant: -24),
            
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: pad),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -pad),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -pad),
            addButton.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
}
