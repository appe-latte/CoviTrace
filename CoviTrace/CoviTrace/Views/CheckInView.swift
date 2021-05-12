//
//  CheckInView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/02/2021.
//

import SwiftUI
import CoreLocation
import Firebase
import FirebaseFirestore

struct CheckInView: View {
    let locationFetch = LocationFetch()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    var body: some View {
        VStack{
            VStack(){
                VStack{
                    // MARK: "Check-In" Button
                    Button(action: {
                        if let locationCheckin = self.locationFetch.lastLocation{
//                            print("Your location is: \(locationCheckin)")
                            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
                            let ceo: CLGeocoder = CLGeocoder()
                            center.latitude = locationCheckin.latitude
                            center.longitude = locationCheckin.longitude
                            
                            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
                            
                            ceo.reverseGeocodeLocation(loc, completionHandler:
                                                        {(placemarks, error) in
                                                            if (error != nil)
                                                            {
                                                                print("reverse geodcode fail: \(error!.localizedDescription)")
                                                            }
                                                            let pm = placemarks! as [CLPlacemark]
                                                            if pm.count > 0 {
                                                                let pm = placemarks![0]
                                                                var addressString : String = ""
                                                                if pm.subLocality != nil {
                                                                    addressString = addressString + pm.subLocality! + ", "
                                                                }
                                                                if pm.thoroughfare != nil {
                                                                    addressString = addressString + pm.thoroughfare! + ", "
                                                                }
                                                                if pm.locality != nil {
                                                                    addressString = addressString + pm.locality! + ", "
                                                                }
                                                                if pm.country != nil {
                                                                    addressString = addressString + pm.country!
                                                                }
                                                                
                                                                let formatter = DateFormatter()
                                                                formatter.locale = Locale(identifier: "nl_NL")
                                                                formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
                                                                
                                                                let now = Date()
                                                                let datetime = formatter.string(from: now)
                                                                
                                                                let db = Firestore.firestore();                                db.collection("checkins").document().setData(["userId": authModel.userSession!.uid, "latitude": locationCheckin.latitude, "longitude": locationCheckin.longitude, "date": datetime, "address": addressString])
                                                            }
                                                        })
                        } else {
                            print("Unknown location")
                        }
                    }, label: {
                        Text("CHECK-IN")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(12)
                    .padding()
                    
//                    Text("*Check-in data is only stored for a maximum of 14 days and is automatically deleted from our servers.")
//                        .foregroundColor(.white)
//                        .font(.footnote)
//                        .multilineTextAlignment(.center)
//                        .padding(5)
                }
                .padding(5.0)
                .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
                VStack {
                    HStack{
                        Text("Previous Check-ins")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(5)
                        
                        Spacer()
                    }
                    Divider()
                    
                    List(viewModel.results1) { results in
                        HStack {
                            Text(results.date).font(.system(size: 14)).padding(12)
                            Text(results.address)
                                .font(.system(size: 14))
                        }
                    }.onAppear() {
                        self.viewModel.fetchLocationData(id: authModel.userSession!.uid)
                    }
                }.background(Color.white)
            }
        }.navigationBarTitle("Location Check-in", displayMode: .inline)
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
