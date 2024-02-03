//
//  AddButtons.swift
//  ProductMarket
//
//  Created by Polina on 30.01.2024.
//

import UIKit

final class AddButtons: UIView {
    private var countProd: Int = 0 {
            didSet {
                textCountProd.text = "\(countProd)"
            }
        }

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textCountProd: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "1"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Const.colorGreen
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
        countProd += 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func plusTapped() {
        print("Plus button tapped...")
        countProd += 1
        minusButton.isUserInteractionEnabled = true
      }
    
    @objc private func minusTapped() {
        print("Minus button tapped...")
        chechCount()
      }
    
    private func chechCount(){
        if countProd <= 0 {
            minusButton.isUserInteractionEnabled = false
        } else {
            minusButton.isUserInteractionEnabled = true
            countProd -= 1
        }
    }
}

//MARK: - Constrains
extension AddButtons{
    func setConstrains(){
        addSubview(backgroundView)
        backgroundView.addSubview(minusButton)
        backgroundView.addSubview(plusButton)
        backgroundView.addSubview(textCountProd)
    
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            minusButton.heightAnchor.constraint(equalToConstant: 32),
            minusButton.widthAnchor.constraint(equalToConstant: 32),
            minusButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            minusButton.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            
            plusButton.heightAnchor.constraint(equalToConstant: 32),
            plusButton.widthAnchor.constraint(equalToConstant: 32),
            plusButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            plusButton.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            
            textCountProd.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textCountProd.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
        ])
    }
}
