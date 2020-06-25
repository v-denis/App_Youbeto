//
//  VideoCell.swift
//  YouTube
//
//  Created by MacBook Air on 22.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit



class VideoCell: BaseCell {

	static let reuseId = String(describing: VideoCell.self)
	let numberFormatter = NumberFormatter()
	
	var video: Video? {
		didSet {
			thumbnailImageView.image = UIImage()
			profileImageView.image = UIImage()
			setThumbnailImage()
			setProfileImage()
			setTitlesText()
		}
	}
	
	var estimatedRect: CGRect?
	
	let separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
		return view
	}()
	
	let thumbnailImageView: CustomImageView = {
		let imageView = CustomImageView()
		imageView.clipsToBounds = true
		imageView.backgroundColor = .lightGray
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
	
	let subtitleTextView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.textColor = .darkGray
		textView.isEditable = false
		textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
		return textView
	}()
	var titleLabelHeightConstraint: NSLayoutConstraint?
	var heightConstraintOfBottomElements: NSLayoutConstraint?
	
	
	override func setupLayout() {
		addSubview(thumbnailImageView)
		addSubview(separatorView)
		addSubview(profileImageView)
		addSubview(titleLabel)
		addSubview(subtitleTextView)
		addConstraintsFromSuperview(for: thumbnailImageView, withLeft: 16, right: -16, top: 16, bottom: nil)
		addConstraintsFromSuperview(for: separatorView, withLeft: 0, right: 0, bottom: 0, andHeight: 1)
		
//		if let widthOfCell = cellWidth {
//			NSLayoutConstraint.activate([
//				thumbnailImageView.widthAnchor.constraint(lessThanOrEqualToConstant: widthOfCell - 32)
//			])
//		}
	
		NSLayoutConstraint.activate([
			profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
			profileImageView.heightAnchor.constraint(equalToConstant: 44),
			profileImageView.widthAnchor.constraint(equalToConstant: 44),
			profileImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 0),
			//			profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: subtitleTextView.topAnchor, constant: -4)
		])
		
		NSLayoutConstraint.activate([
			subtitleTextView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
			subtitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
			subtitleTextView.heightAnchor.constraint(equalToConstant: 30),
		])
		
		titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 20)
		titleLabelHeightConstraint?.isActive = true
		
		heightConstraintOfBottomElements = subtitleTextView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8)
		heightConstraintOfBottomElements?.isActive = true
	}
	
	private func setThumbnailImage() {
		if let thumbnailImagePath = video?.thumbnailImageName {
			thumbnailImageView.loadImageUsingUrlString(from: thumbnailImagePath)
		}
	}
	
	private func setProfileImage() {
		if let profileImagePath = video?.channel?.profileImageName {
			profileImageView.loadImageUsingUrlString(from: profileImagePath)
		}
	}
	
	private func setTitlesText() {
		if let title = video?.title { titleLabel.text = title }
		numberFormatter.numberStyle = .decimal
		if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViewsText {
			subtitleTextView.text = "\(channelName) • \(numberOfViews) views • 2 years ago"
		}
		//measure title lable text size
		if let title = video?.title {
			let size = CGSize(width: frame.width - 44 - 16 - 16 - 8, height: 300)
			let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
			estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)], context: nil)
			titleLabelHeightConstraint?.constant = (estimatedRect!.size.height >= 21) ? 41 : 20
			heightConstraintOfBottomElements?.constant = (estimatedRect!.size.height >= 21) ? -8 : -20
		}
	}
	
	
	
}

