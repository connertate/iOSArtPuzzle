//
//  TimerView.swift
//  Art Puzzle
//
//  Created by Conner Tate on 12/7/22.
//

import SwiftUI

struct TimerView: View {
    
    //Put in VM!
    @ObservedObject var stopWatchManager = StopWatchManager()

    var body: some View {
        VStack {
            Text("0\(stopWatchManager.secondsElapsed / 60):\("\(stopWatchManager.secondsElapsed % 60 < 10 ? "0" : "")")\(stopWatchManager.secondsElapsed % 60)")
                .font(Font.custom("Courier", size: 35).weight(.semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .monospacedDigit()
                .onTapGesture {
                    stopWatchManager.start()
                }
        }
    }
}

class StopWatchManager: ObservableObject {
    
    
    @Published var secondsElapsed: Int = 0
    @Published var timerStarted = false
    
    var timer = Timer()
    
    func start() {
        if(!timerStarted) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.secondsElapsed += 1
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
