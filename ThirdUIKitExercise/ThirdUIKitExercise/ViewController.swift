//
//  ViewController.swift
//  ThirdUIKitExercise
//
//  Created by Лада Зудова on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var slider = UISlider(frame: .zero)
    
    private lazy var square: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 4
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        slider.translatesAutoresizingMaskIntoConstraints = false
        square.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged(sender: event:)), for: .valueChanged)
        view.addSubview(slider)
        view.addSubview(square)
        view.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            slider.topAnchor.constraint(equalTo: square.bottomAnchor, constant: 30),
            
            square.widthAnchor.constraint(equalToConstant: 80),
            square.heightAnchor.constraint(equalToConstant: 80),
            square.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            square.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60),
            square.trailingAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
    }

    @objc func sliderValueChanged(sender: UISlider, event: UIEvent) {
        let width = self.view.frame.width - self.view.layoutMargins.right - self.view.layoutMargins.left - self.square.frame.size.width
        let size = CGFloat(sender.value/sender.maximumValue)
        if let touchEvent = event.allTouches?.first {
                switch touchEvent.phase {
                case .moved:
                    UIView.animate(withDuration: 0) { [weak self] in
                        guard let self = self else { return }
                        let transform = CGAffineTransform(scaleX: 1 +  0.5 * size, y: 1 +  0.5 * size)
                            .rotated(by: CGFloat.pi/2 * size)
                        self.square.transform = transform
                        self.square.center.x = self.view.layoutMargins.left + 0.5 * self.square.frame.size.width + width * size
                    }
                    break
                case .ended:
                    let animationDuration = 2 - 2 * size
                    UIView.animate(withDuration: animationDuration) {
                        sender.setValue(100, animated: true)
                        let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            .rotated(by: CGFloat.pi/2)
                        self.square.transform = transform
                        self.square.center.x = self.view.frame.width - self.view.layoutMargins.right - 0.5 * self.square.frame.size.width
                    }
                default:
                    break
                }
            }
    }
    
}
