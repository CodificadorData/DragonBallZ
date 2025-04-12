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
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    func setupView() {
        backgroundColor = .green
    }
    
    
}
