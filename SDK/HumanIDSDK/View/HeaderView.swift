//
//  HeaderView.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 15/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

class HeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let fingerprintImage = UIImage(named: "HumanIDLogoTransparent")
        let humanIDLogoImage = UIImage(named: "HumanIDLogoTextTransparent")
        
        let fingerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        fingerView.image = fingerprintImage
        
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 73, height: 15))
        logoView.image = humanIDLogoImage
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 115, height: 30))
        let bottomLineView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 1.0))
        bottomLineView.backgroundColor = .gray
        
        containerView.addSubview(fingerView)
        containerView.addSubview(logoView)
        addSubview(containerView)
        addSubview(bottomLineView)
        
        
        
        fingerView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        fingerView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        fingerView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        fingerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        logoView.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 73.0).isActive = true
        logoView.leadingAnchor.constraint(equalTo: fingerView.trailingAnchor, constant: 12.0).isActive = true
        logoView.centerYAnchor.constraint(equalTo: fingerView.centerYAnchor).isActive = true
        logoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        logoView.anchorTo(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor)
        
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        bottomLineView.anchorTo(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomLineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
}
