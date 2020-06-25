//
//  RecommendedVideoHeaderView.swift
//  Youbeto
//
//  Created by MacBook Air on 25.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class RecommendedVideoHeaderView: UICollectionReusableView {
        
	static let reuseId = String(describing: RecommendedVideoHeaderView.self)
	
	let upNextLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Up next"
		label.textColor = #colorLiteral(red: 0.2186234185, green: 0.2186234185, blue: 0.2186234185, alpha: 1)
		return label
	}()
	let autoplayLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Autoplay"
		label.textColor = #colorLiteral(red: 0.2186234185, green: 0.2186234185, blue: 0.2186234185, alpha: 1)
		return label
	}()
	let autoplaySwitch: UISwitch = {
		let sw = UISwitch()
		sw.onTintColor = .systemRed
		sw.thumbTintColor = .white
		sw.tintColor = #colorLiteral(red: 0.6231136765, green: 0.6251240098, blue: 0.6311550096, alpha: 1)
		sw.translatesAutoresizingMaskIntoConstraints = false
		return sw
	}()
	
	func configure() {
		Helper.addViewsTo(superView: self, views: [upNextLabel, autoplayLabel, autoplaySwitch])
		
		NSLayoutConstraint.activate([
			upNextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			upNextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			upNextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
			upNextLabel.heightAnchor.constraint(equalToConstant: 20)
		])
		
		NSLayoutConstraint.activate([
			autoplaySwitch.centerYAnchor.constraint(equalTo: upNextLabel.centerYAnchor),
			autoplaySwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			autoplaySwitch.leadingAnchor.constraint(equalTo: autoplayLabel.trailingAnchor, constant: 16),
			autoplayLabel.centerYAnchor.constraint(equalTo: upNextLabel.centerYAnchor),
			
		])
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		backgroundColor = .white
		print(upNextLabel.frame)
	}
	
}
