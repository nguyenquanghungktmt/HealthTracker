//
//  ViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 14/06/2022.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var collectionViewIntro: UICollectionView!
    @IBOutlet weak var pageControlIntro: UIPageControl!
    @IBOutlet weak var viewBackgroundIntro: UIView!
    
    let introSlides = Constants.introSlides
    
    let gradient = CAGradientLayer()
    var currentSlide = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        collectionViewIntro.delegate = self
        collectionViewIntro.dataSource = self
        self.collectionViewIntro.register(UINib(nibName: "SlideCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SlideCollectionViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = viewBackgroundIntro.bounds
    }
    
    public func setupView(){
        self.view.backgroundColor = UIColor(rgb: 0xF3F5FB)
        
        // set gradient for Intro background
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [UIColor(rgb: 0xA6F1F7).cgColor, UIColor(rgb: 0xF3F5FB).cgColor]
        gradient.locations = [0, 1.0]
        viewBackgroundIntro.layer.addSublayer(gradient)
        
        // set color for page control
        pageControlIntro.currentPageIndicatorTintColor = UIColor(rgb: 0x2C8667)
        pageControlIntro.pageIndicatorTintColor = UIColor(rgb: 0x2C8667, alpha: 0.3)
        
        
        // setup button
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
        let vc = UIViewController.fromStoryboard(LoginViewController.self)
        self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    

    @IBAction func handleBtnCreateAccount(_ sender: UIButton) {
        
    }
}

extension IntroViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introSlides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let introCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCollectionViewCell", for: indexPath) as? SlideCollectionViewCell else {
            return UICollectionViewCell()
        }
        introCell.setupIntroCell(intro: introSlides[indexPath.item])
        return introCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewIntro.bounds.size
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
