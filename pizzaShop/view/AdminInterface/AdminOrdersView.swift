//
//  AdminOrdersView.swift
//  pizzaShop
//
//  Created by Have Dope on 25.03.2023.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject var viewmodel = AdminOrdersViewModel()
    @State var isOrderViewShow = false
    @State var isShowAuthView = false
    @State private var isShowAddProductView = false
    
    var body: some View {
        VStack {
            HStack{
                 Button {
                    AuthService.shared.signOut()
                    isShowAuthView.toggle()
                } label: {
                    Text("Выход")
                        .font(.title3)
                        .fontWeight(.light)
                        .frame(maxWidth: screen.width/4)
                        .padding(4)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(24)
                }
                
                Spacer()
                
                Button {
                    print("Добавить товар")
                    isShowAddProductView.toggle()
                } label: {
                    Text("Добавить товар")
                }.font(.title3)
                    .fontWeight(.light)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(24)

            }.padding()
            
            
            List {
                ForEach(viewmodel.orders, id: \.id) { order in
                    OrderCell(order: order)
                        .onTapGesture {
                            viewmodel.currentOrder = order
                            
                            isOrderViewShow.toggle()
                        }
                   
                }
            }.refreshable(action: {
                viewmodel.getOrders()
            })
            .listStyle(.plain)
                .onAppear{
                    viewmodel.getOrders()
                    
                }
                .sheet(isPresented: $isOrderViewShow) {
                    let orderViewModel = OrderViewModel(order: viewmodel.currentOrder)
                    OrderView(viewmodel: orderViewModel)
                }
        }
        .fullScreenCover(isPresented: $isShowAuthView) {
            AuthView()
        }
        .sheet(isPresented: $isShowAddProductView) {
            AddProductView()
        }
    }
}

struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
