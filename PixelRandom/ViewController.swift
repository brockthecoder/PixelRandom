//
//  ViewController.swift
//  PixelRandom
//
//  Created by brock davis on 3/22/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let pixelRandomView = PixelRandomView()
    private let footer = UIView()
    private let resolutionLabel = UILabel()
    private let resolutionStepper = UIStepper()

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Footer
        self.view.addSubview(self.footer)
        self.footer.backgroundColor = .black
        self.footer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.footer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.footer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.footer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.footer.heightAnchor.constraint(equalToConstant: Configurations.footerHeight)
        ])
        
        // Resolution Stepper
        self.resolutionStepper.autorepeat = false
        self.resolutionStepper.wraps = true
        self.resolutionStepper.stepValue = UIScreen.main.scale
        self.resolutionStepper.minimumValue = 3
        self.resolutionStepper.maximumValue = (UIScreen.main.bounds.width * UIScreen.main.scale) / 10
        self.resolutionStepper.addTarget(self, action: #selector(self.stepperCountChanged), for: .valueChanged)
        self.resolutionStepper.tintColor = .black
        self.resolutionStepper.setIncrementImage(UIImage(systemName: "plus"), for: .normal)
        self.resolutionStepper.setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        self.resolutionStepper.setBackgroundImage(Configurations.resolutionStepperBackgroundImage(for: self.resolutionStepper.intrinsicContentSize), for: .normal)
        self.footer.addSubview(self.resolutionStepper)
        self.resolutionStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.resolutionStepper.trailingAnchor.constraint(equalTo: self.footer.trailingAnchor, constant: Configurations.resolutionStepperTrailingConstant),
            self.resolutionStepper.topAnchor.constraint(equalTo: self.footer.topAnchor, constant: Configurations.resolutionStepperTopConstant)
        ])
        
        // Resolution Label
        self.footer.addSubview(self.resolutionLabel)
        self.resolutionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.resolutionLabel.leadingAnchor.constraint(equalTo: footer.leadingAnchor, constant: Configurations.resolutionLabelLeadingConstant),
            self.resolutionLabel.centerYAnchor.constraint(equalTo: self.resolutionStepper.centerYAnchor)
        ])
        
        // Pixel View
        self.pixelRandomView.pixelDimension = UIScreen.main.bounds.width / (self.resolutionStepper.value * 10)

        self.pixelRandomView.mode = .random
        self.view.addSubview(self.pixelRandomView)
        self.pixelRandomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pixelRandomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pixelRandomView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.pixelRandomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pixelRandomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Configurations.footerHeight)
        ])
        
    }
    
    @objc private func stepperCountChanged() {
        self.pixelRandomView.pixelDimension = UIScreen.main.bounds.width / (self.resolutionStepper.value * 10)
        self.resolutionLabel.attributedText = NSAttributedString(string: "\(Int(self.pixelRandomView.bounds.width / self.pixelRandomView.pixelDimension)) x \(Int(self.pixelRandomView.bounds.height / self.pixelRandomView.pixelDimension))", attributes: Configurations.resolutionTextAttributes)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.resolutionLabel.attributedText = NSAttributedString(string: "\(Int(self.pixelRandomView.bounds.width / self.pixelRandomView.pixelDimension)) x \(Int(self.pixelRandomView.bounds.height / self.pixelRandomView.pixelDimension))", attributes: Configurations.resolutionTextAttributes)
    }
}

private struct Configurations {
    
    static let footerHeight: CGFloat = 80
    
    static let resolutionTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
    ]
    
    static let resolutionLabelLeadingConstant: CGFloat = 40.0
    
    
    static let resolutionStepperTrailingConstant: CGFloat = -40.0
    
    static let resolutionStepperTopConstant: CGFloat = 15.0
    
    static func resolutionStepperBackgroundImage(for size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            UIColor.white.setFill()
            UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: size.height / 8).fill()
        }
    }
}

