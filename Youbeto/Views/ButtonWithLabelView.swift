//
//  ButtonWithLabelView.swift
//  Youbeto
//
//  Created by MacBook Air on 23.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class ButtonWithLabelView: UIView {

	var mainButton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = .darkGray
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	var bottomLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .darkGray
		label.numberOfLines = 1
		label.font = UIFont.preferredFont(forTextStyle: .footnote)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	init(frame: CGRect, labelText: String, buttonImageName: String) {
		super.init(frame: frame)
		setupLayout()
		bottomLabel.text = labelText
		mainButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
	}
	
	private func setupLayout() {
		addSubview(mainButton)
		addSubview(bottomLabel)
		
		NSLayoutConstraint.activate([
			mainButton.topAnchor.constraint(equalTo: topAnchor),
			mainButton.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -8),
//			mainButton.widthAnchor.constraint(equalTo: mainButton.heightAnchor),
			mainButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainButton.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
		
		NSLayoutConstraint.activate([
			bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//			bottomLabel.heightAnchor.constraint(equalToConstant: 25),
			bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
