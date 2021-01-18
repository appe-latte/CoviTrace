//
//  ContentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dataFetch = DataFetchRequest()
    
    var body: some View {
        
        
        Text("Hello World!")
        
        // MARK: BACKGROUND COLOUR CODE:
        // Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}

