//
//  StoreView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class StoreView: UIView {
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Store"
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(view: UIView) {
        super.init(frame: .zero)
        self.setupView(view: view)

    }
    
    func setupView(view: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor),
            self.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        backgroundColor = .blue
    }
    
    
}
