//
//  MainTabBarViewModel.swift
//  pizzaShop
//
//  Created by Have Dope on 17.03.2023.
//

import Foundation
import FirebaseAuth
import Firebase


class MainTabBarViewModel: ObservableObject {
    
    @Published var user: User
    
    init (user: User){
        self.user = user
    }
    
}
