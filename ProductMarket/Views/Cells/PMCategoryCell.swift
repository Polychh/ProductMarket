//
//  PMCategoryCell.swift
//  ProductMarket
//
//  Created by Polina on 21.12.2023.
//

import UIKit

final class PMCategoryCell: UICollectionViewCell {
    static let resuseID = "PMCategoryCell"
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        categoryImage.image = nil
        categoryLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.743064842)
        categoryImage.frame = self.contentView.bounds
        categoryImage.applyGradientMask(colors: [UIColor.clear, color], locations: [0.1, 1.0])
    }
}


//MARK: - Configure Cell UI
extension PMCategoryCell{
    func configCategoryLabel(categoryLabelText: String){
        categoryLabel.text = categoryLabelText
    }
    
    func configCategoryImage(image: UIImage?){
        if let image = image{
            categoryImage.image = image
        } else{
            categoryImage.image = UIImage(named: "defaultCategoryImage")
        }
    }
}

//MARK: - Constrains
extension PMCategoryCell{
    private func setConstrains(){
        contentView.layer.cornerRadius = 16
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImage.leadingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryImage.trailingAnchor , constant: -12),
            categoryLabel.bottomAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: -12)
        ])
    }
}
