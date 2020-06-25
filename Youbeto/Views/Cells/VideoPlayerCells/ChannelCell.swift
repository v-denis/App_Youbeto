//
//  ChannelCell.swift
//  Youbeto
//
//  Created by MacBook Air on 23.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class ChannelCell: VideoPlayerBaseCell {
	
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
		label.numberOfLines = 2
		label.font = .preferredFont(forTextStyle: .body)
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
	
	let separatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
		return view
	}()
	
	override func setupLayout() {
		super.setupLayout()
		
		Helper.addViewsTo(superView: self, views: [channelImageView, titleLabel, subtitleLabel, subscribeButton, separatorView])
		
		NSLayoutConstraint.activate([
			channelImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			channelImageView.heightAnchor.constraint(equalToConstant: 44),
			channelImageView.widthAnchor.constraint(equalToConstant: 44),
			channelImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
			channelImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10),
			channelImageView.bottomAnchor.constraint(lessThanOrEqualTo: separatorView.topAnchor, constant: -16)
		])
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 0),
			titleLabel.trailingAnchor.constraint(equalTo: subscribeButton.leadingAnchor, constant: -12),
			subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: separatorView.topAnchor, constant: -16),
		])
		
		subtitleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
		titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
		
		NSLayoutConstraint.activate([
			subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
			subscribeButton.centerYAnchor.constraint(equalTo: channelImageView.centerYAnchor)
		])
		
		subscribeButton.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
		
		NSLayoutConstraint.activate([
			separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
			separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			separatorView.widthAnchor.constraint(equalTo: widthAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 1)
		])
		
		channel = Channel(name: "Taylor Swift global Taylor Swift global Taylor Swift global Taylor Swift global",
						  profileImageName: "taylor_swift_profile_0",
						  subscribers: 1_400_000)
		
	}
}
