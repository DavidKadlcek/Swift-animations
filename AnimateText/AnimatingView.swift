//
//  AnimatingView.swift
//  AnimateText
//
//  Created by David Kadlček on 15/01/2019.
//  Copyright © 2019 David Kadlček. All rights reserved.
//

import UIKit

class AnimatingView: UIView {
    
    private var texts = [String]()
    
    private var variableLabels = [UILabel]()
    
    private var constraintsUpBy: CGFloat = 10
    
    private var animator: UIViewPropertyAnimator?
    
    init(texts: [String]) {
        self.texts = texts
        super.init(frame: .zero)
        loadToLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAnimations() -> [() -> ()] {
        var animations: [() -> ()] = []
        animations.append(animateFirstView)
        animations.append(animateSecondView)
        print(animations)
        return animations
    }
    
    private func loadToLabels() {
        for text in texts {
            let label = getLabel(text: text)
            variableLabels.append(label)
        }
    }
    
    private var lastLabelBottom = UILabel()
    
    private var xPosition = CGFloat()
    
    
    private func animateFirstView() {
        lastLabelBottom = UILabel()
        xPosition = CGFloat()

        removeAllSubviews()
        
        for (index, label) in variableLabels.enumerated() {
            label.alpha = 0
            
            addSubview(label)
            
            if index == 0 {
                label.topAnchor.constraint(equalTo: topAnchor, constant: constraintsUpBy + 30).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: lastLabelBottom.bottomAnchor, constant: constraintsUpBy - 3).isActive = true
            }
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            label.sizeToFit()
            lastLabelBottom = label
            
            if label.frame.maxX > xPosition {
                xPosition = label.frame.maxX
            }
            // Animate
            animateLabel(index: Double(index), label: label)
            
            if index == variableLabels.count - 1 {
                print(xPosition, "X POSITI")
                createByType(maxPosition: xPosition, types: [.bottomLeft, .topRight])
            }
            
        }
    }
    
    private func animateSecondView() {
        lastLabelBottom = UILabel()
        xPosition = CGFloat()
        
        removeAllSubviews()
        for (index, label) in variableLabels.enumerated() {
            label.alpha = 0
            label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
            addSubview(label)
            
            if index == 0 {
                label.topAnchor.constraint(equalTo: topAnchor, constant: 50 - constraintsUpBy - 30).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: lastLabelBottom.bottomAnchor, constant: -constraintsUpBy + 5).isActive = true
            }
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            label.sizeToFit()
            lastLabelBottom = label
            
            if label.frame.maxX > xPosition {
                xPosition = label.frame.maxX
            }
            
            animateSecondLabel(index: Double(index), label: label)
        }
        
