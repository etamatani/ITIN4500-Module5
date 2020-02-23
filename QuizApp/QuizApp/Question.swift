//
//  Question.swift
//  QuizApp
//
//  Created by Eisuke Tamatani on 1/8/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
    
}
