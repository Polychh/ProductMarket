//
//  ProductCardDetailVC.swift
//  ProductMarket
//
//  Created by Polina on 27.01.2024.
//

import UIKit
import Combine

final class ProductCardDetailVC: UIViewController {
    
    @Published var countProdDetailVC: Int = .init()
    var productIndexPath: IndexPath = .init()
    
    private var cancellables = Set<AnyCancellable>()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrains()
        observe()
    }
    
    private func observe(){
        $countProdDetailVC
            .receive(on: DispatchQueue.main)
            .sink {value in
                if value > 0 {
                    self.isHiddenElements(minusButIsHid: false, plusButIsHid: false, addButIsHid: true, counProdLabelIsHid: false)
                }
                self.textCountProd.text = "\(value)"
            }
            .store(in: &cancellables)
    }
        
    @objc private func handleAddButtonTapped() {
//        isHiddenElements(minusButIsHid: false, plusButIsHid: false, addButIsHid: true, counProdLabelIsHid: false)
        countProdDetailVC = 0
        countProdDetailVC += 1
         print("Add button tapped...")
      }
    
    @objc private func plusTapped() {
        if countProdDetailVC > 49{
            plusButton.isEnabled = false
        } else{
            countProdDetailVC += 1
        }
      }
    
    @objc private func minusTapped() {
        plusButton.isEnabled = true
        if countProdDetailVC > 1{
            countProdDetailVC -= 1
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
    
    @objc private func dismissVC() {
        cleanUI()
        dismiss(animated: true)
      }
    
    private func cleanUI(){
        textCountProd.text = ""
        isHiddenElements(minusButIsHid: true, plusButIsHid: true, addButIsHid: false, counProdLabelIsHid: true)
    }

}
//MARK: - Configure UI
extension ProductCardDetailVC{
    
    func configDetailCardVC(productText: String, price: String, descText: String, image: Data?){
        configProductLabel(productText: productText)
        configPricetLabel(price: price)
        configDescriptLabel(descText: descText)
        configProductImage(image:image)
    }
    
    private func configProductLabel(productText: String){
        productLabel.text = productText
    }
    
    private func configPricetLabel(price: String){
        priceLabel.text = price + " rub"
    }
    
    private func configDescriptLabel(descText: String){
        descriptLabel.text = descText
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
        containerView.addSubview(minusButton)
        containerView.addSubview(plusButton)
        containerView.addSubview(textCountProd)
        
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
            
            minusButton.heightAnchor.constraint(equalToConstant: 32),
            minusButton.widthAnchor.constraint(equalToConstant: 32),
            minusButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            minusButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            
            plusButton.heightAnchor.constraint(equalToConstant: 32),
            plusButton.widthAnchor.constraint(equalToConstant: 32),
            plusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            plusButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            
            textCountProd.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            textCountProd.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            
        ])
    }
}
