//
//  VideoPlayerBaseCell.swift
//  Youbeto
//
//  Created by MacBook Air on 24.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class VideoPlayerBaseCell: BaseCell {
	
	static var reuseId: String {
		return String(describing: Self.self)
	}
    
	override func setupLayout() {
		super.setupLayout()
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
			contentView.topAnchor.constraint(equalTo: topAnchor),
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
}
