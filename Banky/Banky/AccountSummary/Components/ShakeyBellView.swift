//
//  ShakeyBellView.swift
//  Banky
//
//  Created by Mohamed Elatabany on 19/03/2022.
//


import UIKit
class ShakeyBellView: UIView {
    
    
    let imageView = UIImageView()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    
}


extension ShakeyBellView {
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        addSubview(imageView)
    }
    
    
    private func layout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0)
        ])
    }
    
    private func setup() {
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTapped))
        imageView.addGestureRecognizer(tapGesture)
    }
    
}



//MARK: - Actions
extension ShakeyBellView {
    
    @objc
    func imageDidTapped() {
        animate()
    }
    
    
    
    func animate() {
        
        shakeWith(duration: 4, angle: Double.pi / 8.0, yOffset: 1)
    }
    
}

extension ShakeyBellView {
    
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [],
                                animations: {
            
            for i in 0..<Int(numberOfFrames) - 1 {
                UIView.addKeyframe(withRelativeStartTime: Double(i)*frameDuration,
                                   relativeDuration: frameDuration) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: (i%2 == 0) ? -angle : +angle)
                }
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }, completion: nil)
    }
}

// https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}


