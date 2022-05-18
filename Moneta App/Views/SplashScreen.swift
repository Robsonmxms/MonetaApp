import SwiftUI

struct SplashScreen: View {
    @State var animationText: Bool = false
    
    @State var go = false
    
    var body: some View {
        ZStack{
            Color("SplashBackground")
            
            Image("Moneta-logo")
                .opacity(animationText ? 1 : 0)
                .shadow(
                    color: Color("logoShadow"),
                    radius: 4,
                    x: 0,
                    y: 4
                )
        }
        .ignoresSafeArea()
        .background {
            NavigationLink(isActive: $go) {
                Login()
            } label: {
                EmptyView()
            }
            
        }
        .task {
            withAnimation(.linear(duration: 2)) {
                animationText.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                go = true
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashScreen()
            SplashScreen()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
