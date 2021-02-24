//
//  CheckInView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/02/2021.
//

import SwiftUI
import CoreLocation

struct CheckInView: View {

    let locationFetch = LocationFetch()

    var body: some View {
        ZStack{
            CheckInTopView()
            
            VStack{
                // MARK: "Check-In" Button
                Button(action: {
                    if let locationCheckin = self.locationFetch.lastLocation{
                        print("Your location is: \(locationCheckin)")
                    } else {
                        print("Unknown location")
                    }
                }, label: {
                    Text("CHECK-IN")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(15)
                .padding()
                
                Text("*Check-in data is only stored for a maximum of 14 days and is automatically deleted from our servers.")
                    .foregroundColor(.white)
                    //                .lineLimit(nil)
                    .font(.footnote)
                    .padding(5)
                Spacer()
            }
        }.navigationBarTitle("Recent Check-ins")
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
    }
}
