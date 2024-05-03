import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    var viewModel : DetailViewModel?
    
    let stackView = UIStackView()
    let cancelButton = UIButton()
    let confirmButton = UIButton()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let contentStackView = UIStackView()
    let image = UIImageView()
    let titleLabel = UILabel()
    let author = UILabel()
    let price = UILabel()
    let salePrice = UILabel()
    let publisher = UILabel()
    let contents = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureButtonStackView()
        configureScrollView()
        configure()
    }
    
    func configureButtonStackView(){
        stackView.backgroundColor = .systemBackground
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(50)
        }
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.backgroundColor = .gray

        confirmButton.setTitle("담기", for: .normal)
        confirmButton.backgroundColor = .systemGreen
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(confirmButton)

        cancelButton.snp.makeConstraints{make in
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        confirmButton.snp.makeConstraints{make in
            make.trailing.equalToSuperview()
        }
        [cancelButton,confirmButton].forEach{
            $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        }
    }
    
    func configureScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .red
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints{make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(stackView.snp.top).offset(-10)
        }
        contentView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func configure(){
        contentStackView.backgroundColor = .systemBackground
        contentStackView.distribution = .equalSpacing
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.text = viewModel?.title
        author.text = viewModel?.author
        publisher.text = viewModel?.publisher
        image.kf.setImage(with: URL(string: viewModel?.image ?? ""),placeholder: UIImage(systemName: "x.circle"))
        image.contentMode = .scaleAspectFit
        price.text = viewModel?.price
        price.attributedText = price.text?.strikeThrough()
        salePrice.text = viewModel?.salePrice
        contents.text = viewModel?.content
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        [author,price,publisher].forEach{
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .secondaryLabel
        }
        salePrice.font = .systemFont(ofSize: 18)
        [author,price,publisher,titleLabel,salePrice].forEach{
            $0.textAlignment = .center
        }
        [titleLabel,author,publisher,image,price,salePrice,contents].forEach{
            contentStackView.addArrangedSubview($0)
        }
        contents.snp.makeConstraints{make in
            make.height.equalTo(200)
        }
        image.snp.makeConstraints{make in
            make.height.equalTo(300)
        }
        
        
    }

}
