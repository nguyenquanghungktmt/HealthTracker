//
//  ViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 14/06/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var collectionViewIntro: UICollectionView!
    @IBOutlet weak var pageControlIntro: UIPageControl!
    @IBOutlet weak var viewBackgroundIntro: UIView!
    
    let introSlides: [String] = ["1", "2", "3"]
    
    var currentSlide = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        collectionViewIntro.delegate = self
        collectionViewIntro.dataSource = self
        self.collectionViewIntro.register(UINib(nibName: "SlideCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SlideCollectionViewCell")
        
    }
    
    public func setupView(){
        self.view.backgroundColor = UIColor(rgb: 0xF3F5FB)
        self.viewBackgroundIntro.backgroundColor = UIColor(rgb: 0xA6F1F7)
        
        let gradient = CAGradientLayer()
        gradient.frame = self.viewBackgroundIntro.bounds
        gradient.colors = [UIColor(rgb: 0xA6F1F7), UIColor(rgb: 0xF3F5FB)]
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        self.viewBackgroundIntro.layer.insertSublayer(gradient, at: 0)
        
        
        pageControlIntro.currentPageIndicatorTintColor = UIColor(rgb: 0x2C8667)
        pageControlIntro.pageIndicatorTintColor = UIColor(rgb: 0x2C8667, alpha: 0.3)
        
        btnLogin.setTitle("Đăng nhập", for: .normal)
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.layer.cornerRadius = 20
        btnLogin.backgroundColor = UIColor(rgb: 0x2C8667)
        
        btnCreateAccount.setTitle("Tạo tài khoản", for: .normal)
        btnCreateAccount.setTitleColor(.black, for: .normal)
        btnCreateAccount.layer.cornerRadius = 20
        btnCreateAccount.layer.borderWidth = 1
        btnCreateAccount.backgroundColor = .white
    }
    
    
    @IBAction func handleBtnLogin(_ sender: UIButton) {
        
    }
    

    @IBAction func handleBtnCreateAccount(_ sender: UIButton) {
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introSlides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let introCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCollectionViewCell", for: indexPath) as? SlideCollectionViewCell else {
            return UICollectionViewCell()
        }
        introCell.setupIntroCell()
        return introCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // s
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControlIntro.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

}

extension UIColor {

    convenience init(rgb: UInt) {
        self.init(rgb: rgb, alpha: 1.0)
    }

    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
