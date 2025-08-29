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
    @State private var FPOn = false //if forgot password screen works
    @State private var SUOn = false //if Sign Uo screen works
    var body: some View {
        ZStack{
            
            Color("BCG")
                .ignoresSafeArea()
            VStack{
                Text("Planora")
                    .font(.custom("Caveat-SemiBold", size: 100))
                    .foregroundStyle(.LIC)
                Spacer()
                
                TextField("Enter your email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .font(.custom("Caveat-SemiBold", size: 40))
                    .foregroundStyle(.black)
                    .background(.LIC)
                    .cornerRadius(25)
                
                
                TextField("Enter your password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .font(.custom("Caveat-SemiBold", size: 40))
        
                    .foregroundStyle(.BCG)
                    .background(.LIC)
                    .cornerRadius(25)
                Button("log in       ") {
                    
                    
                }
                .background(.LIC)
                .cornerRadius(30)
                .font(.custom("Caveat-SemiBold", size: 40))
                .foregroundStyle(.BCG)
                
                Spacer()
                HStack{
               
                    Button ("Forgot password     ")
                    {
                        FPScreen()
                    }
                    .onAppear()
                    {
                        DispatchQueue.main
                            withAnimation(.easeInOut(duration: 0.8))
                    }
                    .font(.custom("Caveat-SemiBold", size: 25))
                    .foregroundStyle(.white)
                    .cornerRadius(20)
                    .padding(.trailing, 60.0)
                    .padding(.leading,30.0)
                    Button ("Sign Up      ")
                    {
                        
                    }
                    .font(.custom("Caveat-SemiBold", size: 25))
                    .cornerRadius(20)
                    .foregroundStyle(.white)
                    .padding(.trailing, 50.0)
                }
                Spacer()
            }
        }
            }
}
struct FPScreen: View   {
    var body: some View
    {
        Text("Change ur password")
    }
}
struct SUScreen: View {
    var body: some View
    {
        Text("sign up")
    }
}
#Preview{
    LogInScreen()
}
