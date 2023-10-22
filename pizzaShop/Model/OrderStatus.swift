//
//  OrderStatus.swift
//  pizzaShop
//
//  Created by Have Dope on 22.03.2023.
//

import Foundation


enum OrderStatus: String, CaseIterable {
    
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставляется"
    case completed = "Выполнен"
    case cancelled = "Отменëн"
}
