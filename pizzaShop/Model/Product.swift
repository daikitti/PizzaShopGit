//
//  Product.swift
//  pizzaShop
//
//  Created by Have Dope on 11.03.2023.
//

import Foundation
import FirebaseFirestore
import Firebase

struct Product {
   
    
    var id: String
    var title: String
    var imageUrl: String = ""
    var price: Int
    var descript: String
    
// var ordersCount: Int
//var isRecomend: Bool
    
    var representation: [String:Any] {
        
        var repres  = [String:Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["descript"] = self.descript
  
        return repres
    }
    
    internal init(id: String = UUID().uuidString,
                  title: String,
                  imageUrl: String = "",
                  price: Int,
                    descript: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.descript = descript
    }
    
    init?(doc : QueryDocumentSnapshot ){
        
        let data = doc.data()
        guard let id =  data["id"] as? String else {return nil}
        guard let title =  data["title"] as? String else {return nil}
        guard let price =  data["price"] as? Int else {return nil}
        guard let descript =  data["descript"] as? String else {return nil}

        self.id = id
        self.title = title
        self.descript = descript
        self.price = price
    }
}

    

