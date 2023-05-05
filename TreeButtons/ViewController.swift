//
//  ViewController.swift
//  TreeButtons
//
//  Created by Svetlana Shardakova on 04.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let firstButtonText: String = "First Button"
        static let secondButtonText: String = "Second Medium Button"
        static let thirdButtonText: String = "Third"
        static let buttonImage: UIImage = UIImage(systemName: "arrowshape.turn.up.right.circle.fill") ?? UIImage()
    }
    
    lazy var firstButton: RoundedButton = {
        let button = RoundedButton(title: Constants.firstButtonText, image: Constants.buttonImage)
        return button
    }()
    
    lazy var secondButton: RoundedButton = {
        let button = RoundedButton(title: Constants.secondButtonText, image: Constants.buttonImage)
        return button
    }()
    
    lazy var thirdButton: RoundedButton = {
        let button = RoundedButton(title: Constants.thirdButtonText, image: Constants.buttonImage)
        button.addTarget(self, action: #selector(thirdButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
//        setupUI()
        setupPositions()
    }

    func setupSubviews() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
    }
    
    func setupPositions() {
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.centerYAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 40),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.centerYAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 40)
        ])
    }
    
    
    @objc
    private func thirdButtonPressed() {
        openModalController()
    }
    
    private func openModalController() {
        let vc = ModalViewController()
        present(vc, animated: true) {
            print("Test1 closed???")
        }
    }


//    private func setupUI() {
//        firstButton.setTitle("Test1", for: .normal)
//    }

}