        animateSecondViewView(view: viewCreateSecondViewView())
        
        
    }
    
    private func viewCreateSecondViewView() -> UIView {
        let whiteView = UIView()
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.layer.cornerRadius = 8
        whiteView.backgroundColor = .white
        whiteView.alpha = 0
        whiteView.transform = CGAffineTransform(scaleX: 0, y: 1)
        
        addSubview(whiteView)
        whiteView.topAnchor.constraint(equalTo: lastLabelBottom.bottomAnchor, constant: 5).isActive = true
        whiteView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        whiteView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        whiteView.widthAnchor.constraint(equalToConstant: xPosition).isActive = true
        
        return whiteView
    }
    
    func createByType(maxPosition: CGFloat, types: [TypeOfCorner]) {
        for type in types {
            var imageView = UIImageView()
            switch type {
            case .bottomLeft:
                imageView = createCorner(type: .bottomLeft)
                addSubview(imageView)
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -(maxPosition)).isActive = true
                imageView.centerYAnchor.constraint(equalTo: lastLabelBottom.centerYAnchor, constant: -5).isActive = true
            case .bottomRight:
                imageView = createCorner(type: .bottomRight)
                addSubview(imageView)
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: (maxPosition)).isActive = true
                imageView.centerYAnchor.constraint(equalTo: lastLabelBottom.centerYAnchor, constant: -5).isActive = true
            case .topLeft:
                imageView = createCorner(type: .topLeft)
                addSubview(imageView)
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -(maxPosition)).isActive = true
                imageView.centerYAnchor.constraint(equalTo: variableLabels[0].centerYAnchor, constant: -5).isActive = true
            case .topRight:
                imageView = createCorner(type: .topRight)
                addSubview(imageView)
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: (maxPosition)).isActive = true
                imageView.centerYAnchor.constraint(equalTo: variableLabels[0].centerYAnchor, constant: -5).isActive = true
            }
            
            animateCorners(imageView: imageView, type: type)
        }
    }
    
    private func createCorner(type: TypeOfCorner) -> UIImageView {
        let height = 50
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        switch type {
        case .bottomLeft:
            bezierPath.addLine(to: CGPoint(x: 0, y: -height))
            bezierPath.addLine(to: .zero)
            bezierPath.addLine(to: CGPoint(x: height, y: 0))
        case .bottomRight:
            bezierPath.addLine(to: CGPoint(x: 0, y: -height))
            bezierPath.addLine(to: .zero)
            bezierPath.addLine(to: CGPoint(x: -height, y: 0))
        case .topLeft:
            bezierPath.addLine(to: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: .zero)
            bezierPath.addLine(to: CGPoint(x: height, y: 0))
        case .topRight:
            bezierPath.addLine(to: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: .zero)
            bezierPath.addLine(to: CGPoint(x: -height, y: 0))
        }
        let image = UIImage.shapeImageWithBezierPath(bezierPath: bezierPath, fillColor: .orange, strokeColor: .orange, strokeWidth: 13, size: CGSize(width: height, height: height))
        guard let img = image else { return UIImageView() }

        let imageView = UIImageView(image: img)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    private func animateLabel(index: Double, label: UILabel) {
        let delay = 0.3 * index
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: delay, options: .curveEaseOut, animations: {
            label.transform = CGAffineTransform(translationX: 0, y: -(self.constraintsUpBy))
            label.alpha = 1
        })
        animator?.startAnimation()
        
    }
    
    private func animateSecondLabel(index: Double, label: UILabel) {
        let delay = 0.4 + 0.3 * index
        print("HMMa")
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: delay, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: 0, y: (self.constraintsUpBy) + 90)
            label.transform = CGAffineTransform(scaleX: 1, y: 1)
            label.alpha = 1
        })
        animator?.startAnimation()
    }
    
    private func animateSecondViewView(view: UIView) {
        UIView.animate(withDuration: 0.8) {
            view.alpha = 1
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    private func animateCorners(imageView: UIImageView, type: TypeOfCorner) {
        UIView.animate(withDuration: 0.5) {
            imageView.alpha = 1
            let xPosPositive = self.xPosition / 2 + imageView.frame.width / 2 - 13
            let xPostNegative = -(self.xPosition / 2 - imageView.frame.width / 2 + 13)
            switch type {
            case .bottomLeft:
                imageView.transform = CGAffineTransform(translationX: xPosPositive, y: 0)
            case .bottomRight:
                imageView.transform = CGAffineTransform(translationX: xPostNegative, y: 0)
            case .topLeft:
                imageView.transform = CGAffineTransform(translationX: xPosPositive, y: 0)
            case .topRight:
                imageView.transform = CGAffineTransform(translationX: xPostNegative, y: 0)
            }
        }
    }
    
    private func getLabel(text: String) -> UILabel {
        let color = variableLabels.count % 2 == 0 ? UIColor.white : UIColor.red
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIText-Bold", size: 25)
        label.textColor = color
        label.text = text.uppercased()
        return label
    }
    
    private func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}

extension UIImage {
    class func shapeImageWithBezierPath(bezierPath: UIBezierPath, fillColor: UIColor?, strokeColor: UIColor?, strokeWidth: CGFloat = 0.0, size: CGSize) -> UIImage! {
        bezierPath.apply(CGAffineTransform(translationX: -bezierPath.bounds.origin.x, y: -bezierPath.bounds.origin.y ) )
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        var image = UIImage()
        if let context  = context {
            context.saveGState()
            context.addPath(bezierPath.cgPath)
            if strokeColor != nil {
                strokeColor!.setStroke()
                context.setLineWidth(strokeWidth)
            } else { UIColor.clear.setStroke() }
            fillColor?.setFill()
            context.drawPath(using: .fillStroke)
            image = UIGraphicsGetImageFromCurrentImageContext()!
            context.restoreGState()
            UIGraphicsEndImageContext()
        }
        return image
    }
}
