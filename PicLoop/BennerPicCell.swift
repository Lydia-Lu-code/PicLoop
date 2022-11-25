//
//  PicCell.swift
//  Demo
//
//  Created by 維衣 on 2022/11/17.
//

import UIKit

class BennerPicCell: UICollectionViewCell {
    var imageView = UIImageView()
    
    func setupImageView(){
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        imageView.backgroundColor = .lightGray
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        setupImageView()
    }
    
}
