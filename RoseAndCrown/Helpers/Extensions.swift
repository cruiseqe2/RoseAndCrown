//
//  Extensions.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 15/08/2024.
//

import Foundation

extension Int {
    func convertedToString() -> String {
        String(format: "%.2f", Double(self) / 100.00)
    }
}

extension String {
    func convertedToInt() -> Int {
        Int(((Double(self) ?? 0.0) * 100.00).rounded())
    }
}
