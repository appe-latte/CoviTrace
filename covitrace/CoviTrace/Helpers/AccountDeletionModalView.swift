//
//  AccountDeletionModalView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 28/01/2022.
//

import SwiftUI

struct AccountDeletionModalView<Content: View> : View {
    @GestureState private var dragState = DragState.inactive
    @Binding var isShown : Bool
    
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold = modalHeight * (2/3)
        if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold{
            isShown = false
        }
    }
    
    var modalHeight : CGFloat = 150
    
    var content: () -> Content
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
            }
            .onEnded(onDragEnded)
        return Group {
            ZStack {
                Spacer()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .background(isShown ? purple.opacity( 0.5 * fraction_progress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(dragState.translation.height), inverted: true)) : Color.clear)
                    .animation(Animation.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                self.isShown = false
                            })
                
                VStack {
                    Spacer()
                    
                    // MARK: Bottom Sheet
                    ZStack {
                        Color.white.opacity(0.9)
                            .frame(width: UIScreen.main.bounds.size.width, height: 200)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        self.content()
                            .padding()
                            .padding(.bottom, 65)
                            .frame(width: UIScreen.main.bounds.size.width, height: 200)
                            .clipped()
                    }
                    .offset(y: isShown ? ((self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : 0) : modalHeight)
                    .animation(Animation.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(drag)
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
