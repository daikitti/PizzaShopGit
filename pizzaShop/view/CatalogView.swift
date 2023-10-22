
//
//  Catalog.swift
//  pizzaShop
//
//  Created by Have Dope on 09.03.2023.
//

import SwiftUI

struct CatalogView: View {
    
    let layoutPopular = [GridItem(.adaptive(minimum: screen.width/2.2))]
    let layoutPizza = [GridItem(.adaptive(minimum: screen.width/2.4))]
    @StateObject var viewModel = CatalogViewModel()
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            Text("Популярное")
                .padding(14)
                .padding(.horizontal, 20)
                .font(.title.bold())
                .foregroundColor(.white)
                .background(LinearGradient(colors: [Color(.systemPink.withAlphaComponent(0.7)),Color(.gray)], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(30)
                .shadow(radius: 10,y: 9)
                .padding(10)
            
            Section(""){
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutPopular, spacing: 20) {
                        ForEach(CatalogViewModel.shared.popularProducts, id: \.id){
                            item in
                            NavigationLink{
                                
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }.padding(8)
                    .background(LinearGradient(colors: [Color(.systemPink.withAlphaComponent(0.4)),Color(.systemPink.withAlphaComponent(0))], startPoint: .bottom, endPoint: .top))
                //.cornerRadius(20)
                    .padding(.horizontal, 4)
            }.padding(.bottom, 5)
            
            
            Text("Пицца")
                .padding(14)
                .padding(.horizontal, 20)
                .font(.title.bold())
                .background(LinearGradient(colors: [Color("yello"),Color("orange")], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(30)
                .shadow(radius: 10,y: 9)
                .padding(10)
            
        
            Section(){
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutPizza) {
                        ForEach(viewModel.pizza , id: \.id){ item in
                            
                            NavigationLink{
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }.padding(.vertical, 5)
                    }
                }.shadow(radius: 10, y: 5)
            }.navigationBarHidden(true)
            
        }.onAppear(){
            print("GETPRODUCTS")
            self.viewModel.getProducts()
        }
    }
}


struct Catalog_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
