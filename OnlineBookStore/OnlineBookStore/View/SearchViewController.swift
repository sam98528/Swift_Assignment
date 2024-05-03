//
//  SearchViewController.swift
//  OnlineBookStore
//
//  Created by Sam.Lee on 5/2/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    private var viewModel = SearchBookViewModel()
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarConfigure()
        setBindings()
        tableViewConfigure()
    }

    func searchBarConfigure(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "제목, ISBN, 출판사, 인명.."
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.enablesReturnKeyAutomatically = false
        self.navigationItem.titleView = searchBar
    }
    
    func setBindings(){
        viewModel.didGetResult = { [weak self] viewModel in
            DispatchQueue.main.async {
                self?.viewModel.applySnapshot()
            }
        }
    }
    
    func tableViewConfigure(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        configureDiffableDataSource()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    

    
    func configureDiffableDataSource() {
        self.viewModel.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            switch item {
            case .book(let book):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else{
                    return UITableViewCell()
                }
                cell.configure(book: book)
                cell.selectionStyle = .none
                return cell
            }
        })
    }
    
}

extension SearchViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if searchText != ""{
                viewModel.getResult(title: searchText, page: 0)
            }
            searchBar.resignFirstResponder()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController : UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = self.viewModel.dataSource?.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .book(let book):
            print(book)
            let detailVC = DetailViewController()
            let detailVM = DetailViewModel()
            detailVM.currentBook = book
            detailVC.viewModel = detailVM
            self.present(detailVC, animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}



