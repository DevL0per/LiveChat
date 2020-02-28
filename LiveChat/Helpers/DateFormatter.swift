//
//  DateFormatter.swift
//  LiveChat
//
//  Created by Роман Важник on 22/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

class MyDateFormatter {
    let dateformatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.locale = .current
        dateformatter.dateFormat = "HH:mm"
        return dateformatter
    }()
    
    func formatToString(from unixDate: Double) -> String {
        let date = Date(timeIntervalSince1970: unixDate)
        let stringDate = dateformatter.string(from: date)
        return stringDate
    }
    
}
