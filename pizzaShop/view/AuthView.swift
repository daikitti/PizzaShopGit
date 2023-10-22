//
//  ContentView.swift
//  pizzaShop
//
//  Created by Have Dope on 07.03.2023.
//

import SwiftUI

struct AuthView: View {
    
    @State private var isAuth = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isTabBArViewShow = false
    
    @State private var isShowAlert = false
    @State private var alertMesage = ""
   
    
    var body: some View {
        
        
        
        VStack(spacing: 20) {
            Text(isAuth ? "Авторизация": "Регистрация")
                .foregroundColor(.black)
            
                .padding(isAuth ? 16: 24)
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("whiteAlpfa"))
                .cornerRadius(30)
            
            
            VStack {
                
                TextField( "Введите Email", text: $email )
                    ._colorMonochrome(.black)
                    .padding()
                    .background(.white)
                    .cornerRadius(14)
                    .padding(8)
                    .padding(.horizontal, 12)
                   
                
                SecureField("Введите пароль", text: $password)
                    ._colorMonochrome(.black)
                    .padding()
                    .background(.white)
                    .cornerRadius(14)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        ._colorMonochrome(.black)
                        .padding()
                        .background(.white)
                        .cornerRadius(14)
                        .padding(8)
                        .padding(.horizontal, 12)
                }
                
                Button{
                    if isAuth {
                        print("Авторизация пользователя через Аirebase")
                        
                        AuthService.shared.signIn(email: self.email,
                                           password: self.password) { result in
                            switch result {
                            case .success(_):
                                isTabBArViewShow.toggle()
                            case .failure(let error):
                                alertMesage = "Ошибка авторизации \( error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                        
                    }else{
                        print("Регистрация пользователя ")
                        
                        guard password == confirmPassword else{
                            self.alertMesage = "Пароли не совпадают !"
                            self.isShowAlert.toggle()
                            return
                        }
                        
                        AuthService.shared.singUp(email: self.email,
                                                  password: self.password) { result in
                            switch result{
                                 
                            case .success(let user):
                                alertMesage = "Вы успешно зарагестрировались \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                            
                            case .failure(let error):
                                alertMesage = "Oшибка регистрации \(error.localizedDescription)"
                                self.isShowAlert.toggle()
                            }
                        }
                        	
                    }
                    
                } label: {
                    Text(isAuth ? "Войти" : "Создать акканут")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("yello"),Color("orange")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(44)
                    //.padding(8)
                        .padding(.horizontal, 42)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                    
                }
                .padding(.top, 10)
                
                Button{
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Ещё не с нами ?" : "У меня уже есть аккаунт !")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(14)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("darkBroun"))
                    
                }
            }
            .padding()
            .padding(.top, 20)
            .background(Color("whiteAlpfa"))
            .cornerRadius(20)
            .padding(isAuth ?  30 : 12)
            .alert(alertMesage, isPresented: $isShowAlert) {
                Button {
                    
                } label: {
                    Text("Ok")
                }

            }
            
            
        }.frame( maxWidth: .infinity
                 , maxHeight: .infinity)
        .background( Image("bg").ignoresSafeArea().blur(radius: isAuth ? 0 : 4))
        .background(.black)
        .animation(Animation.easeOut(duration: 0.5), value: isAuth)
        .fullScreenCover(isPresented: $isTabBArViewShow) {
            
            if AuthService.shared.currentUser?.uid  == "Q2XPyurTZQbIUmmlrusoH5p9EDJ3" {
                AdminOrdersView()
            }else{
                let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                MainTabBar(viewModel: mainTabBarViewModel)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
