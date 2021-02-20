//
//  monteCarloEToMinusX.swift
//  monteCarloE-x
//
//  Created by Matthew Adas on 2/19/21.
//

import Foundation
import SwiftUI

class MonteCarloEToMinusX: MonteCarloCircle {
    
    @Published var integralString = ""
    @Published var xMax:Double = 1.0
    @Published var xMin:Double = 0.0
    @Published var yMax:Double = 1.0
    @Published var yMin:Double = 0.0
    
    /// calculates the Monte Carlo Integral of a e^(-x)
    ///
    /// - Parameters:
    ///   - radius: don't worry, radius is not actually used in this subclass. It's just an artifact from the parent
    ///   - maxGuesses: number of guesses to use in the calculaton
    /// - Returns: ratio of points inside to total guesses. Must mulitply by area of box in calling function
    
    override func calculateMonteCarloIntegral(radius: Double, maxGuesses: Double) -> Double {
        var numberOfGuesses = 0.0
        var pointsInRadius = 0.0
        var integral = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0)
        
        var newInsidePoints : [(xPoint: Double, yPoint: Double)] = []
        var newOutsidePoints : [(xPoint: Double, yPoint: Double)] = []
        
        
        while numberOfGuesses < maxGuesses {
        
            // Generate random x and y
            // compare exp(-x) to random y
            point.xPoint = Double.random(in: xMin...xMax)
            point.yPoint = Double.random(in: yMin...yMax)
            
            let realYFromBuiltInExp = exp(-point.xPoint)
            let randomYAtX = point.yPoint
            
            // if under the curve of e^(-x) add to inside points, otherwise outside
            if((realYFromBuiltInExp - randomYAtX) >= 0.0){
                pointsInRadius += 1.0
                
                newInsidePoints.append(point)
               
            }
            else {
                
                newOutsidePoints.append(point)

            }
            
            numberOfGuesses += 1.0
            
        }
        
        integral = Double(pointsInRadius)
        
        //Append the points to the arrays needed for the displays
        //Don't attempt to draw more than 250,000 points to keep the display updating speed reasonable.
        
        if ((totalGuesses < 1000001) || (insideData.count == 0)){
        
            insideData.append(contentsOf: newInsidePoints)
            outsideData.append(contentsOf: newOutsidePoints)
            
        }
        
        return integral
        
    }
    
    /// calculate the value of integral
    ///
    /// - Calculates the Value of e^(-x) using Monte Carlo Integration
    ///
    /// - Parameter sender: Any
    func calculateIntegral() {
        
        var maxGuesses = 0.0
        let boundingBoxCalculator = BoundingBox() ///Instantiates Class needed to calculate the area of the bounding box.
        
        
        maxGuesses = Double(guesses)
        
        // I already told you, radius doesn't matter it isn't used in this subclass
        totalIntegral = totalIntegral + calculateMonteCarloIntegral(radius: radius, maxGuesses: maxGuesses)
                
        totalGuesses = totalGuesses + guesses
        
        totalGuessesString = "\(totalGuesses)"
                
        pi = totalIntegral/Double(totalGuesses) * boundingBoxCalculator.calculateSurfaceArea(numberOfSides: 2, lengthOfSide1: (xMax-xMin), lengthOfSide2: (yMax-yMin), lengthOfSide3: 0.0)
        
        integralString = "\(pi)"
        
    }
}

