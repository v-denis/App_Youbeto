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
	
	var name: String?
	var profileImageName: String?
	
	enum CodingKeys: String, CodingKey {
		case name
		case channelProfileImageURL = "profile_image_name"
	}
	
	
	required init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try? container.decode(String.self, forKey: .name)
		self.profileImageName = try? container.decode(String.self, forKey: .channelProfileImageURL)
	}
	
	
}


