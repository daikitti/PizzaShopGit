//
//  ProfileIView.swift
//  pizzaShop
//
//  Created by Have Dope on 09.03.2023.
//

import SwiftUI

struct ProfileIView: View {
    
    @State var isAvaActionPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthAlertPresented = false
    @State var isRed = false
    
    @StateObject var viewModel: ProfileViewModel
    
    
    
    
    
    var body: some View {
        
        
        
        
        VStack(alignment: .center,spacing: 20) {
            HStack{
                Spacer()
                Button {
                    isRed.toggle()
                } label: {
                    Text(isRed ? "Сохранить" : "Редактировать" )
                }
            }.padding(.trailing)
            
            HStack(spacing: 26) {
                
                Image("user")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color(uiColor: .gray.withAlphaComponent(0.2)))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaActionPresented.toggle()
                    }
                    .confirmationDialog("Откуда загрузить ?", isPresented: $isAvaActionPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("Из галереи")
                        }
                        Button {
                            print("Camera")
                        } label: {
                            Text("С камеры")
                        }
                        
                    }
                
                VStack (alignment: .leading, spacing: 12) {
                    
                    if isRed{
                        TextField("Введите имя", text: $viewModel.profile.name)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 150)
                            
                    }else {
                        Text(viewModel.profile.name)
                            .font(.body.bold())
                            .textFieldStyle(.roundedBorder)
                            .padding(.trailing, 30)
                    }
                   
                    
                    
                    HStack{
                        
                        Text("+7")
                            .padding(.trailing, -6)
                        if isRed{
                            TextField("Телефон", value: $viewModel.profile.phone, format: .number.grouping(.never))
                                .frame(width: 120)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        } else{
                            
                            Text("\(viewModel.profile.phone)")
                                .frame(width: 120)
                            
                        }
                        
                    }
                    
                    
                    
                    
                }
                
            }
            VStack(alignment: .leading) {
                
                HStack{Text("Адрес доставки")
                    .font(.title3.bold())
                    .padding(4)
                    Spacer()
                }
                
                
                HStack{
                    if isRed{
                        TextField("Ваш Адрес", text: $viewModel.profile.adress)
                        
                    } else {
                        Text(viewModel.profile.adress)
                            
                        .padding(.horizontal)
                            
                        Spacer()
                    }
                     
                }
            }.padding(.horizontal)
               .textFieldStyle(.roundedBorder)
                .padding(.trailing, 15)
            
            List(){
                if viewModel.orders.count == 0  {
                    Text("Ваши заказы будут тут ...")
                }else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }.onTapGesture {
                        print("Посмотреть заказ")
                    }
                    
                }
                
            }
            .foregroundColor(.gray)
            .listStyle(.plain)
            .padding()
            .border(.orange, width: 2)
            .cornerRadius(35)
            .padding(8)
            
            
            
            
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: screen.width/2.5)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(24)
                    .shadow(color: .gray, radius: 10, y: 10)
            }.padding()
                .confirmationDialog("Хотите выйти ? ", isPresented: $isQuitAlertPresented, titleVisibility: .visible) {
                    Button("Да", role: .destructive) {
                        AuthService.shared.signOut()
                        isAuthAlertPresented.toggle()
                        
                    }
                    Button("Нет", role: .cancel){}
                    
                }
            
                .fullScreenCover(isPresented: $isAuthAlertPresented, onDismiss: nil) {
                    
                    AuthView()
                    
                    
                }
            
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear(){
            
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
}



struct ProfileIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileIView(viewModel: ProfileViewModel(profile: MVUser(id: "1", name: "Вася Горжков", phone: 8999933333, adress: "хрен доедешь")))
    }
}
