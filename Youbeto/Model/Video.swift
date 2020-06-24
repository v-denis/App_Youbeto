//
//  Video.swift
//  YouTube
//
//  Created by MacBook Air on 23.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import Foundation


class Video: NSObject, Decodable {
	
	var title: String?
	var thumbnailImageName: String?
	var channel: Channel?
	var numberOfView: Int?
	var dateToPublish: Date?
	
	enum CodingKeys: String, CodingKey {
		case title
		case thumbnailImageURL = "thumbnail_image_name"
		case numberOfView = "number_of_views"
		case channel
		case channelName = "name"
		case channelProfileImageURL = "profile_image_name"
	}
	
	required init(from decoder: Decoder) throws
	{
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.title = try? container.decode(String.self, forKey: .title)
		self.numberOfView = try? container.decode(Int.self, forKey: .numberOfView)
		self.thumbnailImageName = try? container.decode(String.self, forKey: .thumbnailImageURL)
		self.channel = try? container.decode(Channel.self, forKey: .channel)
	}
	
}

class Channel: NSObject, Decodable {
	
	enum CodingKeys: String, CodingKey {
		case name
		case channelProfileImageURL = "profile_image_name"
	}
	
	var name: String?
	var profileImageName: String?
	var numberOfSubscribers: Int?
	
	var subscribersText: String {
		if var subscribers = numberOfSubscribers {
			var counter = 0
			var divider = 1
			var lastPost = ""
			let postFix = [3:"K",6:"M",9:"B",12:"T"]
			while subscribers > 0 {
				counter += 1
				subscribers /= 10
				if postFix[counter] != nil {
					lastPost = postFix[counter]!
					divider = Int(pow(10, Double(counter)))
				}
				
			}
			return "\((Double(numberOfSubscribers!)/Double(divider)))\(lastPost) subscribers"
		}
		return "No subscribers"
	}

	
	
	required init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try? container.decode(String.self, forKey: .name)
		self.profileImageName = try? container.decode(String.self, forKey: .channelProfileImageURL)
	}
	
	init(name: String, profileImageName: String, subscribers: Int) {
		self.name = name
		self.profileImageName = profileImageName
		self.numberOfSubscribers = subscribers
	}
	
	
}


