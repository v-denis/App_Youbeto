//
//  File.swift
//  YouTube
//
//  Created by MacBook Air on 23.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class MenuBarCell: BaseCell {
	
	let buttonImageView: UIImageView = {
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.tintColor = #colorLiteral(red: 0.3568627451, green: 0.05490196078, blue: 0.05098039216, alpha: 1)
		iv.image = UIImage(systemName: "house.fill")
		return iv
	}()
	
	override var isHighlighted: Bool { didSet { setupImageViewTintColor(for: isHighlighted) } }
	override var isSelected: Bool { didSet { setupImageViewTintColor(for: isSelected) } }
	
	override func setupLayout() {
		addSubview(buttonImageView)
		NSLayoutConstraint.activate([
			buttonImageView.widthAnchor.constraint(equalToConstant: 28),
			buttonImageView.heightAnchor.constraint(equalToConstant: 28),
			buttonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			buttonImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
	
	private func setupImageViewTintColor(for state: Bool) {
		buttonImageView.tintColor = state ? .white : #colorLiteral(red: 0.3568627451, green: 0.05490196078, blue: 0.05098039216, alpha: 1)
	}
}
