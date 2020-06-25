//
//  RecommendedVideosCell.swift
//  Youbeto
//
//  Created by MacBook Air on 24.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class RecommendedVideoCell: VideoPlayerBaseCell {
	
	var video: Video? {
		didSet {
			thumbnailImageView.image = UIImage()
			profileImageView.image = UIImage()
			setThumbnailImage()
			setProfileImage()
			setTitlesText()
		}
	}
	let activityIndicator: UIActivityIndicatorView = {
		let ai = UIActivityIndicatorView(style: .large)
		ai.tintColor = .label
		ai.hidesWhenStopped = true
		ai.startAnimating()
		return ai
	}()
	let thumbnailImageView: CustomImageView = {
		let imageView = CustomImageView()
		imageView.clipsToBounds = true
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage()
		return imageView
	}()
	
	let profileImageView: CustomImageView = {
		let imageView = CustomImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 22
		imageView.layer.masksToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage()
		return imageView
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 2
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
	
	override func layoutSubviews() {
		super.layoutSubviews()
		thumbnailImageView.addSubview(activityIndicator)
		activityIndicator.frame = thumbnailImageView.bounds
		activityIndicator.center = thumbnailImageView.center
	}
	
	
	override func setupLayout() {
		super.setupLayout()
		Helper.addViewsTo(superView: self, views: [thumbnailImageView, profileImageView, titleLabel, subtitleLabel])

		NSLayoutConstraint.activate([
			thumbnailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			thumbnailImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
			thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 9 / 16),
			thumbnailImageView.bottomAnchor.constraint(equalTo: profileImageView.topAnchor, constant: -16),
		])
		
		NSLayoutConstraint.activate([
			profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			profileImageView.heightAnchor.constraint(equalToConstant: 44),
			profileImageView.widthAnchor.constraint(equalToConstant: 44),
			profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 16),
			profileImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
			profileImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10),
			profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -5)
		])
		
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 16), //
			titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 0), //
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -5) //
		])
		
		subtitleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
		titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
		
	}
	
	private func setThumbnailImage() {
		if let thumbnailImagePath = video?.thumbnailImageName {
			thumbnailImageView.loadImageUsingUrlString(from: thumbnailImagePath)
		}
	}
	
	private func setProfileImage() {
		if let profileImagePath = video?.channel?.profileImageName {
			profileImageView.loadImageUsingUrlString(from: profileImagePath) { [weak self] in
				self?.activityIndicator.stopAnimating()
			}
		}
	}
	
	//FIXME: Fake data here
	private func setTitlesText() {
		if let cellVideo = video {
			let channel = cellVideo.channel?.name
			let views = cellVideo.numberOfViewsText
//			let dateFromPublish = cellVideo.dateToPublish
			titleLabel.text = cellVideo.title
			subtitleLabel.text = "\(channel ?? "The best channel") • \(views) • \("1 month ago")"
			
		}
		
		
	}
	
}
