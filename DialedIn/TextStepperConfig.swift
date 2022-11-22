//
//  TextStepperConfig.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/21/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//

import Foundation
import TextFieldStepper
import SwiftUI

//Config Files for using TextStepper

// Convert Int16 to Double for Steppers
extension Int16 {
     var dbl: Double {
         get { Double(self) }
         set { self = Int16(newValue) }
     }
 }

// MARK:  - IMAGE - Setups


let decImageFill = TextFieldStepperImage(image: Image(systemName: "minus.square.fill"), color: Color.orange)
let incImageFill = TextFieldStepperImage(image: Image(systemName: "plus.square.fill"), color: Color.orange )
let decImage = TextFieldStepperImage(image: Image(systemName: "minus.square"), color: Color.orange)
let incImage = TextFieldStepperImage(image: Image(systemName: "plus.square"), color: Color.orange )
let gaugelow = TextFieldStepperImage(image: Image(systemName: "gauge.low"), color: Color.orange)
let gaugehigh = TextFieldStepperImage(image: Image(systemName: "gauge.high"), color: Color.orange )
let diallow = TextFieldStepperImage(image: Image(systemName: "dial.low"), color: Color.orange)
let dialhigh = TextFieldStepperImage(image: Image(systemName: "dial.high"), color: Color.orange )
let diallowfill = TextFieldStepperImage(image: Image(systemName: "dial.low.fill"), color: Color.orange)
let dialhighfill = TextFieldStepperImage(image: Image(systemName: "dial.high.fill"), color: Color.orange )


// MARK: - CONFIGS -

var frontAirConfig = TextFieldStepperConfig(
    unit: " - PSI",
    label: "Air Volume",
    increment: 0.5,
    minimum: 1.0,
    maximum: 200.0,
    decrementImage: decImage,
    incrementImage: incImage,
    minimumDecimalPlaces: 1,
    maximumDecimalPlaces: 1)

var coilConfig = TextFieldStepperConfig(
    unit: "",
    label: "Spring",
    increment: 25,
    minimum: 0.0,
    maximum: 800.0,
    decrementImage: decImage,
    incrementImage: incImage,
    minimumDecimalPlaces: 0,
    maximumDecimalPlaces: 0)

var sagConfig = TextFieldStepperConfig(
    unit: " - SAG(mm)",
    label: "",
    increment: 1.0,
    minimum: 1.0,
    maximum: 100.0,
    decrementImage: decImage,
    incrementImage: incImage,
    minimumDecimalPlaces: 0,
    maximumDecimalPlaces: 0)

var tokenConfig = TextFieldStepperConfig(
    unit: "",
    label: "Tokens",
    increment: 1.0,
    minimum: 0.0,
    maximum: 10.0,
    decrementImage: decImage,
    incrementImage: incImage,
    minimumDecimalPlaces: 0,
    maximumDecimalPlaces: 0)

var clickConfig = TextFieldStepperConfig(
    unit: "",
    label: "CLICKS",
    increment: 1.0,
    minimum: 0.0,
    maximum: 25.0,
    decrementImage: diallow,
    incrementImage: dialhigh,
    minimumDecimalPlaces: 0,
    maximumDecimalPlaces: 0)

var clickConfig2 = TextFieldStepperConfig(
    unit: "",
    label: "CLICKS",
    increment: 1.0,
    minimum: 0.0,
    maximum: 25.0,
    decrementImage: diallowfill,
    incrementImage: dialhighfill,
    minimumDecimalPlaces: 0,
    maximumDecimalPlaces: 0)

var tireConfig = TextFieldStepperConfig(
    unit: " - PSI",
    label: "Front Tire Pressure",
    increment: 0.1,
    minimum: 0.0,
    maximum: 100.0,
    decrementImage: decImage,
    incrementImage: incImage,
    minimumDecimalPlaces: 1,
    maximumDecimalPlaces: 1)



