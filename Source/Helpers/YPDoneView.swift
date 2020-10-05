//
//  YPDoneView.swift
//  YPImagePicker
//
//  Created by Andrii Novoselskyi on 05.10.2020.
//  Copyright © 2020 Yummypets. All rights reserved.
//

import UIKit

class YPDoneView: UIView {
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(imageFromBundle("yp_rounded_button"), for: .normal)
        button.setBackgroundImage(imageFromBundle("yp_rounded_button_pressed"), for: .highlighted)
        button.setBackgroundImage(imageFromBundle("yp_rounded_button_disabled"), for: .disabled)
        button.setTitle(YPConfig.wordings.done, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewImageView)
        addSubview(doneButton)
        
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        previewImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        previewImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        previewImageView.widthAnchor.constraint(equalTo: previewImageView.heightAnchor, multiplier: 1, constant: 0).isActive = true
        
        doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 121).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
