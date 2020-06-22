//
//  BaseCell.swift
//  YouTube
//
//  Created by MacBook Air on 23.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	func setupLayout() {
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
