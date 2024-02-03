//
//  PMProductCell.swift
//  ProductMarket
//
//  Created by Polina on 24.01.2024.
//

import UIKit

final class PMProductCell: UICollectionViewCell {
    static let resuseID = "PMProductCell"
    
    private let addButtons = AddButtons()
    
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
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = Const.colorGreen
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = Const.colorGreen
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addTarget(nil, action: #selector(handleAddButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        productLabel.text = nil
        priceLabel.text = nil
    }
    
    @objc private func handleAddButtonTapped() {
        addButton.isHidden = true
        addButtons.isHidden = false
         print("Add button tapped...")
      }
}

//MARK: - Configure Cell UI
extension PMProductCell{
    func configProductLabel(productText: String){
        productLabel.text = productText 
    }
    
    func configPricetLabel(price: String){
        priceLabel.text = price + " rub"
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
extension PMProductCell{
    func setConstrains(){
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        addButtons.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImage)
        contentView.addSubview(productLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(addButtons)
        addButtons.isHidden = true
        
        let pad: CGFloat = 4
        
        NSLayoutConstraint.activate([
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: pad),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -pad),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: pad),
            productImage.heightAnchor.constraint(equalToConstant: 96),
          
            productLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: pad),
            productLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: pad),
            productLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -pad),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: pad),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -pad),
            priceLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16),
            
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            addButton.heightAnchor.constraint(equalToConstant: 32),
            
            addButtons.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            addButtons.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            addButtons.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            addButtons.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
}
