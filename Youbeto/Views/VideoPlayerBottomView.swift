//
//  PlayerView.swift
//  Youbeto
//
//  Created by MacBook Air on 22.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class VideoPlayerBottomView: UIView {
	
	lazy var bottomCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		cv.showsVerticalScrollIndicator = false
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.backgroundColor = .lightGray
		cv.delegate = self
		cv.dataSource = self
		cv.register(VideoDescriptionCell.self, forCellWithReuseIdentifier: "bottomVideoCell")
		return cv
	}()
	var video: Video?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(bottomCollectionView)
		NSLayoutConstraint.activate([
			bottomCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
			bottomCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
			bottomCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
			bottomCollectionView.heightAnchor.constraint(equalTo: heightAnchor)
		])
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		print("PlayerBottomView deinited!!!")
	}
}


extension VideoPlayerBottomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomVideoCell", for: indexPath) as! VideoDescriptionCell
		cell.cellWidth = collectionView.frame.width
		cell.titleLabel.text = "Taylor Swift - I Knew You Were Trouble (Exclusive)"
		cell.subtitleLabel.text = "101 million views • 2 months ago"
		return cell
	}
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		if let cell = collectionView.cellForItem(at: indexPath) as? VideoDescriptionCell {
//			print("collectionViewLayout", cell.cellHeight)
//		}
//
//		return CGSize(width: frame.width, height: 80)
//	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
}
