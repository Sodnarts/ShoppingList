//
//  CalculateTime.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 14/01/2022.
//

import Foundation

func CalculateTime(duration: Int) -> String {
    let minutes = duration / 60
    let seconds = duration - (minutes * 60)
    
    var minutesString = ""
    var secondsString = ""
    
    minutesString = (minutes < 10) ? String(format: "0%d", minutes) : String(format: "%d", minutes)
    secondsString = (seconds < 10) ? String(format: "0%d", seconds) : String(format: "%d", seconds)
        
    return String(format: "%@:%@", minutesString, secondsString)
}
