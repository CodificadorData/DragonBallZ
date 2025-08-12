//
//  SocialPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

class SocialPresenter: SocialPresenterProtocol {
    typealias RouterType = SocialRouter
    
    let interactor: SocialInteractor
    var router: RouterType
    weak var view: SocialViewProtocol?
    var modelNews: [News] = []
    var modelShorts: [ResultShort] = []
    var modelMultimedia: MultimediaEntityResult?

    init(interactor: SocialInteractor, router: RouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    func fetchNews() {
        interactor.fetchNews { dataJson in
            switch dataJson {
            case .success(let response):
                self.view?.fetchNews(news: response)
                self.modelNews = response.news
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchNews", message: error.localizedDescription)
            }
        }
    }
    
    func fetchShorts() {
        interactor.fetchShorts { dataJson in
            switch dataJson {
            case .success(let response):
                self.view?.fetchShorts(shorts: response)
                self.modelShorts = response.results
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchShorts", message: error.localizedDescription)
            }
        }
    }
    
    func fetchMultimedia() {
        interactor.fetchMultimedia { dataResponse in
            switch dataResponse {
            case .success(let response):
                self.view?.fetchMultimedia(multimedia: response)
                self.modelMultimedia = response.results
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchMultimedia", message: error.localizedDescription)
            }
        }
    }

    func showSongsList() {
        guard let view = view else { return }
        router.showSongsList()
    }

}

protocol SocialPresenterProtocol: AnyObject, PresenterProtocol {
    func fetchNews()
    func fetchShorts()
    func fetchMultimedia()
    func showSongsList()
}

protocol SocialViewProtocol: AnyObject {
    func fetchNews(news: NewsEntity)
    func fetchShorts(shorts: ShortsEntity)
    func fetchMultimedia(multimedia: MultimediaEntity)
    func errorPopUp(title: String, message: String)
}
