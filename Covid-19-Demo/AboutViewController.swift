//
//  AboutViewController.swift
//  Covid-19-Demo
//
//  Created by MacBook on 3/28/20.
//  Copyright © 2020 MacBookSafwen. All rights reserved.
//

import UIKit
struct ScrollViewData {
    let title: String?
    let image: UIImage?
}
class AboutViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollViewAbout: UIScrollView!
    var scrollViewData = [ScrollViewData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewData = [ScrollViewData.init(title: "Cough in a handkerchief", image: #imageLiteral(resourceName: "tousse")),
                          ScrollViewData.init(title: "Avoid touching eyes, nose and mouth", image: #imageLiteral(resourceName: "dontTouchEyes")),
                          ScrollViewData.init(title: "Wash your hands frequently", image: #imageLiteral(resourceName: "washHands")),
                          ScrollViewData.init(title: "Use disinfectant gels ", image: #imageLiteral(resourceName: "gelUse"))]
        scrollViewAbout.contentSize.width = self.scrollViewAbout.frame.width * CGFloat(scrollViewData.count)
        setUpScrollView()
    }

    
    func setUpScrollView() {
        var i = 0
        for data in scrollViewData {
            let view = MyCustomView(frame: CGRect(x: 10 + (self.scrollViewAbout.frame.width * CGFloat(i)), y: 0, width: self.scrollViewAbout.frame.width - 20 , height: self.scrollViewAbout.frame.height))
            view.imageView.image = data.image
            view.imageView.alpha  = 0.9
            view.tag = i
            self.scrollViewAbout.addSubview(view)
            let label = UILabel(frame: CGRect.init(origin: CGPoint.init(x: view.center.x, y: view.center.y), size: CGSize(width: 0, height: 40)))
            label.text = data.title
            label.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
            label.textColor = .darkGray
            label.sizeToFit()
            label.tag = i + 10
            if i == 0 {
                label.center.x = view.center.x
            }else{
                label.center.x = view.center.x
            }
            
            self.scrollViewAbout.addSubview(label)
             i += 1
    }
  
    }
}

class MyCustomView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
