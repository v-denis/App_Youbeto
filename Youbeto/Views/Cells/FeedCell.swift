//
//  FeedCell.swift
//  YouTube
//
//  Created by MacBook Air on 27.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

protocol VideoCellDidTappedProtocol: class {
	func videoCellDidTapped(onVideo video: Video)
}


class FeedCell: BaseCell {
	
	var delegate: ConfigureStatusBarProtocol?
	weak var openVideoDelegate: VideoCellDidTappedProtocol?
	var videos: [Video]?
	let videoCellId = "VideoCellId"
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .white
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
    
	override func setupLayout()
	{
		fetchVideos()
		addSubview(collectionView)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(VideoCell.self, forCellWithReuseIdentifier: videoCellId)
		
		NSLayoutConstraint.activate([
			collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
			collectionView.widthAnchor.constraint(equalTo: widthAnchor),
			collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
			collectionView.heightAnchor.constraint(equalTo: heightAnchor)
		])
	}
	
	public func fetchVideos()
	{
		ApiService.shared.fetchHomeVideos { (videos) in
			self.videos = videos
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
	
	
	
}


//MARK: collection view delegate and data source methods
extension FeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return videos?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellId, for: indexPath) as! VideoCell
		cell.video = videos?[indexPath.item]
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let height = (frame.width - 32) * 9 / 16 + 102
		return CGSize(width: frame.width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		let videoLauncher = VideoLauncher()
		videoLauncher.showBarDelegate = self
		videoLauncher.showVideoPlayer(withLink: "https://pvv4.vkuservideo.net/c505323/ecbOTUwNzI2MDU/videos/4cdd6ef2ca.720.mp4")
		if !Helper.hasTopNotch {
			delegate?.hideStatusBar()
		}
		
	}
	
	
}

//MARK: - ShowStatusBarProtocol
extension FeedCell: ShowStatusBarProtocol {
	func showStatusBar() {
		delegate?.showStatusBar()
	}
	
}
