//
//  Login.swift
//  Moneta App
//
//  Created by Robson Lopes on 10/05/22.
//

import SwiftUI
import AuthenticationServices

// CoreData -> CloudKit
// Keychain (persistencia segura)
// Apple sign in

struct Login: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isLoggedIn = false
    
    var body: some View {
        VStack {
            
            linearGradienteWithLogo.frame(
                height: UIScreen.main.bounds.height*0.5
            )
            
            signInWithAppleButton.frame(
                width: UIScreen.main.bounds.width*0.6,
                height: UIScreen.main.bounds.height*0.06
            )
            
            Spacer()
        }
        .background(
            ZStack {
                //Color("Background")
                
                NavigationLink(isActive: $isLoggedIn){
                    Expenses()
                } label: {
                    EmptyView()
                }
            }
        )
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
    var linearGradienteWithLogo: some View{
        ZStack{
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color("Linear4"),
                        Color("Linear3"),
                        Color("Linear2"),
                        Color("Linear1"),
                        Color("Background")
                    ]),
                startPoint: .topLeading,
                endPoint: .center
            )
            Image("join")
        }
    }
    
    
    
    var signInWithAppleButton: some View {
        
        colorScheme == .dark ? mySignInWithAppleButton.signInWithAppleButtonStyle(.white) :
        
        mySignInWithAppleButton.signInWithAppleButtonStyle(.black)
        
    }
    
    var mySignInWithAppleButton: some View {
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let auth):
                    print("Authorization successful. \(auth.credential.description)")
                    isLoggedIn = true
                    
                case .failure(let error):
                    print("Authorization failed: " + error.localizedDescription)
                }
            }
        )
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Login()
            Login()
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
                .previewInterfaceOrientation(.portrait)
        }
    }
}
