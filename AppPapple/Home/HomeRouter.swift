//
//  HomeRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit
import SwiftKeychainWrapper
import WebKit

class HomeRouter {
    
    func goToCharacterDetail(mainView: AnyObject, dragonBallModel: Item) {
        let charactersView = CharacterViewController(dragonBallModel: dragonBallModel)
        mainView.navigationController?.pushViewController(charactersView, animated: true)
    }
    
    func goToLogin(){
        MainRouter.shared.goToLogin()
    }
    
    func goToSocialMedia(mainView: AnyObject, socialMedia: SocialMedia){
        let webView = WebView()
        var url: String = ""
        switch socialMedia {
            case .facebook:
                url = "https://www.facebook.com/"
            case .instagram:
                    url = "https://www.instagram.com/"
            case .youtube:
                    url = "https://www.youtube.com/"
            default:
                break
        }
        webView.urlString = url
        mainView.present(webView, animated: true)
    }
}
