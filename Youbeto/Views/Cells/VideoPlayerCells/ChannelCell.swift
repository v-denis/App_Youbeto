//
//  ChannelCell.swift
//  Youbeto
//
//  Created by MacBook Air on 23.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class ChannelCell: BaseCell {
	
	static let reuseId = String(describing: ChannelCell.self)
	var channel: Channel? {
		didSet {
			if channel != nil {
				if let channelName = channel!.name {
					titleLabel.text = channelName
					subtitleLabel.text = channel!.subscribersText
				}
				if channel!.profileImageName != nil, let profileImage = UIImage(named: channel!.profileImageName!) {
					channelImageView.image = profileImage
				}
			}
			
		}
	}
	let channelImageView: CustomImageView = {
		let imageView = CustomImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 22
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.font = .preferredFont(forTextStyle: .title3)
		return label
	}()
	
	let subtitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .preferredFont(forTextStyle: .footnote)
		label.textColor = .darkGray
		label.numberOfLines = 1
		return label
	}()
	
	let subscribeButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("SUBSCRIBE", for: .normal)
		button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
		button.setTitleColor(.systemRed, for: .normal)
		return button
	}()
	
//	let subscribeButton: UILabel = {
//		let label = UILabel()
//		label.textColor = .systemRed
//		label.text = "SUBSCRIBE"
//		label.textAlignment = .right
//		label.font = .preferredFont(forTextStyle: .headline)
//		label.numberOfLines = 1
//		label.translatesAutoresizingMaskIntoConstraints = false
//		return label
//	}()
	let separatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
		return view
	}()
	
	override func setupLayout() {
		
		Helper.addViewsTo(superView: self, views: [channelImageView, titleLabel, subtitleLabel, subscribeButton, separatorView])
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
			contentView.topAnchor.constraint(equalTo: topAnchor),
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		
		NSLayoutConstraint.activate([
			channelImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			channelImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			channelImageView.heightAnchor.constraint(equalToConstant: 44),
			channelImageView.widthAnchor.constraint(equalToConstant: 44),
			channelImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			channelImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
			channelImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10)
		])
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: channelImageView.topAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 0)
		])
		
		NSLayoutConstraint.activate([
			subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			subtitleLabel.bottomAnchor.constraint(equalTo: channelImageView.bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			subscribeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			
		])
		
		NSLayoutConstraint.activate([
			separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
			separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			separatorView.widthAnchor.constraint(equalTo: widthAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 1)
		])
		
		channel = Channel(name: "Taylor Swift global",
						  profileImageName: "taylor_swift_profile_0",
						  subscribers: 1_400_000)
		
	}
}
