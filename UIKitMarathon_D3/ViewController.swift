//
//  ViewController.swift
//  UIKitMarathon_D3
//
//  Created by Maksim Vaselkov on 09.02.2024.
//

import UIKit

class ViewController: UIViewController {

    private lazy var square: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.layer.cornerCurve = .continuous

        return view
    }()

    private lazy var slider: UISlider = {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 0.0
        slider.maximumValue = 1
        slider.tintColor = .systemBlue

        return slider

    }()

    private var lastSliderValue: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        square.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(square)
        view.addSubview(slider)

        slider.addTarget(self, action: #selector(transformSquare(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            square.widthAnchor.constraint(equalToConstant: 50),
            square.heightAnchor.constraint(equalToConstant: 50),
            square.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            square.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.topAnchor.constraint(equalTo: square.bottomAnchor, constant: 50),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc
    private func transformSquare(_ sender: UISlider) {
        let minValue = view.layoutMargins.left + square.frame.width / 2
        let maxValue = view.frame.width - view.layoutMargins.right - square.frame.width / 2
        self.square.center.x = minValue + (maxValue - minValue) * CGFloat(sender.value)

        let rotationValue = CGFloat(slider.value) * (.pi / 2)
        let scaleValue = CGFloat(slider.value) * 0.5 + 1
        square.transform = CGAffineTransform(
            rotationAngle: rotationValue
        ).scaledBy(x: scaleValue, y: scaleValue)
    }

    @objc
    private func touchUpInside(_ sender: UISlider) {
        sender.setValue(sender.maximumValue, animated: true)

        UIView.animate(withDuration: 0.5) {
            self.transformSquare(sender)
        }
    }


}

