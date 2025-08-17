//
//  SocialPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

final class SocialPresenter: SocialPresenterProtocol {
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
    
    func fetchNews(action: @escaping()-> Void) {
        interactor.fetchNews { dataJson in
            switch dataJson {
            case .success(let response):
                self.view?.fetchNews(news: response)
                self.modelNews = response.news
                action()
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

    func showSongsList(songsList: [SongsEntity]) {
        router.showSongsList(songsList: songsList)
    }

}

protocol SocialPresenterProtocol: AnyObject, PresenterProtocol {
    func fetchNews(action: @escaping()-> Void)
    func fetchShorts()
    func fetchMultimedia()
    func showSongsList(songsList: [SongsEntity])
}

protocol SocialViewProtocol: AnyObject {
    func fetchNews(news: NewsEntity)
    func fetchShorts(shorts: ShortsEntity)
    func fetchMultimedia(multimedia: MultimediaEntity)
    func errorPopUp(title: String, message: String)
}
