//
//  SystemExtensions.swift
//  News
//
//  Created by Pedro Franco on 29/06/23.
//

import UIKit

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter
    } ()
}

extension UIImageView {
    func downloadedImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        
            URLSession.shared.dataTask(with: url) { data, response, error in
            
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mineType = response?.mimeType, mineType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage(named: "placeholder")
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
        }.resume()
    }
    
    func loadImage(from link: String?, contentMode mode: ContentMode = .scaleToFill) {
        guard let link = link, let url = URL(string: link) else { return }
        
        downloadedImage(from: url, contentMode: contentMode)
    }
}

extension Date {
    func toString(with formatter: String = "dd/MM/yyyy") -> String? {
        let dateFormat = DateFormatter()
        
        if Calendar.current.isDateInToday(self) {
            dateFormat.dateFormat = "HH:mm"
            dateFormat.locale = Locale.init(identifier: "pt-br")
            dateFormat.timeZone = TimeZone(abbreviation: "UTC")
            return "Hoje as  \(dateFormat.string(from: self))"
        }
        
        dateFormat.dateFormat = formatter
        return dateFormat.string(from: self)
    }
}
