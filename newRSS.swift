/*import Foundation

let rssURL = URL(string: "http://www.example.com/rss")!

URLSession.shared.dataTask(with: rssURL) { data, response, error in
    guard let data = data, error == nil else {
        print(error ?? "Unknown error")
        return
    }

    let xmlDocument = try? XMLDocument(data: data, options: [])
    guard let xmlRoot = xmlDocument?.rootElement() else {
        print("Unable to get root element")
        return
    }

    let items = xmlRoot.nodes(forXPath: "//item")
    for item in items {
        let title = item.elements(forName: "title").first?.stringValue
        let description = item.elements(forName: "description").first?.stringValue
        let link = item.elements(forName: "link").first?.stringValue

        // Process the attributes of the item element
        for attribute in item.attributes {
            let name = attribute.name
            let value = attribute.stringValue
            // Process the attribute name and value here
        }

        // Process the title, description, and link here
    }
}.resume()
*/
