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
//		cv.contentInsetAdjustmentBehavior = .always
		cv.showsVerticalScrollIndicator = false
		cv.backgroundColor = .white
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.delegate = self
		cv.dataSource = self
		cv.register(VideoDescriptionCell.self, forCellWithReuseIdentifier: VideoDescriptionCell.reuseId)
		cv.register(ChannelCell.self, forCellWithReuseIdentifier: ChannelCell.reuseId)
		cv.register(CommentsCell.self, forCellWithReuseIdentifier: CommentsCell.reuseId)
		cv.register(RecommendedVideoCell.self, forCellWithReuseIdentifier: RecommendedVideoCell.reuseId)
		cv.register(RecommendedVideoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendedVideoHeaderView.reuseId)
		return cv
	}()
	var video: Video?
	var recommendedVideos: [Video]?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(bottomCollectionView)
		NSLayoutConstraint.activate([
			bottomCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
			bottomCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
			bottomCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
			bottomCollectionView.heightAnchor.constraint(equalTo: heightAnchor)
		])
		fetchRecommendedVideos()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		print("PlayerBottomView deinited!!!")
	}
	
	private func fetchRecommendedVideos() {
		ApiService.shared.fetchSubscriptionVideos { (videos) in
			self.recommendedVideos = videos
			DispatchQueue.main.async {
				self.bottomCollectionView.reloadData()
			}
		}
	}
	
	
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension VideoPlayerBottomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 1 {
			return 3
		} else {
			return recommendedVideos?.count ?? 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendedVideoHeaderView.reuseId, for: indexPath) as! RecommendedVideoHeaderView
		header.configure()
		return header
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		if section == 1 {
			return CGSize(width: frame.width, height: 44)
		}
		return CGSize.zero
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		//Here transfer data to cell to show
		if indexPath.section == 0 {
			var cellIdentifier: String
			switch indexPath.item {
				case 0: cellIdentifier = VideoDescriptionCell.reuseId
				case 1:	cellIdentifier = ChannelCell.reuseId
				case 2: cellIdentifier = CommentsCell.reuseId
				default: cellIdentifier = ""
			}
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! VideoPlayerBaseCell
			cell.cellWidth = collectionView.frame.width
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedVideoCell.reuseId, for: indexPath) as! RecommendedVideoCell
			cell.cellWidth = collectionView.frame.width
			cell.layoutSubviews()
			cell.video = recommendedVideos?[indexPath.row]
			return cell
		}
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
}
