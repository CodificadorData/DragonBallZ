//
//  ContactPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

final class ContactPresenter: ContactPresenterProtocol {
    typealias RouterType = ContactRouter
    
    private let interactor: ContactInteractor
    var router: RouterType
    weak var view: ContactViewProtocol?
    
    init(interactor: ContactInteractor, router: RouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    func goToSocialMedia(socialMedia: SocialMedia){
        router.goToSocialMedia(socialMedia: socialMedia)
    }

}

protocol ContactPresenterProtocol: AnyObject, PresenterProtocol {
    func goToSocialMedia(socialMedia: SocialMedia)
}

protocol ContactViewProtocol: AnyObject {
    
}
