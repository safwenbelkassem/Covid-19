//
//  RestaurantPreviewView.swift
//  googlMapTutuorial2
//
//  Created by Muskan on 12/17/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import Foundation
import UIKit

class RestaurantPreviewView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        self.clipsToBounds=true
        self.layer.masksToBounds=true
        setupViews()
    }
    
    func setData(title: String, img: UIImage, stat: String, value: Int) {
        lblTitle.text = title
        imgView.image = img
        lblstat.text = stat
        lblstatValue.text = "\(value)"
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive=true
        lblTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 35).isActive=true
        
        addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        imgView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive=true
        imgView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        addSubview(lblstat)
        lblstat.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 70).isActive = true 
        //lblstat.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        lblstat.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive=true
        lblstat.widthAnchor.constraint(equalToConstant: 130).isActive=true
        lblstat.heightAnchor.constraint(equalToConstant: 40).isActive=true
        
        addSubview(lblstatValue)
        lblstatValue.leadingAnchor.constraint(equalTo: lblstat.trailingAnchor).isActive=true
        lblstatValue.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive=true
        lblstatValue.widthAnchor.constraint(equalToConstant: 90).isActive=true
        lblstatValue.heightAnchor.constraint(equalToConstant: 40).isActive=true
    }
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image=#imageLiteral(resourceName: "90-1")
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 28)
        lbl.textColor = UIColor.black
        lbl.backgroundColor = UIColor.white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblstat: UILabel = {
        let lbl=UILabel()
        lbl.text="Cases"
        lbl.font=UIFont.boldSystemFont(ofSize: 32)
        lbl.textColor=UIColor.white
        lbl.backgroundColor=UIColor(white: 0.2, alpha: 0.8)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 5
        lbl.clipsToBounds=true
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    let lblstatValue: UILabel = {
        let lbl=UILabel()
        lbl.text="12"
        lbl.font=UIFont.boldSystemFont(ofSize: 32)
        lbl.textColor=UIColor.white
        lbl.backgroundColor=UIColor(white: 0.2, alpha: 0.8)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 5
        lbl.clipsToBounds=true
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
