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
        self.view.backgroundColor = Constants.Color.background
        
        // set gradient for Intro background
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [Constants.Color.startGradientIntro.cgColor, Constants.Color.endGradientIntro.cgColor]
        gradient.locations = [0, 1.0]
        viewBackgroundIntro.layer.addSublayer(gradient)
        
        // set color for page control
        pageControlIntro.currentPageIndicatorTintColor = Constants.Color.greenBold
        pageControlIntro.pageIndicatorTintColor = Constants.Color.greenLight
        
        
        // setup button
        btnLogin.setTitle("Đăng nhập", for: .normal)
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.layer.cornerRadius = 20
        btnLogin.backgroundColor = Constants.Color.greenBold

        btnCreateAccount.setTitle("Tạo tài khoản", for: .normal)
        btnCreateAccount.setTitleColor(.black, for: .normal)
        btnCreateAccount.layer.cornerRadius = 20
        btnCreateAccount.layer.borderWidth = 1
        btnCreateAccount.backgroundColor = .white
    }
    
    
    @IBAction func handleBtnLogin(_ sender: UIButton) {
//        let loginVC = LoginViewController()
//        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    

    @IBAction func handleBtnCreateAccount(_ sender: UIButton) {
        //        let loginVC = LoginViewController()
        //        self.navigationController?.pushViewController(loginVC, animated: true)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControlIntro.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

}
