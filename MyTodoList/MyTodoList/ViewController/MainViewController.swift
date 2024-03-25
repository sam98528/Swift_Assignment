//
//  MainViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/22/24.
//

import UIKit
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        // 아래 줄을 추가안하시면 네모네모(?)하고 이상한 Cell을 목격할수있습니다.
        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 해당 줄만 추가했습니다.
        return attributes
    }

}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //tagArray.remove(at: indexPath.row)
        //self.tagCollectionView.reloadData()
        print(tagArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagListCollectionViewCell.identifier, for: indexPath) as! TagListCollectionViewCell
        
        let tag = tagArray[indexPath.row]
        cell.tagLabel.text = tag.tagName
        cell.index = indexPath.row
        cell.delegate = self
        if  Tag.tagDic[cell.tagLabel.text!] != nil{
            let tag = Tag.tagDic[cell.tagLabel.text!]!
            cell.viewList.backgroundColor = tag.color
            cell.currentColor = tag.color
        }
        cell.delButton.isEnabled = true
        cell.tagLabel.font = UIFont(name: font, size: 12)
        cell.viewList.layer.cornerRadius = 10
        cell.viewList.layer.borderColor = UIColor.black.cgColor
        cell.viewList.layer.borderWidth = 1.0
        cell.viewList.clipsToBounds = true
        cell.tagLabel.textAlignment = .center
        return cell
    }
}


extension MainViewController : TagList {
    func delButtonClicked(index : Int) {
        print("Clicked")
        print(index)
        self.tagArray.remove(at: index)
        self.tagCollectionView.reloadData()
    }
    
}


class MainViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    let font = "EF_Diary"
    var tagArray = Array(Tag.tagDic.values)
    

    @IBOutlet weak var tagCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tagArray = Array(Tag.tagDic.values)
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.layer.cornerRadius = 20
        tagCollectionView.layer.borderWidth = 5
        tagCollectionView.clipsToBounds = true
        tagCollectionView.register(TagListCollectionViewCell.nib(), forCellWithReuseIdentifier: TagListCollectionViewCell.identifier)
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        layout.sectionInset.top = 10
        layout.sectionInset.left = 5
        layout.sectionInset.right = 6
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
        
        titleNavigationItem.title = "태그 수정 중.."
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: font, size: 20)!]
        
        titleNavigationItem.rightBarButtonItem?.title = "저장"
        titleNavigationItem.leftBarButtonItem?.action = #selector(self.dismissLeftButton)
        titleNavigationItem.rightBarButtonItem?.action = #selector(self.addRightBUtton)
        titleNavigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        titleNavigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
    }
    
    @objc func dismissLeftButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addRightBUtton(){
        print("click")
    }
}

