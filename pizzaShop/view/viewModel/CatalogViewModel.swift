//
//  CatalogViewModel.swift
//  pizzaShop
//
//  Created by Have Dope on 12.03.2023.
//

import Foundation

class CatalogViewModel: ObservableObject{
    
    static let shared = CatalogViewModel()
    
    var popularProducts = [
        Product(id: "1", title: "Маргарита Гурмэ", imageUrl: "not found", price: 450,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "2", title: "Маргарита ", imageUrl: "not found", price: 350,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "3", title: "Пипперони", imageUrl: "not found", price: 500,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "4", title: "Гавайская", imageUrl: "not found", price: 450,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "5", title: "Дьябло", imageUrl: "not found", price: 600,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        
    ]
    @Published var pizza = [
        Product(id: "1", title: "Маргарита Гурмэ", imageUrl: "not found", price: 450,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "2", title: "Маргарита ", imageUrl: "not found", price: 350,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "3", title: "Пипперони", imageUrl: "not found", price: 500,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "4", title: "Гавайская", imageUrl: "not found", price: 450,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        Product(id: "5", title: "Дьябло", imageUrl: "not found", price: 600,
                descript: "Сыр моцарелла, филе куриное, помидоры свежие, бекон, итальянский томатный соус, соус барбекю, прованские травы."),
        
    ]
    
    func getProducts(){
        DataBaseService.shared.getProducts { result in
            switch result{
            case .success(let products):
                self.pizza = products
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    
}
