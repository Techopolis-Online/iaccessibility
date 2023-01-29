//
//  imageLoader.swift
//  RSSReader
//
//  Created by Michael Doise on 12/22/20.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var dataIsValid = false
    var data:Data?

    init(url:URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
                self.data = data
            }
        }
        task.resume()
    }
}
