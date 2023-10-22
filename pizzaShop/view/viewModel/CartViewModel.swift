//
//  CardViewModel.swift
//  pizzaShop
//
//  Created by Have Dope on 13.03.2023.
//

import Foundation


class CartViewModel: ObservableObject{
    
  
    
   @Published var positions = [Position]()
    
    func addPosition(_ position: Position){
        self.positions.append(position)
    }
    
}
