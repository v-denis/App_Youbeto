//
//  CommentsCell.swift
//  Youbeto
//
//  Created by MacBook Air on 23.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class CommentsCell: BaseCell {
    
	static let reuseId = String(describing: CommentsCell.self)
	let commentsLabel: UILabel = {
		let label = UILabel()
		label.text = "Comments"
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .preferredFont(forTextStyle: .body)
		label.textColor = .black
		return label
	}()
	let numberOfCommentsLabel: UILabel = {
		let label = UILabel()
		label.text = "38"
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .preferredFont(forTextStyle: .body)
		label.textColor = .darkGray
		return label
	}()
	let bestCommentImageView: UIImageView = {
		let iv = UIImageView()
		iv.layer.cornerRadius = 15
		iv.layer.masksToBounds = true
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFill
		iv.image = #imageLiteral(resourceName: "anonimlogoyoutube")
		return iv
	}()
	let bestCommentTextLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.text = "This is the best video I've ever seen!"
		label.font = .preferredFont(forTextStyle: .subheadline)
		label.textColor = .black
		return label
	}()
	let unwrapCommentsButton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = .lightGray
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
		return button
	}()
	let separatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
		return view
	}()
	
	override func setupLayout() {
		Helper.addViewsTo(superView: self, views: [commentsLabel, numberOfCommentsLabel, bestCommentImageView, bestCommentTextLabel, unwrapCommentsButton, separatorView])
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
			contentView.topAnchor.constraint(equalTo: topAnchor),
			contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
		
		NSLayoutConstraint.activate([
			commentsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			commentsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			commentsLabel.bottomAnchor.constraint(equalTo: bestCommentImageView.topAnchor, constant: -16),
			commentsLabel.trailingAnchor.constraint(equalTo: numberOfCommentsLabel.leadingAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			numberOfCommentsLabel.centerYAnchor.constraint(equalTo: commentsLabel.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			bestCommentImageView.leadingAnchor.constraint(equalTo: commentsLabel.leadingAnchor),
			bestCommentImageView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -16),
			bestCommentImageView.widthAnchor.constraint(equalToConstant: 30),
			bestCommentImageView.heightAnchor.constraint(equalToConstant: 30),
			bestCommentImageView.trailingAnchor.constraint(equalTo: bestCommentTextLabel.leadingAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			bestCommentTextLabel.centerYAnchor.constraint(equalTo: bestCommentImageView.centerYAnchor),
			bestCommentTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
		])
		
		NSLayoutConstraint.activate([
			unwrapCommentsButton.centerYAnchor.constraint(equalTo: numberOfCommentsLabel.centerYAnchor),
			unwrapCommentsButton.topAnchor.constraint(equalTo: topAnchor),
			unwrapCommentsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
			separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			separatorView.widthAnchor.constraint(equalTo: widthAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 1)
		])
		
	}
}
