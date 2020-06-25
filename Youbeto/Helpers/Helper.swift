//
//  Helper.swift
//  YouTube
//
//  Created by MacBook Air on 25.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class Helper {
	
	static var hasTopNotch: Bool {
		return (Helper.keyWindow?.safeAreaInsets.bottom ?? 0) > 0
	}
	
	static let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
	
	static func tamicOff(for views: [UIView]) {
		for view in views {
			view.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	static func addViewsTo(superView: UIView, views: [UIView]) {
		for view in views {
			superView.addSubview(view)
		}
	}
	
	static func fetchImage(from stringURL: String) -> UIImage? {
		guard let url = URL(string: stringURL) else { return nil }
		guard let imageData = try? Data(contentsOf: url) else { return nil }
		return UIImage(data: imageData)
	}
	
}

