//
//  SettingsCell.swift
//  YouTube
//
//  Created by MacBook Air on 25.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit


class SettingsCell: BaseCell {
	
	override var isHighlighted: Bool {
		didSet {
			backgroundColor = (isHighlighted) ? .darkGray : .clear
			settingLabel.textColor = (isHighlighted) ? .white : .black
			settingImageView.tintColor = (isHighlighted) ? .white : .darkGray
		}
	}
	
	var setting: Setting? {
		didSet {
			if let labelText = setting?.name.rawValue {
				settingLabel.text = labelText
			}
			if let settingImage = UIImage(systemName: setting?.imageName ?? "gear") {
				settingImageView.image = settingImage
			}
		}
	}
    
	let settingImageView: UIImageView = {
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFill
		iv.tintColor = .darkGray
		iv.image = UIImage(systemName: "gear")
		return iv
	}()
	
	let settingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Setting"
		label.textColor = .black
		label.font = UIFont.preferredFont(forTextStyle: .callout)
		return label
	}()
	
	override func setupLayout() {
		Helper.addViewsTo(superView: self, views: [settingImageView, settingLabel])
		
		NSLayoutConstraint.activate([
			settingImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			settingImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			settingImageView.trailingAnchor.constraint(equalTo: settingLabel.leadingAnchor, constant: -16),
			settingImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
			settingImageView.heightAnchor.constraint(equalTo: settingImageView.widthAnchor),
			
			settingLabel.heightAnchor.constraint(equalTo: heightAnchor),
			settingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			settingLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	
}
