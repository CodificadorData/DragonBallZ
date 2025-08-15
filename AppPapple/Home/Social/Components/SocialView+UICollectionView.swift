//
//  SocialView+UICollectionView.swift
//  AppPapple
//
//  Created by Christian Morante on 8/08/25.
//
import UIKit

extension SocialViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case newsCollectionView:
            return presenter?.modelNews.count ?? 0
        case shortsCollectionView:
            return presenter?.modelShorts.count ?? 0
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case newsCollectionView:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SocialCollectionViewCell.identifier,
                    for: indexPath
                ) as? SocialCollectionViewCell else {
                    return UICollectionViewCell()
                }
                guard let modelNews = self.presenter?.modelNews else { return UICollectionViewCell() }
                
                guard let url = URL(string: modelNews[indexPath.row].imageUrl) else { return UICollectionViewCell() }
                
                cell.configure(title: modelNews[indexPath.row].title, description: modelNews[indexPath.row].description, url: url)
                return cell
            case shortsCollectionView:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShortsCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? ShortsCollectionViewCell else {
                    return UICollectionViewCell()
                    }
            guard let modelShorts = self.presenter?.modelShorts else { return UICollectionViewCell() }
            guard let url = URL(string: modelShorts[indexPath.row].imageShort) else { return UICollectionViewCell()}
            cell.configure(description: modelShorts[indexPath.row].description, imageUrl: url)
                return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case newsCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case shortsCollectionView:
            return CGSize(width: 150, height: collectionView.frame.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

}

