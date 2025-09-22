import SwiftUI
import Foundation

struct SplashView: View
{
    @State private var LogInOn = false // if log in screen works or not
     
    var body: some View
    {
        ZStack
        {
            LogInScreen()
                .opacity(LogInOn ? 1 : 0) //checking the variable

            ZStack
            {
                
                Color("BCG").ignoresSafeArea()
                
                VStack
                {
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
        .onAppear
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    LogInOn = true
                }
            }
        }
        .animation(.easeInOut(duration: 0.6), value: LogInOn)
    }
}

struct LogInScreen: View
{
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Color("BCG")
                    .ignoresSafeArea()
                VStack
                {
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

                    NavigationLink("Log in       ")
                    {
                        MainScreen()
                    }
                    .background(.LIC)
                    .cornerRadius(30)
                    .font(.custom("Caveat-SemiBold", size: 40))
                    .foregroundStyle(.BCG)
                    
                    Spacer()
                    HStack{
                        
                        NavigationLink("Forgot password ")
                        {
                            FPScreen()
                        }
                        .fixedSize()
                        .font(.custom("Caveat-SemiBold", size: 30, relativeTo: .title3))
                        .foregroundStyle(.white)
                        .cornerRadius(20)
                        .padding(.trailing, 60.0)
                        .padding(.leading,30.0)

                        NavigationLink("Sign Up")
                        {
                            SUScreen()
                        }
                        .fixedSize()
                        .font(.custom("Caveat-SemiBold", size: 30, relativeTo: .title3))
                        .cornerRadius(20)
                        .foregroundStyle(.white)
                        .padding(.trailing, 50.0)
                    }
                    Spacer()
                }
            }
        }
        .tint(Color("LIC"))
    }
       
}

struct FPScreen: View
{ //forgot password screen
    var body: some View
    {
        Text("Change ur password")
    }
}

struct SUScreen: View {
    //signup screen
    var body: some View
    {
        Text("sign up")
    }
}

struct MainScreen: View
{
    
    var body: some View
    {
        NavigationStack{
            
            ZStack
            {
                Color(.BCG)
                    .ignoresSafeArea()
                VStack
                {
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
        .tint(Color("LIC"))
    }
}
struct CalendarScreen: View
{
    @EnvironmentObject var deadlineStorage: DeadlineStorage
    @EnvironmentObject var dateHolder: DatehHolder
    @State private var showingEditView = false
    @State private var deadlineToEdit: LocalDeadline? = nil
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Color(.BCG)
                    .ignoresSafeArea()
                VStack(alignment: .leading)
                {
                    // 1. Calendar Date Picker
                    DatePicker("Select Date", selection: $dateHolder.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .accentColor(Color(.CMC))
                        .padding()
                        .background(Color(.CMC))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    // 2. List of events for the selected day
                    let selectedDate = dateHolder.date
                    let calendar = Calendar.current
                    let deadlinesForDay = deadlineStorage.deadlines.filter
                    {
                        calendar.isDate($0.startDate, equalTo: selectedDate, toGranularity: .day)
                    }
                    .sorted(by: {$0.startDate < $1.startDate})
                    Text("Events on \(selectedDate.formatted(date: .abbreviated,time: .omitted))")
                        .font(.custom("Caveat-SemiBold", size: 40, relativeTo: .title3))
                        .foregroundStyle(.CMC)
                        .padding(.horizontal, 6)
                    
                    ScrollView
                    {
                        LazyVStack(spacing: 10)
                        {
                            ForEach(deadlinesForDay)
                            {
                                deadline in
                                VStack (alignment: .leading, spacing: 4)
                                {
                                    Text(deadline.title)
                                        .font(.custom("Caveat-SemiBold", size: 22, relativeTo: .title3))
                                        
                                    Text(timeRangeText(for: deadline))
                                        .font(.custom("Caveat-SemiBold", size: 18, relativeTo: .title3))
                                        .padding()
                                        .background(Color(.LIC))
                                        .cornerRadius(15)
                                        .foregroundStyle(.BCG)
                                    
                                    .onTapGesture
                                    {
                                        deadlineToEdit = deadline
                                        showingEditView = true
                                    }
                                      
                                    if deadlinesForDay.isEmpty {
                                        Text("No dea for this date")
                                            .font(.custom("Caveat-SemiBold", size: 20))
                                            .foregroundStyle(.LIC)
                                            .padding(.top, 20)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            }
                        }
                    }
             
                }
            }
            .navigationTitle("My Calendar")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar
            {
                // Add event button
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button
                    {
                        deadlineToEdit = nil
                        showingEditView = true
                    }
                    label:
                    {
                       Image(systemName: "plus")
                            .font(.title2)
                    }
                    .foregroundColor(.LIC)
                }
            }
            .sheet(isPresented: $showingEditView)
            {
                DeadlineEditView(deadline: deadlineToEdit)
                    .environmentObject(deadlineStorage)
            }
        }
        .tint(Color("LIC"))
    }
   
    func timeRangeText(for deadline: LocalDeadline) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let startStr = df.string(from: deadline.startDate)
        let endStr = df.string(from: deadline.endDate)
        return "\(startStr) - \(endStr) • Priority: \(deadline.priority.symbol)"
    }
}
struct DeadlineEditView: View
{
    @EnvironmentObject var deadlineStorage: DeadlineStorage
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var priority: Priority
    
