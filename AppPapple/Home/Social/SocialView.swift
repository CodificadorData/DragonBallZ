//
//  AdditionalView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class SocialView: UIView {
    
    var presenter: HomePresenter?
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.textColor = .white
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 18)
        title.text = "Social"
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    func start() {
        self.setupView()
    }
    
    func setupView() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
