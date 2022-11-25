//
//  HomeViewController.swift
//  Demo
//
//  Created by 維衣 on 2022/11/10.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate {

    @IBOutlet var imageViews: [UIImageView]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageChangeView: UIView!
    
    
    var translationX: Int = 414
    var timer: Timer?
    
    let width = UIScreen.main.bounds.width
    let imageArray: [UIImage] =
    {
        var arr = [UIImage]()
        for i in 0...3{
            let image = UIImage(named: String(i))
            arr.append(image!)
        
        }
        arr.append(UIImage(named: "1")!)
        return arr
    }()
    
    var imageIndex = 0
    var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()

        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changeBunner), userInfo: nil, repeats: true)
        
        scrollView.delegate = self
        pageControl.currentPage = 0
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         // 將timer的執行緒停止
         if self.timer != nil {
              self.timer?.invalidate()
         }
    }

    
    func setupCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: width, height: 100)
        layout.minimumLineSpacing = CGFloat(integerLiteral: Int(0))
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        
        let bennerRect = CGRect(x: 0, y: 40, width: width, height: width * (4.5 / 16))
        self.collectionView = UICollectionView(frame: bennerRect, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(BennerPicCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.backgroundColor = .clear
        self.view.addSubview(collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BennerPicCell
        cell.imageView.image = imageArray[indexPath.item]
        return cell
    }
    
    @objc func changeBunner(){
        imageIndex += 1
        let indexPath: IndexPath = IndexPath(item: imageIndex, section: 0)
            if imageIndex < (imageArray.count - 1){
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }else if imageIndex == imageArray.count{
                print("*** Scroll to zero")
                imageIndex = 0
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                changeBunner()
            }
                
        }
   
    
}
