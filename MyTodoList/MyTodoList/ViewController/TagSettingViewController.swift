//
//  MainViewController.swift
//  MyTodoList
//
//  Created by Sam.Lee on 3/22/24.
//

import UIKit

protocol TagSettingDelegate : AnyObject {
    func finishedTagSetting(tagList : [Tag])
}


extension TagSettingViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}

extension TagSettingViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        // section에 inset을 주어 레이아웃 구성 (없으면 cell이 cell의 크기에 따라 한쪽에 붙는 현상이 생긴다.)
        return UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0) // 중앙 정렬을 위한 코드
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            let tag = tagArray[indexPath.row]
            tagArray.remove(at: indexPath.row)
            currentTags.append(tag)
            self.tagCollectionView.reloadData()
            self.currentTagCollectionView.reloadData()
        }else{
            self.currentTagLabel.text = currentTags[indexPath.row].tagName
            self.currentTagLabel.backgroundColor = currentTags[indexPath.row].color
            self.tagTextField.text = currentTags[indexPath.row].tagName
            //self.addButton.titleLabel?.text = "변경"
            self.colorWell.selectedColor = currentTags[indexPath.row].color
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var tag : String
        if collectionView == tagCollectionView {
            tag = self.tagArray[indexPath.row].tagName
        }else{
            tag = self.currentTags[indexPath.row].tagName
        }
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: font, size: 15)]
        let tagSize = (tag as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        return CGSize(width: tagSize.width + 20, height: tagSize.height+10)
    }
                      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return tagArray.count
        }else {
            return currentTags.count
        }
        
    }
                      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagListCollectionViewCell.identifier, for: indexPath) as! TagListCollectionViewCell
        var tag : Tag?
        if collectionView == tagCollectionView {
            tag = tagArray[indexPath.row]
            cell.tagLabel.text = tag!.tagName
            cell.tagLabel.backgroundColor = tag?.color
        }else{
            let currentTag = currentTags[indexPath.row].tagName
            cell.tagLabel.text = currentTag
            cell.tagLabel.backgroundColor = currentTags[indexPath.row].color
            cell.currentColor = currentTags[indexPath.row].color
        }
        
        
        cell.index = indexPath.row
        //cell.delButton.isEnabled = true
        cell.tagLabel.font = UIFont(name: font, size: 15)
        cell.tagLabel.layer.cornerRadius = 10
        cell.tagLabel.layer.borderColor = UIColor.black.cgColor
        cell.tagLabel.layer.borderWidth = 1.0
        cell.tagLabel.clipsToBounds = true
        cell.tagLabel.textAlignment = .center
        return cell
    }
}


                                        
class TagSettingViewController: UIViewController {
    
    @IBOutlet weak var currentTagCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var justLabel: UILabel!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var justNewLabel: UILabel!
    @IBOutlet weak var currentTagLabel: UILabel!
    @IBOutlet weak var currentTagLabelView: UIView!
    
    @IBOutlet weak var colorWell: UIColorWell!
    let font = "EF_Diary"
    var tagArray = Array(Tag.tagDic.values)
    var currentTagArray : [String] = []
    var delegate : TagSettingDelegate?
    var currentTags : [Tag] = []
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDoubleTap()
        
        hideKeyboardWhenTappedAround()
        tagArray = Array(Tag.tagDic.values)
        
        justLabel.text = "적용중인 태그"
        justLabel.font = UIFont(name: font, size: 20)
        justNewLabel.text = "새로운 태그 생성"
        justNewLabel.font = UIFont(name: font, size: 20)
        
