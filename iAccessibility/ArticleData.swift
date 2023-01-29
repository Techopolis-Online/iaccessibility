//
//  ArticleData.swift
//  iAccessibility
//
//  Created by Michael Doise on 10/26/22.
//

import Foundation

struct Article: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String = ""
    var date: Date?
    var author: String?
    var img: URL?
    /// content in HTML
    var category: String? = ""
    var audioFile: URL?
    var content: String = ""
    var duration: String? = ""
    var itunesSummary: String? = ""
    var description: String? = ""
}
