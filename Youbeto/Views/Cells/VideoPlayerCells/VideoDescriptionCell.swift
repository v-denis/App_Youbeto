//
//  VideoDescriptionCell.swift
//  Youbeto
//
//  Created by MacBook Air on 22.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class VideoDescriptionCell: BaseCell {
	
	static let reuseId = String(describing: VideoDescriptionCell.self)
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 2
		label.text = "Taylor Swift - I Knew You Were Trouble (Exclusive)"
		label.font = UIFont.preferredFont(forTextStyle: .title3)
		label.textColor = .black
		return label
	}()
	
	let subtitleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		label.text = "101M views • 2 months ago"
		label.font = UIFont.preferredFont(forTextStyle: .footnote)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .darkGray
		return label
	}()
	let thumbsUpView = ButtonWithLabelView(frame: .zero, labelText: "1,3M", buttonImageName: "hand.thumbsup.fill")
	let thumbsDownView = ButtonWithLabelView(frame: .zero, labelText: "354", buttonImageName: "hand.thumbsdown.fill")
	let shareView = ButtonWithLabelView(frame: .zero, labelText: "Share", buttonImageName: "arrowshape.turn.up.right.fill")
	let downloadView = ButtonWithLabelView(frame: .zero, labelText: "Download", buttonImageName: "arrow.down.circle.fill")
	let saveView = ButtonWithLabelView(frame: .zero, labelText: "Save", buttonImageName: "plus.rectangle.fill.on.rectangle.fill")
	let separatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
		return view
	}()
	
//	var cellWidth: CGFloat? {
//		didSet {
//			if let newCellWidth = cellWidth {
//				contentView.widthAnchor.constraint(equalToConstant: newCellWidth).isActive = true
//			}
//			
//		}
//	}
	
	override func setupLayout() {
		backgroundColor = .white
		
		addSubview(titleLabel)
		addSubview(subtitleLabel)
		addSubview(separatorView)
	
		let buttonsStackView = UIStackView(arrangedSubviews: [thumbsUpView, thumbsDownView, shareView, downloadView, saveView])
		buttonsStackView.alignment = .fill
		buttonsStackView.distribution = .fillEqually
		addSubview(buttonsStackView)
		buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
			contentView.topAnchor.constraint(equalTo: topAnchor),
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
			titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -30),
			subtitleLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20)
		])
		
		NSLayoutConstraint.activate([
			buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
			buttonsStackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
			buttonsStackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -12),
		])

		
		NSLayoutConstraint.activate([
			separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
			separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 1),
			separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
	}
	
	
    
}
