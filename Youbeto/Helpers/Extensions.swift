//
//  Extensions.swift
//  YouTube
//
//  Created by MacBook Air on 22.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit
import AVFoundation


extension UIView {
	
	func addConstraintsFromSuperview(for view: UIView, withLeft left: CGFloat, right: CGFloat, top: CGFloat? = nil, bottom: CGFloat? = nil, andHeight height: CGFloat? = nil) {
		view.translatesAutoresizingMaskIntoConstraints = false
		view.leftAnchor.constraint(equalTo: leftAnchor, constant: left).isActive = true
		view.rightAnchor.constraint(equalTo: rightAnchor, constant: right).isActive = true
		if top != nil { view.topAnchor.constraint(equalTo: topAnchor, constant: top!).isActive = true }
		if bottom != nil { view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom!).isActive = true }
		if height != nil { view.heightAnchor.constraint(equalToConstant: height!).isActive = true }
	}
}


class CustomImageView: UIImageView, NSCacheDelegate {
	
	var imageUrlString: String?
	let imageCache: NSCache<NSString,UIImage> = {
		let cache = NSCache<NSString,UIImage>()
		cache.evictsObjectsWithDiscardedContent = false
		return cache
	}()

	
	func loadImageUsingUrlString(from urlString: String) {
		
		imageUrlString = urlString
		
		if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
			self.image = imageFromCache
			return
		} else {
			guard let url = URL(string: urlString) else { return }
			URLSession.shared.dataTask(with: url) { (data, response, error) in
				if error != nil {
					print(error!)
					return
				}
				DispatchQueue.main.async {
					guard let imageData = data, let fetchedImage = UIImage(data: imageData) else { return }
					if self.imageUrlString == urlString {
						self.image = fetchedImage
						self.imageCache.setObject(fetchedImage, forKey: NSString(string: urlString))
					}
				}
			}.resume()
		}
		
	}
	
	
}



extension CMTime {
	
	///format of srting will be "01:24"
	func getStringOfSecondsAndMinutes() -> String {
		let seconds = CMTimeGetSeconds(self)
		let secondsText = String(format: "%02d", Int(seconds) % 60)
		let minutesText = String(format: "%02d", Int(seconds) / 60)
		return "\(minutesText):\(secondsText)"
	}
}
