//
//  ContactPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

class ContactPresenter: PresenterProtocol {
    typealias RouterType = ContactRouter
    
    let interactor: ContactInteractor
    var router: RouterType
    weak var view: ContactViewProtocol?
    
    init(interactor: ContactInteractor, router: RouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    func goToSocialMedia(socialMedia: SocialMedia){
        guard let view = view else { return }
        router.goToSocialMedia(socialMedia: socialMedia)
    }

}

protocol ContactViewProtocol: AnyObject {
    
}
