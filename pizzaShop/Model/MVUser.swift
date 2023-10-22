//
//  MVUser.swift
//  pizzaShop
//
//  Created by Have Dope on 18.03.2023.
//

import Foundation


struct MVUser: Identifiable {
    var id: String
    var name: String
    var phone: Int
    var adress: String
   
    
    var representatin: [String:Any] {
        
        var repres  = [String:Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["adress"] = self.adress
  
        
        return repres
    }
    
    
    
}
