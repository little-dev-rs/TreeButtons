//
//  ViewController.swift
//  TreeButtons
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let topOffset: CGFloat = 100
        static let verticalOffset: CGFloat = 40
        static let firstButtonText: String = "First Button"
        static let secondButtonText: String = "Second Medium Button"
        static let thirdButtonText: String = "Third"
        static let buttonImage: UIImage = UIImage(systemName: "arrowshape.turn.up.right.circle.fill") ?? UIImage()
    }
    
    lazy var firstButton = RoundedButton(title: Constants.firstButtonText, image: Constants.buttonImage)
    lazy var secondButton = RoundedButton(title: Constants.secondButtonText, image: Constants.buttonImage)
    lazy var thirdButton: RoundedButton = {
        let button = RoundedButton(title: Constants.thirdButtonText, image: Constants.buttonImage)
        button.addTarget(self, action: #selector(thirdButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupPositions()
    }

}

//MARK: - Appearance

private extension ViewController {
    
    private func setupSubviews() {
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
            firstButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topOffset),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.centerYAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: Constants.verticalOffset),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.centerYAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: Constants.verticalOffset)
        ])
    }
}

//MARK: - Actions

private extension ViewController {
    
    @objc
    private func thirdButtonPressed() {
        openModalController()
    }

    private func openModalController() {
        let vc = ModalViewController()
        present(vc, animated: true)
    }


}
