//
//  StorePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

final class StorePresenter: StorePresenterProtocol {
    typealias RouterType = StoreRouter
    
    let interactor: StoreInteractor
    var router: RouterType
    weak var view: StoreViewProtocol?
    var modelProduct: [Results] = []
    var pageProduct: String?

    init(interactor: StoreInteractor, router: RouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    func fetchProducts() {
        interactor.fetchProducts(url: pageProduct, dataResponse: { dataJson in
            switch dataJson {
            case .success(let products):
                self.modelProduct.append(contentsOf: products.results)
                self.view?.updateProductList(product: products)
                self.pageProduct = products.info.next
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchProducts", message: error.localizedDescription)
            }
        })
    }

}

protocol StorePresenterProtocol: AnyObject, PresenterProtocol {
    func fetchProducts()
}
protocol StoreViewProtocol: AnyObject {
    func updateProductList(product: ProductEntity)
    func errorPopUp(title: String, message: String)
}
