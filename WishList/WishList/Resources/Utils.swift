//
//  Utils.swift
//  WishList
//
//  Created by Sam.Lee on 4/12/24.
//

import Foundation
import UIKit
import CoreData

extension UIButton {
    
    func addBadge(number: Int) {
        // 뱃지가 0이면 숨김 처리
        if number == 0 {
            // 현재 버튼에 뱃지가 있다면 제거
            for subview in self.subviews {
                if subview is UILabel {
                    subview.removeFromSuperview()
                }
            }
            return
        }
        let badgeLabel = UILabel(frame: CGRect(x: self.frame.size.width - 20, y: -8, width: 28, height: 28))
        badgeLabel.layer.borderWidth = 1.0 // 스트로크 두께 설정
        badgeLabel.layer.borderColor = UIColor(red: 0.34, green: 0.29, blue: 0.24, alpha: 0.6).cgColor
        badgeLabel.backgroundColor = UIColor(red: 0.242, green: 0.242, blue: 0.242, alpha: 1)
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.width / 2
        badgeLabel.layer.masksToBounds = true
        badgeLabel.text = "\(number)"
        badgeLabel.font = UIFont.systemFont(ofSize: 14)
        // Add new badge view with animation
        badgeLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.addSubview(badgeLabel)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            badgeLabel.transform = .identity
        }, completion: nil)
    }
}


extension Int {
    static func addCommas(to number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
