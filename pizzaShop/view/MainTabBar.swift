//
//  MainTabBar.swift
//  pizzaShop
//
//  Created by Have Dope on 09.03.2023.
//

import SwiftUI

struct MainTabBar: View {
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        
        TabView{
            
            NavigationView{
                CatalogView()
                
            }.tabItem {
                VStack{
                    Image(systemName: "menucard")
                    Text("Каталог")
                    
                }
            }
            
            
            
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack{
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }
            
            
            ProfileIView(viewModel: ProfileViewModel(profile: MVUser(id: "", name: "", phone: 09090909091, adress: "")))
                .tabItem {
                    VStack{
                        Image(systemName: "person")
                        Text("Профиль")
                    }
                }
            
            
        }
    }
    
}

