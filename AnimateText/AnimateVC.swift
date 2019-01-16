//
//  AnimateVC.swift
//  AnimateText
//
//  Created by David Kadlček on 15/01/2019.
//  Copyright © 2019 David Kadlček. All rights reserved.
//

import UIKit

class AnimateVC: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var animatingView: AnimatingView = {
        guard let textsV = texts else { return AnimatingView(texts: [""]) }
        let view = AnimatingView(texts: textsV)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 17/255, green: 30/255, blue: 108/255, alpha: 1)
        return view
    }()
    
    private let reuseIdentifier = "Cell"
    
    var texts: [String]?
    
    var animations: [() -> ()]?
    
    init(texts: [String]) {
        self.texts = texts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupCollectionView()
        animations = animatingView.getAnimations()
    }
    
    private func setupCollectionView() {
        collectionView.register(NumberCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(animatingView)
        animatingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        animatingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        animatingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        animatingView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        
    }
}

extension AnimateVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animations?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NumberCell
        cell?.label.text = String(indexPath.row + 1)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("CLICK")
        animations?[indexPath.row]()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
}
