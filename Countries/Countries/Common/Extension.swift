//
//  Extension.swift
//  Countries
//
//  Created by Juhi Gautam on 05/01/19.
//  Copyright © 2019 Juhi Gautam. All rights reserved.
//

import UIKit
import SVGKit

class Extension: NSObject {
}
extension UIImageView {
    func dowloadFromServer(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let anSVGImage: SVGKImage = SVGKImage(data: data),
                let image = anSVGImage.uiImage
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode)
    }
}

