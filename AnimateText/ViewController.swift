//
//  ViewController.swift
//  AnimateText
//
//  Created by David Kadlček on 15/01/2019.
//  Copyright © 2019 David Kadlček. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont(name: ".SFUIText-Medium", size: 25)
        textView.contentMode = .center
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(handleAnimate))
    }
    
    @objc func handleAnimate() {
        let lines = textView.text.lines
        if lines.count > 1 {
            navigationController?.pushViewController(AnimateVC(texts: lines), animated: true)
        }
    }
    
    private func setupConstraints() {
        view.addSubview(textView)
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
    }


}

extension String {
    var lines: [String] {
        let withoutWhiteSpaces = self.trimmingCharacters(in: .whitespaces)
        return withoutWhiteSpaces.components(separatedBy: .newlines)
    }
}
