//
//  AppointmentVIewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI

class AppointmentViewModel : ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    @Published var newAppointment = false
}
