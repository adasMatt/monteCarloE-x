//
//  ContentView.swift
//  Shared
//
//  Modified by Matt Adas on 2/20/2021 from original code by Jeff Terry.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]


struct ContentView: View {
    @EnvironmentObject var plotDataModel :PlotDataClass
    
    //@State var pi = 0.0
    @State var totalGuesses = 0.0
    @State var totalIntegral = 0.0
    @State var radius = 1.0
    @State var guessString = "23458"
    @State var totalGuessString = "0"
    //@State var piString = "0.0"
    @State var integralString = "0.0"
    @State var yMax = 0.0
    @State var yMin = 0.0
    @State var xMax = 0.0
    @State var xMin = 0.0
    @State var error = "0.0"
    
    // Setup the GUI to monitor the data from the Monte Carlo Integral Calculator
    //@ObservedObject var monteCarlo = MonteCarloCircle(withData: true)
    @ObservedObject var monteCarlo = MonteCarloEToMinusX(withData: true)
    
    //Setup the GUI View
    var body: some View {
        HStack{
            
            VStack{
                
                VStack(alignment: .center) {
                    Text("Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Guesses", text: $guessString)
                        .padding()
                }
                .padding(.top, 5.0)
                
                VStack(alignment: .center) {
                    Text("Total Guesses")
                        .font(.callout)
                        .bold()
                    TextField("# Total Guesses", text: $totalGuessString)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("integral e^(-x)")
                        .font(.callout)
                        .bold()
                    TextField("", text: $integralString)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("log10 of error")
                        .font(.callout)
                        .bold()
                    TextField("", text: $error)
                        .padding()
                }
                
                Button("Cycle Calculation", action: {self.calculateIntegral()})
                    .padding()
                
                Button("Clear", action: {self.clear()})
                    .padding(.bottom, 5.0)
                
                Button("Plot error", action: {self.calculateNIntegrals()})
                
            }
            .padding()
            
            
            
            VStack{
                
                CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                    .setPlotPadding(left: 10)
                    .setPlotPadding(right: 10)
                    .setPlotPadding(top: 10)
                    .setPlotPadding(bottom: 10)
                    .padding()
                
                Divider()
                
                
                //DrawingField
                drawingView(redLayer:$monteCarlo.insideData, blueLayer: $monteCarlo.outsideData, xMin: $monteCarlo.xMin, xMax: $monteCarlo.xMax, yMin: $monteCarlo.yMin, yMax: $monteCarlo.yMax)
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .drawingGroup()
                // Stop the window shrinking to zero.
                Spacer()
            }
            
            
        }
    }
    
    
    func calculateIntegral() {
        
        monteCarlo.guesses = Int(guessString)!
        monteCarlo.totalGuesses = Int(totalGuessString) ?? Int(0.0)
        
        let _ = calculateMonteCarloIntegral()
    }
    
    func calculateMonteCarloIntegral() -> Double {
        
        var errorCalc = 0.0
        
        monteCarlo.calculateIntegral() // I replaced calculatePI() in class MonteCarloEToMinusX
        monteCarlo.xMin = 0.0
        monteCarlo.xMax = 1.0
        monteCarlo.yMin = 0.0
        monteCarlo.yMax = 1.0
        
        totalGuessString = monteCarlo.totalGuessesString
        
        integralString =  monteCarlo.integralString
        
        // determine how the error changes as a function of N
        let e_MinusXIntegral = monteCarlo.pi
        let actualEMinus_xIntegral = -exp(-1.0) + exp(0.0)
        
        var numerator = e_MinusXIntegral - actualEMinus_xIntegral
        if(numerator == 0.0) {numerator = 1.0E-16}
        
        errorCalc = log10(abs(numerator)/actualEMinus_xIntegral)
    
        error = "\(errorCalc)"
        
        return errorCalc
        
    }
    
    func calculateNIntegrals() {
        
        plotDataModel.changingPlotParameters.yMax = 1.0
        plotDataModel.changingPlotParameters.yMin = -7.0
        plotDataModel.changingPlotParameters.xMax = 10.0
        plotDataModel.changingPlotParameters.xMin = -2.0
        plotDataModel.changingPlotParameters.xLabel = "log10 of # guesses"
        plotDataModel.changingPlotParameters.yLabel = "log10 of error"
        plotDataModel.changingPlotParameters.lineColor = .red()
        plotDataModel.changingPlotParameters.title = "integral error e^(-x)"
        
        plotDataModel.zeroData()
        var plotData :[plotDataType] =  []
        
        let nValues = [10, 20, 50, 100, 200, 500, 1000, 10000, 50000, 100000, 500000, 1000000, 5000000, 10000000]
        
        for item in nValues {
            monteCarlo.guesses = item

            let error = calculateMonteCarloIntegral()
            let dataPoint: plotDataType = [.X: log10(Double(item)), .Y: error]
            plotData.append(contentsOf: [dataPoint])
            
            plotDataModel.calculatedText += "\(item)\t\(error)\n"
        }
        
        plotDataModel.appendData(dataPoint: plotData)
        
    }
    
    func clear(){
        
        guessString = "23458"
        totalGuessString = "0.0"
        integralString =  ""
        monteCarlo.totalGuesses = 0
        monteCarlo.totalIntegral = 0.0
        monteCarlo.insideData = []
        monteCarlo.outsideData = []
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
