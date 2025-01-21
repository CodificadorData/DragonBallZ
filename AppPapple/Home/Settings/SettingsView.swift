//
//  SettingsView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class SettingsView: UIView {
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "My account"
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
        self.addSubview(title)
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor),
            self.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 10),
            title.widthAnchor.constraint(equalToConstant: 200)
            
        ])

        backgroundColor = .red
    }
    
    
}
