//
//  PMProductCell.swift
//  ProductMarket
//
//  Created by Polina on 24.01.2024.
//

import UIKit
import Combine

final class PMProductCell: UICollectionViewCell {
    var id: Int = 0
    @Published var countProdCell: Int = .init()
    
    var cancellables = Set<AnyCancellable>()
    static let resuseID = "PMProductCell"
    
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
    
    private let textCountProd: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .black
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Const.colorGreen
        button.isHidden = true
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(nil, action: #selector(plusTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Const.colorGreen
        button.isHidden = true
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(nil, action: #selector(minusTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstrains()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe(){
        $countProdCell
            .receive(on: DispatchQueue.main)
            .sink {value in
                if value > 0 {
                    
                    print("1")
                    //print("value > 0")
                    self.isHiddenElements(minusButIsHid: false, plusButIsHid: false, addButIsHid: true, counProdLabelIsHid: false)
                }
                self.textCountProd.text = "\(value)"
                //print("Change text \(self.id)")
                
            }
            .store(in: &cancellables)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("reuse")
        productImage.image = nil
        productLabel.text = nil
        priceLabel.text = nil
        textCountProd.text = nil
        cancellables = Set<AnyCancellable>() // возможно удалить
        countProdCell = 0
        observe()
        //addButtons.cancellables = .init()
        isHiddenElements(minusButIsHid: true, plusButIsHid: true, addButIsHid: false, counProdLabelIsHid: true)
       
    }
    
    @objc private func handleAddButtonTapped() {
       // isHiddenElements(minusButIsHid: false, plusButIsHid: false, addButIsHid: true, counProdLabelIsHid: false)
        //countProdCell = 0
        countProdCell += 1
        print("tapped \(countProdCell)")
      }
    
    @objc private func plusTapped() {
        if countProdCell > 49{
            plusButton.isEnabled = false
        } else{
            countProdCell += 1
        }
      }
    
    @objc private func minusTapped() {
        plusButton.isEnabled = true
        if countProdCell > 1{
            countProdCell -= 1
        } else{
            isHiddenElements(minusButIsHid: true, plusButIsHid: true, addButIsHid: false, counProdLabelIsHid: true)
        }
      }
    
    private func isHiddenElements(minusButIsHid: Bool, plusButIsHid: Bool, addButIsHid: Bool, counProdLabelIsHid: Bool){
        minusButton.isHidden = minusButIsHid
        plusButton.isHidden = plusButIsHid
        textCountProd.isHidden = counProdLabelIsHid
        addButton.isHidden = addButIsHid
    }
}

//MARK: - Configure Cell UI
extension PMProductCell{
    
    func configCell(productText: String, price: String, image: Data? ){
        configProductLabel(productText: productText)
        configPricetLabel(price: price)
        configProductImage(image: image)
    }
    
   private func configProductLabel(productText: String){
        productLabel.text = productText 
    }
    
   private  func configPricetLabel(price: String){
        priceLabel.text = price + " rub"
    }
    
    private func configProductImage(image: Data?){
        if let image = image{
            productImage.image = UIImage(data: image)
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
        contentView.addSubview(productImage)
        contentView.addSubview(productLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)
        contentView.addSubview(textCountProd)
        
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
            
            minusButton.heightAnchor.constraint(equalToConstant: 32),
            minusButton.widthAnchor.constraint(equalToConstant: 32),
            minusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            minusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            plusButton.heightAnchor.constraint(equalToConstant: 32),
            plusButton.widthAnchor.constraint(equalToConstant: 32),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            plusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            textCountProd.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textCountProd.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
        ])
    }
}
