//
//  NotificationsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/06/2021.
//

import SwiftUI

struct NotificationsView: View {
    
    
    var body: some View {
        ZStack
        {
            Background()
            
            VStack {
                // MARK: Notifications List
                VStack {
                    HStack{
                        Text("Notifications")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(5)
                        
                        Spacer()
                    }
                    
                    Divider()
                    //                    List(viewModel.appointments) { appointments in
                    List() {
                        VStack(alignment: .leading) {
                            HStack {
                                //                                Text(appointments.appointDate)
                                Text("")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Text("")
                                    //                                Text(appointments.appointTitle)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .fontWeight(.semibold)
                            }
                            //                            Text(appointments.appointLocation)
                            Text("")
                                .font(.subheadline)
                        }
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    .onAppear() {
                        //                        self.viewModel.fetchData(id: authModel.userSession!.uid)
                    }
                }
                
            }.navigationBarTitle("Notifications", displayMode: .inline)
        }
    }
}


struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
