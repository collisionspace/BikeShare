//
//  RegionCollectionView.swift
//  BikeShare
//
//  Created by Daniel Slone on 12/3/18.
//  Copyright © 2018 Daniel Slone. All rights reserved.
//

import UIKit

protocol RegionCollectionDelegate: class {
    func didSelect(region: String)
}
class RegionCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    weak var regionCollectionDelegate: RegionCollectionDelegate?

    private var regions = [String]()

    init(regions: [String], frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        self.regions = regions
        super.init(frame: frame, collectionViewLayout: layout)
        dataSource = self
        delegate = self
        register(UINib(nibName: "RegionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Region")
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            self.heightAnchor.constraint(equalToConstant: 35).isActive = true
        } else {
            NSLayoutConstraint(item: self,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: view, attribute: .top,
                               multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self,
                               attribute: .leading,
                               relatedBy: .equal, toItem: view,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0).isActive = true
            NSLayoutConstraint(item: self, attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0).isActive = true
            
            self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Region", for: indexPath) as! RegionCollectionViewCell
        myCell.regionTitle.text = regions[indexPath.row]
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        regionCollectionDelegate?.didSelect(region: regions[indexPath.row])
    }
}
