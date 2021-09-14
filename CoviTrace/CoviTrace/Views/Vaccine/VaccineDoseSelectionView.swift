//
//  VaccineDoseSelectionView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/09/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct VaccineDoseSelectionView: View {
    @State var showSheetView = false
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                // MARK: Profile Summary
                VStack(alignment: .center){
                    
                    
                    // MARK: Options
                    HStack {
                        VStack(alignment: .center) {
                            Spacer(minLength: 5)
                            
                            // MARK: Log Single Dose
                            HStack {
                                VStack{
                                    
                                    // MARK: Log Single Dose Vaccination
                                    Button(action: {
                                        self.showSheetView.toggle()
                                    }, label: {
                                            Text("Log Single Dose Vaccination")
                                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                .fontWeight(.semibold)
                                                .padding(.trailing, 20)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .sheet(isPresented: $showSheetView) {
                                        AddSingleDoseView()
                                    }
                                }
                                
                            }
                            
                            // MARK: Log First Vacc Dose
                            HStack {
                                NavigationLink(
                                    destination: CheckInView()){
                                        Text("Log First Vaccination Dose")
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            .fontWeight(.semibold)
                                            .padding(.trailing, 25)
                                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(10)
                            }
                            
                            // MARK: Log Second Vacc Dose
                            HStack {
                                NavigationLink(
                                    destination: TestResultView()){
                                        Text("Log Second Vaccination Dose")
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            .fontWeight(.semibold)
                                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(10)
                            }
                            
                            Spacer()

                        }.padding()
                        
                    }
                    Spacer()
                    
                }
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
    
    struct VaccineDoseSelectionView_Previews: PreviewProvider {
        static var previews: some View {
            VaccineDoseSelectionView()
        }
    }

