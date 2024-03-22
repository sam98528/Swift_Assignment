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


class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    let font = "EF_Diary"
    var tagArray = Array(Tag.tagDic.values)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print(tagArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Tag.tagDic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagListCollectionViewCell.identifier, for: indexPath) as! TagListCollectionViewCell
        
        //let tagArray = Array(Tag.tagDic.values)
        let tag = tagArray[indexPath.row]
        cell.tagLabel.text = tag.tagName
        
        
        if  Tag.tagDic[cell.tagLabel.text!] != nil{
            let tag = Tag.tagDic[cell.tagLabel.text!]!
            cell.viewList.backgroundColor = tag.color
        }
        cell.tagLabel.font = UIFont(name: font, size: 12)
        //cell.exitButton.contentMode = .scaleToFill
        //cell.exitButton.imageEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 0)
        //cell.tagLabel.backgroundColor = UIColor.blue
        cell.viewList.layer.cornerRadius = 10
        cell.viewList.layer.borderColor = UIColor.black.cgColor
        cell.viewList.layer.borderWidth = 1.0
        cell.viewList.clipsToBounds = true
        cell.tagLabel.textAlignment = .center
        
        return cell
    }
    

    @IBOutlet weak var tagCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tagArray = Array(Tag.tagDic.values)
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.layer.cornerRadius = 20
        tagCollectionView.layer.borderWidth = 5
        tagCollectionView.register(TagListCollectionViewCell.nib(), forCellWithReuseIdentifier: TagListCollectionViewCell.identifier)
        tagCollectionView.collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
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
