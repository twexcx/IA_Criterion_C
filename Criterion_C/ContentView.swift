import SwiftUI

struct SplashView: View {
    @State private var LogInOn = false // if log in screen works or not
     
    var body: some View {
        ZStack {
            LogInScreen()
                .opacity(LogInOn ? 1 : 0) //checking the variable

            ZStack {
                Color("BCG").ignoresSafeArea()
                
                VStack {
                    Text("Planora")
                        .font(.custom("Caveat-SemiBold", size: 70))
                        .padding()
                    Text("Plan smarter. Study better")
                        .font(.custom("Caveat-SemiBold", size: 40))
                        .foregroundStyle(.white)
                }
                
            }
            .opacity(LogInOn ? 0 : 1)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    LogInOn = true
                }
            }
        }
        .animation(.easeInOut(duration: 0.6), value: LogInOn)
    }
}

struct LogInScreen: View {
    var body: some View {
        NavigationStack {
            ZStack
            {
                Color("BCG")
                    .ignoresSafeArea()
                VStack{
                    Text("Planora")
                        .font(.custom("Caveat-SemiBold", size: 100))
                        .foregroundStyle(.LIC)
                    Spacer()
                    
                    TextField("Enter your email", text: .constant(""))
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .font(.custom("Caveat-SemiBold", size: 40))
                        .foregroundStyle(.BCG)
                        .background(.LIC)
                        .cornerRadius(25)
                    
                    TextField("Enter your password", text: .constant(""))
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .font(.custom("Caveat-SemiBold", size: 40))
                        .foregroundStyle(.BCG)
                        .background(.LIC)
                        .cornerRadius(25)

                    NavigationLink("Log in       ") {
                        MainScreen()
                    }
                    .background(.LIC)
                    .cornerRadius(30)
                    .font(.custom("Caveat-SemiBold", size: 40))
                    .foregroundStyle(.BCG)
                    
                    Spacer()
                    HStack{
                        NavigationLink("Forgot password ") {
                            FPScreen()
                        }
                        .fixedSize()
                        .font(.custom("Caveat-SemiBold", size: 30))
                        .foregroundStyle(.white)
                        .cornerRadius(20)
                        .padding(.trailing, 60.0)
                        .padding(.leading,30.0)

                        NavigationLink("Sign Up") {
                            SUScreen()
                        }
                        .fixedSize()
                        .font(.custom("Caveat-SemiBold", size: 30))
                        .cornerRadius(20)
                        .foregroundStyle(.white)
                        .padding(.trailing, 50.0)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct FPScreen: View { //forgot password screen
    var body: some View {
        Text("Change ur password")
    }
}

struct SUScreen: View { //signup screen
    var body: some View {
        Text("sign up")
    }
}

struct MainScreen: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.BCG)
                    .ignoresSafeArea()
                VStack{
                    Text("Planora")
                        .font(.custom("Caveat-SemiBold", size: 70))
                        .foregroundStyle(.LIC)
                    Spacer()
                    NavigationLink("Calendar                  ")
                    {
                        
                    }
                    .background(.LIC)
                    .cornerRadius(30)
                    .font(.custom("Caveat-SemiBold", size: 40))
                    .foregroundStyle(.BCG)
                    .padding(.all, 5)
                    NavigationLink("Study Sessions          ")
                    {
                        
                    }
                    .background(.LIC)
                    .cornerRadius(30)
                    .font(.custom("Caveat-SemiBold", size: 40))
                    .foregroundStyle(.BCG)
                    .padding()
                    NavigationLink("Profile                      ")
                    {
                        
                    }
                    .background(.LIC)
                    .cornerRadius(30)
                    .font(.custom("Caveat-SemiBold", size: 40))
                    .foregroundStyle(.BCG)
                    Spacer()
                }
                
                
            }
        }
    }
}

#Preview{
    LogInScreen()
}
