//
//  AdditionalView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class AdditionalView: UIView {
    
    var presenter: HomePresenter?
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.textColor = .black
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 18)
        title.text = "Additional"
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(presenter: HomePresenter) {
        super.init(frame: .zero)
        self.setupView()
        self.presenter = presenter
    }
    
    func setupView() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        backgroundColor = .green
        
    }
    
    
}
