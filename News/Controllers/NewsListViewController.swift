//
//  NewsListViewController.swift
//  News
//
//  Created by Pedro Franco on 28/06/23.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var newsListTableView: UITableView!
    
    private var newsList: [NewsModel]?
    
    var localDataProvider: NewsListLocalDataProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        initLocalDataProvider()
    }
    
    private func setupTableView() {
        // Toda vez que eu clicar sobre essa table view, quem delega o que acontecerá é ela mesmo
        newsListTableView.delegate = self
        newsListTableView.dataSource = self
    }
    
    private func initLocalDataProvider() {
        self.localDataProvider = NewsListLocalDataProvider()
        self.localDataProvider?.delegate = self
        self.localDataProvider?.getNewsList()
    }

}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension NewsListViewController: NewsListLocalDataProviderProtocol {
    func sucessData(model: Any) {
        // print("Model: \(model)")
        newsList = model as? [NewsModel]
        newsListTableView.reloadData()
    }
    
    func errorData(_ provide: GenericDataProvider?, error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
