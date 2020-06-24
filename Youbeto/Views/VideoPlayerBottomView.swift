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
		cv.backgroundColor = .white
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.delegate = self
		cv.dataSource = self
		cv.register(VideoDescriptionCell.self, forCellWithReuseIdentifier: VideoDescriptionCell.reuseId)
		cv.register(ChannelCell.self, forCellWithReuseIdentifier: ChannelCell.reuseId)
		cv.register(CommentsCell.self, forCellWithReuseIdentifier: CommentsCell.reuseId)
//		cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension VideoPlayerBottomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
//	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//		let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "header", for: indexPath)
//		header.backgroundColor = .red
//		header.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
//		return header
//	}
//
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//		return CGSize(width: frame.width, height: 200)
//	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		var cell: BaseCell?
		switch indexPath.row {
			case 0:
				cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoDescriptionCell.reuseId, for: indexPath) as! VideoDescriptionCell
				cell?.cellWidth = collectionView.frame.width
			case 1:
				cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCell.reuseId, for: indexPath) as! ChannelCell
				cell?.cellWidth = collectionView.frame.width
			default:
				cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentsCell.reuseId, for: indexPath) as! CommentsCell
				cell?.cellWidth = collectionView.frame.width
		}
		//Here transfer data to cell to show
		return cell ?? BaseCell()
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
