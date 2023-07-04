//
//  NewsTableViewCell.swift
//  News
//
//  Created by Pedro Franco on 28/06/23.
//

import UIKit


// Threads
class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var linkImageView: UIImageView!
    
    public var news: NewsModel? {
        didSet {
            self.sourceNameLabel.text = news?.source.name
            self.authorLabel.text = news?.autor
            self.titleLabel.text = news?.title
            self.descriptionLabel.text = news?.description
            self.newsImageView?.loadImage(from: news?.urlToImage)
            self.publishedLabel.text = news?.publishedAt?.toString()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openLink))
        linkImageView.isUserInteractionEnabled = true
        linkImageView.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func openLink() {
        guard let news = news, let url = URL(string: news.url ?? "www.google.com.br") else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


