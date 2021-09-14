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
    @State var showSingleDoseSheetView = false
    @State var showFirstDoseSheetView = false
    @State var showSecondDoseSheetView = false
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
                                    Button(action: {
                                        self.showSingleDoseSheetView.toggle()
                                    }, label: {
                                            Text("Log Single Dose Vaccination")
                                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                .fontWeight(.semibold)
                                                .padding(.trailing, 20)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .sheet(isPresented: $showSingleDoseSheetView) {
                                        AddSingleDoseView()
                                    }
                                }
                            }
                            
                            // MARK: Log First Vacc Dose
                            HStack {
                                VStack{
                                    Button(action: {
                                        self.showFirstDoseSheetView.toggle()
                                    }, label: {
                                            Text("Log First Vaccination Dose")
                                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                .fontWeight(.semibold)
                                                .padding(.trailing, 25)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .sheet(isPresented: $showFirstDoseSheetView) {
                                        AddFirstDoseView()
                                    }
                                }
                            }
                            
                            // MARK: Log Second Vacc Dose
                            HStack {
                                VStack{
                                    Button(action: {
                                        self.showSecondDoseSheetView.toggle()
                                    }, label: {
                                            Text("Log Second Vaccination Dose")
                                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                .fontWeight(.semibold)
                                                .padding(.trailing, 20)
                                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .sheet(isPresented: $showSecondDoseSheetView) {
                                        AddSecondDoseView()
                                    }
                                }
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

