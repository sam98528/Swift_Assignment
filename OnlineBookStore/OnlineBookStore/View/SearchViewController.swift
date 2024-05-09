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
    var footerView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarConfigure()
        setBindings()
        tableViewConfigure()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
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
        viewModel.didSavedBook = { viewModel, title in
            DispatchQueue.main.async{
                self.showAlert(title: title)
            }
        }
    }
    
    func tableViewConfigure(){
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.register(RecentBooksTableViewCell.self, forCellReuseIdentifier: RecentBooksTableViewCell.identifier)
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
        configureDiffableDataSource()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    func showAlert(title : String){
        let alert = UIAlertController(title: "성공!", message: "[\(title)] 책 담기 완료!", preferredStyle: .alert)
        let close = UIAlertAction(title: "확인", style: .destructive, handler: nil)
        alert.addAction(close)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func configureDiffableDataSource() {
        self.viewModel.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            switch item {
            case .recentRead(let recentBooks):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentBooksTableViewCell.identifier, for: indexPath) as? RecentBooksTableViewCell else{
                    return UITableViewCell()
                }
                cell.configure(recentBooks: recentBooks)
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            case .searchResult(let book):
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
                viewModel.getResult(title: searchText)
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
        case.recentRead(_):
            return
        case .searchResult(let book):
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as? SectionHeaderView else{
            return UIView()
        }
        header.configure(section: section)
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if viewModel.requestResults?.meta.isEnd == false && section == 1{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = view.center
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            footerView = view
            return footerView
        }
        else if viewModel.requestResults?.meta.isEnd == true && section == 1{
            footerView = nil
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if section == 1 && viewModel.requestResults?.meta.isEnd == false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewModel.getMoreResult()
            }
        }
    }
}

extension SearchViewController : RecentBookTouchDelegate {
    func redirectToDetailView(detailVC: UIViewController) {
        self.present(detailVC,animated: true)
    }
}
