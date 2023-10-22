//
//  AuthService.swift
//  pizzaShop
//
//  Created by Have Dope on 17.03.2023.
//

import Foundation
import Firebase
import FirebaseAuth


class AuthService  {
    
    static let shared = AuthService()
    
    private init() {}
    
    private let auth = Auth.auth()
    
     var currentUser: User? {
        
        return auth.currentUser
    }
    
    func signOut(){
       try! auth.signOut()
    }
    
    
    func singUp(email: String ,
                password: String ,
                completion: @escaping (Result<User, Error>) -> ()){
        
        auth.createUser(withEmail: email,
                        password: password) { result , error in
            
            if let result = result{
                let mvUser = MVUser(id: result.user.uid ,
                                    name: "",
                                    phone: 0,
                                    adress: "")
                
                DataBaseService.shared.setProfile(user: mvUser) { resultDB in
                    switch resultDB {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            }else if let error = error{
                completion(.failure(error))
            }
        }
    }
    
    
    
    func signIn(email: String ,
                password: String ,
                completion: @escaping (Result<User, Error>) -> ()){
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result{
                completion(.success(result.user))
            }else  if let error = error{
                completion(.failure(error))
            }
            
            
            
        }
    }
}
