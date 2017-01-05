//
//  ErrorViewModel.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum ErrorViewModelType {
    case location
    case network
}

class ErrorViewModel {

    let title: String
    let message: String
    let type: ErrorViewModelType

    init(title: String, message: String, type: ErrorViewModelType) {
        self.title = title
        self.message = message
        self.type = type
    }

}
