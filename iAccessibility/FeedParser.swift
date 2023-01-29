//
//  FeedParser.swift
//  iAccessibility
//
//  Created by Michael Doise on 10/26/22.
//

import Foundation

class FeedParser: XMLParser {
    
    var articles: [Article] = []
    
    var dateTimeZone = TimeZone(abbreviation: "GMT-6")
    lazy var dateFormater: DateFormatter = {
        let df = DateFormatter()
        //Please set up this DateFormatter for the entry `date`
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "MMM dd, yyyy"
        df.timeZone = dateTimeZone
        return df
    }()
    
    private var textBuffer: String = ""
    private var nextArticle: Article? = nil
    
    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
}
extension FeedParser: XMLParserDelegate {
    // Called when opening tag (`<elementName>`) is found
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "item":
            nextArticle = Article()
        case "title":
            textBuffer = ""
        case "pubDate":
            textBuffer = ""
        case "author":
            textBuffer = ""
        case "image":
            textBuffer = ""
        case "content:encoded":
            textBuffer = ""
        case "category":
            textBuffer = ""
        case "enclosure":
            if attributeDict["url"] != "" {
                textBuffer = ""
                textBuffer = attributeDict["url"] ?? ""
                nextArticle?.audioFile = URL(string: textBuffer)
            }
        case "itunes:duration":
            textBuffer = ""
        case "itunes:summary":
            textBuffer = ""
        case "description":
            textBuffer = ""
        default:
            print("Ignoring \(elementName)")
            break
        }
    }
    
    // Called when closing tag (`</elementName>`) is found
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "item":
            if let article = nextArticle {
                articles.append(article)
            }
        case "title":
            nextArticle?.title = textBuffer
        case "pubDate":
            print("pubDate: \(textBuffer)")
            nextArticle?.date = dateFormater.date(from: textBuffer)
        case "author":
            nextArticle?.author = textBuffer
        case "image":
            print("Image: \(textBuffer)")
            nextArticle?.img = URL(string: textBuffer)
        case "content:encoded":
            nextArticle?.content = textBuffer
        case "category":
            nextArticle?.category = textBuffer
        case "itunes:duration":
            nextArticle?.duration = textBuffer
        case "itunes:summary":
            nextArticle?.itunesSummary = textBuffer
        case "description":
            nextArticle?.description = textBuffer
        default:
            print("Ignoring \(elementName)")
            break
        }
    }
    // Called when a character sequence is found
    // This may be called multiple times in a single element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        textBuffer += string
        print(textBuffer)
    }
    // Called when a CDATA block is found
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        guard let string = String(data: CDATABlock, encoding: .utf8) else {
            print("CDATA contains non-textual data, ignored")
            return
        }
        textBuffer += string
    }
    // For debugging
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        print("on:", parser.lineNumber, "at:", parser.columnNumber)
    }
}
