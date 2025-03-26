//
//  AdditionalView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class AdditionalView: UIView {
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Additional"
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(view: UIViewController) {
        super.init(frame: .zero)
        self.setupView(view: view.view)
    }
    
    func setupView(view: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        backgroundColor = .green
    }
    
    
}
