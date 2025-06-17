//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by User on 08.06.2025.
//
import Foundation

struct  AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: (() -> Void)?
}
