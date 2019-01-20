//
//  ViewController.swift
//  CanvasDrawing
//
//  Created by SEAN on 2019/1/13.
//  Copyright © 2019 SEAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    let undoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Undo", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return btn
    }()
    
    let clearButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Clear", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return btn
    }()
    
    @objc private func handleUndo() {
        canvas.undo()
    }
    
    @objc private func handleClear() {
        canvas.clear()
    }
    
    override func loadView() {
        view = canvas
        canvas.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

