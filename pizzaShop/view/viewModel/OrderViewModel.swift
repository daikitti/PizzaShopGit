//
//  OrderViewModel.swift
//  pizzaShop
//
//  Created by Have Dope on 25.03.2023.
//

import Foundation


class OrderViewModel: ObservableObject {
    @Published var order: Order
    @Published var user = MVUser(id: "", name: "", phone: 0, adress: "")
    
    init(order: Order){
        self.order = order
    }
    
    func getUserDate(){
        DataBaseService.shared.getProfile(by: order.userID) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
