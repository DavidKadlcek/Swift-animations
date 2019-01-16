//
//  NumberCell.swift
//  AnimateText
//
//  Created by David Kadlček on 16/01/2019.
//  Copyright © 2019 David Kadlček. All rights reserved.
//

import UIKit

class NumberCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIText-Medium", size: 16)
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
