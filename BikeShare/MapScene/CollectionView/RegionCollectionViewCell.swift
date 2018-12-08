//
//  RegionCollectionViewCell.swift
//  BikeShare
//
//  Created by Daniel Slone on 12/2/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit

class RegionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var regionTitle: UILabel!

    var isLayoutCalculated = false

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.contentView.backgroundColor = UIColor.lightGray
            } else {
                self.contentView.backgroundColor = UIColor.white
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if !isLayoutCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width + 20)))
            layoutAttributes.frame = newFrame
            isLayoutCalculated = true
        }
        return layoutAttributes
    }
}
