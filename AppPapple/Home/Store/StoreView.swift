//
//  StoreView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class StoreView: UIView {
    
    var presenter: HomePresenter?
    
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
    
    init(presenter: HomePresenter) {
        super.init(frame: .zero)
        self.setupView()
        self.presenter = presenter
    }
    
    func setupView() {
        backgroundColor = .blue
    }
    
    
}
