//
//  ApiService.swift
//  YouTube
//
//  Created by MacBook Air on 26.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class ApiService: NSObject {

	static let shared = ApiService()
	let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets"
	
	
	func fetchVideos(forChapter chapter: String, completion: @escaping ([Video]) -> ()) {
		
		guard let url = URL(string: "\(baseURL)/\(chapter).json") else { return }
		URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
			if error != nil {
				print(error!.localizedDescription)
				return
			}
			guard let httpResponse = response as? HTTPURLResponse else { return }
			guard (200...299).contains(httpResponse.statusCode) || httpResponse.statusCode == 304 else { return }
			guard let jsonData = data else { return }
			do {
				let videos = try JSONDecoder().decode([Video].self, from: jsonData)
				completion(videos)
			} catch let jsonError {
				print("JSON decode error: ", jsonError)
			}
		}).resume()
	}
	
	func fetchHomeVideos(completion: @escaping ([Video]) -> ()) {
		fetchVideos(forChapter: "home_num_likes", completion: completion)
	}
	
	func fetchTrendingVideos(completion: @escaping ([Video]) -> ()) {
		fetchVideos(forChapter: "trending", completion: completion)
	}
	
	func fetchSubscriptionVideos(completion: @escaping ([Video]) -> ()) {
		fetchVideos(forChapter: "subscriptions", completion: completion)
	}
	
	func fetchImage(fromUrlString urlString: String, completion: @escaping (UIImage) -> ())  {
		
		guard let url = URL(string: urlString) else { return }
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error != nil {
				print(error!)
				return
			}
			guard let imageData = data, let fetchedImage = UIImage(data: imageData) else { return }
			completion(fetchedImage)
		}.resume()
		return
	}
	
	
	
}
