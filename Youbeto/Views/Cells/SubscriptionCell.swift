//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by MacBook Air on 27.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
	override func fetchVideos() {
		ApiService.shared.fetchSubscriptionVideos { (videos) in
			self.videos = videos
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
	
	
}
