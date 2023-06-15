import SwiftUI


struct CalendarRepresentableView: UIViewRepresentable {
    
    var year: Int;
    var month: Int;
    var day: Int;
    var controller: MyEventDatabase;
    var destinations: [Destination]
    
    init(year: Int, month: Int, day: Int, destinations: [Destination]) {
        self.year = year
        self.month = month
        self.day = day
        self.destinations = destinations
        self.controller = MyEventDatabase()
        self.controller.destinations = destinations
        self.controller.updateDestinationColors()
        
        
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        
        

        // Configure the Calendar and Locale for your calendar view to display.
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "en_US")

        // Set a date for the calendar view to initially make visible.
        calendarView.visibleDateComponents = DateComponents(calendar: gregorianCalendar, year: self.year, month: self.month, day: self.day)
        
        calendarView.delegate = controller
        
        controller.calendarView(calendarView, decorationFor: DateComponents(calendar: gregorianCalendar, year: self.year, month: self.year, day: self.day))
        
        return calendarView
    }

    func updateUIView(_ uiView: UICalendarView, context: Context) {
        // Update your UICalendarView instance here.
    }
    
    
}

struct CalendarRepresentableView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        
        
        var year: Int? {
                let calendar = Calendar.current
            return calendar.component(.year, from: Date())
            }

            var month: Int? {
                let calendar = Calendar.current
                return calendar.component(.month, from: Date())
            }

            var day: Int? {
                let calendar = Calendar.current
                return calendar.component(.day, from: Date())
            }
        
        
        
        CalendarRepresentableView(year: year!, month: month!, day: day!, destinations: [Destination()])
    }
}
