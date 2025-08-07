//
//  HomeView+TableView.swift
//  AppPapple
//
//  Created by Christian Morante on 7/08/25.
//

import UIKit

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.modelDragon.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifi, for: indexPath)
        cell.backgroundColor = UIColor(red: 7/255.0, green: 32/255.0, blue: 131/255.0, alpha: 1)
        let personajeNombre = presenter?.modelDragon[indexPath.row].name
        cell.textLabel?.text = personajeNombre
        cell.textLabel?.textColor = .white
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        guard let textLabel = cell.textLabel else {return cell}
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicatorPrincipalImage.startAnimating()
        activityIndicatorBannerImage.startAnimating()
        guard let url = presenter?.modelDragon[indexPath.row].image else {
            return
        }
        principalImage.kf.setImage(with: URL(string: url), completionHandler: { result in
            switch result {
            case .success(_):
                self.activityIndicatorPrincipalImage.stopAnimating()
            case .failure(_):
                break
            }
        })
        bannerImage.kf.setImage(with: URL(string: url), completionHandler: { result in
            switch result {
            case .success(_):
                self.activityIndicatorBannerImage.stopAnimating()
            case .failure(_):
                break
            }
        })
        personaje = presenter?.modelDragon[indexPath.row]
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.1
    }
    
}
