import UIKit
import SnapKit

class ListViewController: UIViewController {
    private var viewModel = ListViewModel()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigure()
        viewModel.applySnapshot()
        configureNavBar()
    }
    func tableViewConfigure(){
        tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.delegate = self
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
                cell.configure(book: book.typeCasting())
                cell.selectionStyle = .none
                return cell
            }
        })
    }
    
    func configureNavBar(){
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        addButton.tintColor = .blue
        let allDeleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(allDeleteButtonClicked))
        allDeleteButton.tintColor = .red
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = allDeleteButton
    }
    
    @objc func addButtonClicked(){
        tabBarController?.selectedIndex = 0
    }
    
    @objc func allDeleteButtonClicked(){
        showDeleteAlert()
    }
    
    func showDeleteAlert(){
        let alert = UIAlertController(title: "경고!", message: "\(self.viewModel.savedBookCount)권 책을 모두 지우겠습니까?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: { action in
            self.dismiss(animated: true)
            self.viewModel.deleteSavedBook()
        })
        let close = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alert.addAction(confirm)
        alert.addAction(close)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListViewController : UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = self.viewModel.dataSource?.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .book(let book):
            let currentBook = book.typeCasting()
            let detailVC = DetailViewController()
            let detailVM = DetailViewModel()
            detailVM.currentBook = currentBook
            detailVC.viewModel = detailVM
            self.present(detailVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let item = self.viewModel.dataSource?.itemIdentifier(for: indexPath) else { return nil}
        switch item {
        case .book(let book):
            let del = UIContextualAction(style: .destructive, title: "", handler: {(action, view, completionHandler) in
                self.viewModel.deleteBook(bookToDelete: book)
                completionHandler(true)
            })
            del.image = UIImage(systemName: "trash.fill")
            return UISwipeActionsConfiguration(actions: [del])
        }
    }
    
}
