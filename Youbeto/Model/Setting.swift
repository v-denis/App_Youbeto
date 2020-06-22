//
//  Setting.swift
//  YouTube
//
//  Created by MacBook Air on 25.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import Foundation

struct Setting {
	
	enum SettingType: String {
		case settings = "Settings"
		case termsAndPrivacy = "Terms & Privace policy"
		case sendFeedBack = "Send Feedback"
		case help = "Help"
		case switchAccount = "Switch Account"
		case cancel = "Cancel"
	}
	
	let name: SettingType
	let imageName: String
	
	init(name: SettingType, imageName: String) {
		self.name = name
		self.imageName = imageName
	}
}

