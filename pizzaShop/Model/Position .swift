//
//  Position .swift
//  pizzaShop
//
//  Created by Have Dope on 13.03.2023.
//

import Foundation
import FirebaseFirestore


struct Position: Identifiable{
    
    var id: String
    var product: Product
    var count: Int
    var coast: Int {
        
        return product.price * self.count
    }
    
    
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        
        repres["id"] = self.id
        repres["count"] = self.count
        repres["title"] = self.product.title
        repres["price"] = self.product.price
        repres["coast"] = self.coast
        
        return repres
    }
    
    internal init(id: String, product: Product, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    init?(doc: QueryDocumentSnapshot){
        
        let data = doc.data()
        
        guard let id = data["id"] as? String else {return nil}
        guard let title = data["title"] as? String else{return nil}
        guard let price = data["price"] as? Int else{return nil}

        let product: Product = Product(id: "",
                                       title: title,
                                       imageUrl: "",
                                       price: price,
                                       descript: "")
        
        guard let count = data["count"] as? Int else {return nil}
        
        self.id = id
        self.product = product
        self.count = count
        
    }
    
}