    private let existingDeadline: LocalDeadline? //if not nil, we are editing this deadline
    
    //Custom initialiser to set default
    init(deadline: LocalDeadline? = nil)
    {
        self.existingDeadline = deadline
        _title = State(initialValue: deadline?.title ?? "")
        _startDate = State(initialValue: deadline?.startDate ?? Date())
        _endDate = State(initialValue: deadline?.endDate ??
        Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date())
        _priority = State(initialValue: deadline?.priority ?? .oneStar)
    }
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Color(.BCG)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16)
                {
                    Text("Title:")
                        .font(.custom("Caveat-SemiBold", size: 22))
                        .foregroundStyle(.LIC)
                    TextField("EventTitle", text: $title)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.LIC))
                        .cornerRadius(8)
                        .font(.custom("Caveat-SemiBold", size: 22))
                        .foregroundStyle(Color(.BCG))
                    
                    //Start date and time
                    Text("Start date and time:")
                        .font(.custom("Caveat-SemiBold", size: 22))
                        .foregroundStyle(.LIC)
                    DatePicker("Start Date", selection: $startDate,displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .foregroundColor(Color(.LIC))
                    
                    //End date and time
                    Text("End Date & Time:")
                        .font(.custom("Caveat-SemiBold", size: 22))
                        .foregroundStyle(.LIC)
                    DatePicker("End Date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .foregroundColor(Color(.LIC))
                    Text("Priority:")
                        .font(.custom("Caveat-SemiBold", size: 22))
                        .foregroundStyle(.LIC)
                    Picker("Priority", selection: $priority)
                    {
                        Text("*").tag(Priority.oneStar)
                        Text("**").tag(Priority.twoStars)
                        Text("***").tag(Priority.threeStars)
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 8)
                    
                    //Delete button (only showed in edit mode)
                    if let deadline = existingDeadline {
                        Button(role: .destructive)
                        {
                            deadlineStorage.deleteDeadline(deadline)
                            dismiss()
                        }
                    label:
                        {
                            Text("Delete deadline")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding()
            }
            .navigationTitle(existingDeadline == nil ? "New event" : "Edit event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar
            {
                // Cancel button
                ToolbarItem(placement: .topBarLeading)
                {
                    Button("Cancel")
                    {
                        dismiss()
                    }
                    .font(.custom("Caveat-SemiBold", size: 20))
                }
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button("Save")
                    {
                        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        let finalTitle = trimmedTitle.isEmpty ? "(No title)" : trimmedTitle
                        let start = startDate <= endDate ? startDate : endDate
                        let end = startDate <= endDate ? endDate : startDate
                        let newOrUpdated: LocalDeadline
                        if let oldDeadline = existingDeadline
                        {
                         //GIve same ID
                            newOrUpdated = LocalDeadline(id: oldDeadline.id, title: finalTitle, startDate: start, endDate: end, priority: priority)
                        }
                        else
                        {
                            newOrUpdated = LocalDeadline(id: UUID(), title: finalTitle, startDate: start, endDate: end, priority: priority)
                        }
                        deadlineStorage.addOrUpdateDeadline(newOrUpdated)
                        dismiss()
                    }
                    .font(.custom("Caveat-SemiBold", size: 20))
                }
            }
        }
        .tint(Color("LIC"))
    }
}
