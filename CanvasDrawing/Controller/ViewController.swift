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
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 10
        slider.minimumValue = 1
        slider.addTarget(self, action: #selector(handleChangeWidth), for: .valueChanged)
        return slider
    }()
    
    @objc private func handleChangeColor(button: UIButton) {
        canvas.changeStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    @objc private func handleChangeWidth(){
        canvas.changeStrokeWidth(value: CGFloat(slider.value))
    }
    
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
        let colorStackView = UIStackView(arrangedSubviews: [getColorButton(color: .yellow), getColorButton(color: .red), getColorButton(color: .blue)])
        colorStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton, colorStackView, slider])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func getColorButton(color: UIColor) -> UIButton{
        let colorButton: UIButton = {
            let btn = UIButton(type: .system)
            btn.backgroundColor = color
            btn.layer.borderWidth = 1
            btn.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
            return btn
        }()
        return colorButton
    }
}

