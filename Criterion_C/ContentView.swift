import SwiftUI
import Foundation

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
                        CalendarScreen()
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
struct CalendarScreen: View {
    @EnvironmentObject var dateHolder: Dateholder
    var body: some View {
        ZStack
        {
            Color(.BCG)
                .ignoresSafeArea()
            VStack(spacing: 1)
            {
                DateScrollerView()
                    .environmentObject(dateHolder)
                    .padding()
                dayOfWeekStack
                CalendarGrid
            }
           
        }
       
    }
    var dayOfWeekStack: some View{
        HStack(spacing: 1){
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
             
        }
    }
    var CalendarGrid: some View
    {
        VStack(spacing: 1){
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekDate(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)

            ForEach(0..<6)
            {
                row in
                HStack(spacing: 1)
                {
                    ForEach(1..<8){
                        column in
                        let count = column + (row + 7) //what day we should be displaying
                        CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth:daysInMonth, daysInPrevMonth: daysInPrevMonth)
                            .environmentObject(dateHolder)
                    }
                }
            }
             
        }
        .frame(maxHeight: .infinity)
    }
}
extension Text
{
    func dayOfWeek() -> some View
    {
        self.frame(maxWidth:.infinity)
            .padding(.top,1)
            .lineLimit(1)
            .font(.custom("Caveat-SemiBold", size: 25))
    }
    
}
