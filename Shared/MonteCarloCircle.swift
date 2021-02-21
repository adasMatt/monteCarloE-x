//
//  MonteCarloCircle.swift
//  Monte Carlo Integration
//
//  Created by Jeff Terry on 12/31/20.
//

import Foundation
import SwiftUI

class MonteCarloCircle: NSObject, ObservableObject {
    
    @Published var insideData = [(xPoint: Double, yPoint: Double)]()
    @Published var outsideData = [(xPoint: Double, yPoint: Double)]() 
    @Published var totalGuessesString = ""
    @Published var guessesString = ""
    @Published var piString = ""
    
    var pi = 0.0
    var guesses = 1
    var totalGuesses = 0
    var totalIntegral = 0.0
    var radius = 1.0
    
    init(withData data: Bool){
        
        super.init()
        
        insideData = []
        outsideData = []
        
    }


    /// calculate the value of π
    ///
    /// - Calculates the Value of π using Monte Carlo Integration
    ///
    /// - Parameter sender: Any
    func calculatePI() {
        
        var maxGuesses = 0.0
        let boundingBoxCalculator = BoundingBox() ///Instantiates Class needed to calculate the area of the bounding box.
        
        
        maxGuesses = Double(guesses)
        
        totalIntegral = totalIntegral + calculateMonteCarloIntegral(radius: radius, maxGuesses: maxGuesses)
        
        totalGuesses = totalGuesses + guesses
        
        totalGuessesString = "\(totalGuesses)"
        
        ///Calculates the value of π from the area of a unit circle
        
        pi = totalIntegral/Double(totalGuesses) * boundingBoxCalculator.calculateSurfaceArea(numberOfSides: 2, lengthOfSide1: 2.0*radius, lengthOfSide2: 2.0*radius, lengthOfSide3: 0.0)
        
        piString = "\(pi)"
        
       
        
    }

    /// calculates the Monte Carlo Integral of a Circle
    ///
    /// - Parameters:
    ///   - radius: radius of circle
    ///   - maxGuesses: number of guesses to use in the calculaton
    /// - Returns: ratio of points inside to total guesses. Must mulitply by area of box in calling function
    func calculateMonteCarloIntegral(radius: Double, maxGuesses: Double) -> Double {
        
        var numberOfGuesses = 0.0
        var pointsInRadius = 0.0
        var integral = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0)
        var radiusPoint = 0.0
        
        var newInsidePoints : [(xPoint: Double, yPoint: Double)] = []
        var newOutsidePoints : [(xPoint: Double, yPoint: Double)] = []
        
        
        while numberOfGuesses < maxGuesses {
            
            /* Calculate 2 random values within the box */
            /* Determine the distance from that point to the origin */
            /* If the distance is less than the unit radius count the point being within the Unit Circle */
            point.xPoint = Double.random(in: -radius...radius)
            point.yPoint = Double.random(in: -radius...radius)
            
            radiusPoint = sqrt(pow(point.xPoint,2.0) + pow(point.yPoint,2.0))
            
            
            // if inside the circle add to the number of points in the radius
            if((radius - radiusPoint) > 0.0){
                pointsInRadius += 1.0
                
                
                newInsidePoints.append(point)
               
            }
            else { //if outside the circle do not add to the number of points in the radius
                
                
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

}
