//
//  AdminOrdrsViewModel.swift
//  pizzaShop
//
//  Created by Have Dope on 25.03.2023.
//

import Foundation


class AdminOrdersViewModel: ObservableObject{
    @Published var orders = [Order]()
    var currentOrder = Order(userID: "", date: Date(), status: "")
    
    func getOrders(){
        
        DataBaseService.shared.getOrders(by: nil) { resul in
            switch resul{
            case .success(let orders):
                self.orders = orders
                for(index, order) in self.orders.enumerated(){
                    DataBaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                      case .success(let positions):
                            self.orders[index].positions = positions
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