        addButton.layer.cornerRadius = 20
        addButton.layer.borderWidth = 2
        addButton.titleLabel?.font = UIFont(name: font, size: 15)
        removeButton.layer.cornerRadius = 20
        removeButton.layer.borderWidth = 2
        removeButton.titleLabel?.font = UIFont(name: font, size: 15)
        colorWell.addTarget(self, action: #selector(colorChanged) , for: .valueChanged)
        colorWell.selectedColor = UIColor.gray
        for tag in currentTags {
            tagArray.removeAll(where: {$0.tagName == tag.tagName})
        }
        for (_,element) in currentTagArray.enumerated(){
            //tagArray.removeAll(where: {$0.tagName == element})
            currentTags += Tag.tagDic.values.filter{$0.tagName == element}
        }
        

        currentTagLabel.text = ""
        currentTagLabel.font = UIFont(name: font, size: 25)
        currentTagLabel.backgroundColor = UIColor.gray
        currentTagLabel.layer.cornerRadius = 20
        currentTagLabel.layer.borderWidth = 5
        currentTagLabel.clipsToBounds = true
        currentTagLabel.sizeToFit()
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.layer.cornerRadius = 20
        tagCollectionView.layer.borderWidth = 5
        tagCollectionView.clipsToBounds = true
        tagCollectionView.register(TagListCollectionViewCell.nib(), forCellWithReuseIdentifier: TagListCollectionViewCell.identifier)
        tagCollectionView.isScrollEnabled = true
        
        
        currentTagCollectionView.dataSource = self
        currentTagCollectionView.delegate = self
        currentTagCollectionView.layer.cornerRadius = 20
        currentTagCollectionView.layer.borderWidth = 5
        currentTagCollectionView.clipsToBounds = true
        currentTagCollectionView.register(TagListCollectionViewCell.nib(), forCellWithReuseIdentifier: TagListCollectionViewCell.identifier)
        currentTagCollectionView.isScrollEnabled = true
        currentTagCollectionView.allowsMultipleSelection = false
        
        titleNavigationItem.title = "태그 수정 중.."
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: font, size: 20)!]
        
        titleNavigationItem.rightBarButtonItem?.title = "저장"
        titleNavigationItem.leftBarButtonItem?.action = #selector(self.dismissLeftButton)
        titleNavigationItem.rightBarButtonItem?.action = #selector(self.addRightButton)
        titleNavigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        titleNavigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: 15)!], for: .normal)
        
        self.tagTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        tagTextField.delegate = self
        tagTextField.font = UIFont(name: font, size: 15.0)
    }
    
    @objc func dismissLeftButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addRightButton(){
        self.delegate?.finishedTagSetting(tagList: currentTags)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func colorChanged(){
        self.currentTagLabel.backgroundColor = colorWell.selectedColor
    }
    @objc func textFieldChanged(){
        if self.tagTextField.text?.first != "#"{
            self.currentTagLabel.text = "#" + (self.tagTextField.text ?? "")
        }else{
            self.currentTagLabel.text = self.tagTextField.text
        }
        
        if let _ = (self.currentTags.firstIndex{$0.tagName == self.currentTagLabel.text }){
            self.addButton.titleLabel?.text = "변경"
        }else{
            self.addButton.titleLabel?.text = "추가"
        }
        
        if let index = (self.tagArray.firstIndex{$0.tagName == self.currentTagLabel.text }){
            self.currentTagLabel.backgroundColor = tagArray[index].color
            self.colorWell.selectedColor = tagArray[index].color
        }
    }
        
    @IBAction func removeButtonClicked(_ sender: Any) {
        self.currentTagLabel.text = ""
        self.currentTagLabel.backgroundColor = .clear
        self.tagTextField.text = ""
    }
    @IBAction func addButtonClicked(_ sender: Any) {
        var text = ""
        if self.tagTextField.text?.first != "#"{
            text = "#" + (self.tagTextField.text ?? "")
        }else{
            text = self.tagTextField.text!
        }
        
        if let index = (self.currentTags.firstIndex{$0.tagName == text}){
            currentTags[index].color = self.colorWell.selectedColor!
        }else{
            if text != "#"{
                currentTags.append(Tag(tagName: text, color: (self.colorWell.selectedColor!), todo: []))
                tagArray.removeAll(where: {$0.tagName == currentTags.last?.tagName})
            }
            
        }
        self.currentTagCollectionView.reloadData()
        self.tagCollectionView.reloadData()
    }
    
    private var doubleTapGesture: UITapGestureRecognizer!
        func setUpDoubleTap() {
            doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapCollectionView))
            doubleTapGesture.numberOfTapsRequired = 2
            self.currentTagCollectionView.addGestureRecognizer(doubleTapGesture)
            doubleTapGesture.delaysTouchesEnded = false
    }
    @objc func didDoubleTapCollectionView() {
        let pointInCollectionView = doubleTapGesture.location(in: self.currentTagCollectionView)
        if let selectedIndexPath = self.currentTagCollectionView.indexPathForItem(at: pointInCollectionView) {
            currentTags.remove(at: selectedIndexPath.row)
            tagArray = Array(Tag.tagDic.values)
            for tag in currentTags {
                tagArray.removeAll(where: {$0.tagName == tag.tagName})
            }
            self.currentTagCollectionView.deleteItems(at: [selectedIndexPath])
            self.tagCollectionView.reloadData()
            
            }
        }
}

