import UIKit

class SectionHeaderView : UITableViewHeaderFooterView{
    let titleLabel = UILabel()
    static let identifier = "SectionHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        
    }
    
    required init?(coder : NSCoder){
        fatalError("init(Coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 0, y: contentView.frame.height-5-titleLabel.frame.size.height, width: contentView.frame.size.width, height: titleLabel.frame.size.height)
    }
    func configure(section: Int){
        switch section{
        case 0:
            titleLabel.text = "최근 본책"
        case 1:
            titleLabel.text = "검색 결과"
        default:
            titleLabel.text = "검색 결과"
        }
        titleLabel.font = .boldSystemFont(ofSize: 22)
    }
    func configureFooter(section: Int){
        if section == 1{
            titleLabel.text = "결과 끝!"
            titleLabel.font = .systemFont(ofSize: 17)
            titleLabel.textAlignment = .center
        }
    }
    
}
