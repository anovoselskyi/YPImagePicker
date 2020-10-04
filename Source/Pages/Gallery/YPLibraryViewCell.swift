//
//  YPLibraryViewCell.swift
//  YPImgePicker
//
//  Created by Sacha Durand Saint Omer on 2015/11/14.
//  Copyright © 2015 Yummypets. All rights reserved.
//

import UIKit
import Stevia

class YPMultipleSelectionIndicator: UIView {
    
    let circle = UIView()
    let label = UILabel()
    let selectionImageView = UIImageView()
    var selectionColor = UIColor.ypSystemBlue

    convenience init() {
        self.init(frame: .zero)
        
        let size: CGFloat = 20
        
        sv(
            circle,
            label,
            selectionImageView
        )
        
        circle.fillContainer()
        circle.size(size)
        label.fillContainer()
        
        circle.layer.cornerRadius = size / 2.0
        label.textAlignment = .center
        label.textColor = .white
        label.font = YPConfig.fonts.multipleSelectionIndicatorFont
        selectionImageView.isHidden = true
        
        set(number: nil)
    }
    
    func set(number: Int?) {
        label.isHidden = (number == nil)
        if let number = number {
            if let selectedIcon = YPConfig.icons.multipleSelectionSelectedIcon {
                selectionImageView.isHidden = false
                selectionImageView.image = selectedIcon
            } else {
                selectionImageView.isHidden = true
                circle.backgroundColor = selectionColor
                circle.layer.borderColor = UIColor.clear.cgColor
                circle.layer.borderWidth = 0
                label.text = "\(number)"
            }
        } else {
            if let unselectedIcon = YPConfig.icons.multipleSelectionUnselectedIcon {
                selectionImageView.isHidden = false
                selectionImageView.image = unselectedIcon
            } else {
                selectionImageView.isHidden = true
                circle.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                circle.layer.borderColor = UIColor.white.cgColor
                circle.layer.borderWidth = 1
                label.text = ""
            }
        }
    }
}

class YPLibraryViewCell: UICollectionViewCell {
    
    var representedAssetIdentifier: String!
    let imageView = UIImageView()
    let durationLabel = UILabel()
    let selectionOverlay = UIView()
    let multipleSelectionIndicator = YPMultipleSelectionIndicator()
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sv(
            imageView,
            durationLabel,
            selectionOverlay,
            multipleSelectionIndicator
        )

        imageView.fillContainer()
        selectionOverlay.fillContainer()
        layout(
            durationLabel-5-|,
            5
        )
        
        if let alignment = YPConfig.library.selectionIndicatorAlighnment {
            switch alignment {
            case .leftTop(let insets):
                layout(insets.top, |-insets.left-multipleSelectionIndicator)
            case .leftBottom(let insets):
                layout(|-insets.left-multipleSelectionIndicator, insets.bottom)
            case .rightTop(let insets):
                layout(insets.top, multipleSelectionIndicator-insets.right-|)
            case .rightBottom(let insets):
                layout(multipleSelectionIndicator-insets.right-|, insets.bottom)
            }
        } else {
            layout(
                3,
                multipleSelectionIndicator-3-|
            )
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        durationLabel.textColor = .white
        durationLabel.font = YPConfig.fonts.durationFont
        durationLabel.isHidden = true
        selectionOverlay.backgroundColor = .white
        selectionOverlay.alpha = 0
        backgroundColor = .ypSecondarySystemBackground
    }

    override var isSelected: Bool {
        didSet { refreshSelection() }
    }
    
    override var isHighlighted: Bool {
        didSet { refreshSelection() }
    }
    
    private func refreshSelection() {
        let showOverlay = isSelected || isHighlighted
        selectionOverlay.alpha = showOverlay ? 0.6 : 0
    }
}
