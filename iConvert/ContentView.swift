//
//  ContentView.swift
//  iConvert
//
//  Created by Nick on 2022-08-07.
//

import SwiftUI


enum ConversionType: String, CaseIterable {
    case temp = "Temp"
    case length = "Length"
    case time = "Time"
    case volume = "Volume"
    
}
enum TempUnit: String, CaseIterable {
    case celcius = "Celcius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

enum LengthUnit: String, CaseIterable {
    case meters = "Meters"
    case kilometers = "Kilometers"
    case feet = "Feet"
    case yards = "Yards"
    case miles = "Miles"
}

enum TimeUnit: String, CaseIterable {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
}

enum VolumeUnit: String, CaseIterable {
    case mililiters = "Mililiters"
    case liters = "Liters"
    case cups = "Cups"
    case pints = "Pints"
    case gallons = "Gallons"
}

struct ContentView: View {

    @State var currentConversionType = ConversionType.temp
    @State var currentTempUnit = TempUnit.celcius
    @State var currentLengthUnit = LengthUnit.meters
    @State var currentTimeUnit = TimeUnit.seconds
    @State var currentVolumeUnit = VolumeUnit.mililiters
    
    @State private var inputUnit = 0.0
        
    var body: some View {
        NavigationView {
            Form {
                // Type of conversion
                Section {
                    Picker("Conversion type", selection: $currentConversionType) {
                        ForEach(ConversionType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } header: {
                    Text("Conversion type")
                }
                // Convert input
                Section {
                    DisplayUnit(currentConversionType: $currentConversionType, currentTempUnit: $currentTempUnit, currentLengthUnit: $currentLengthUnit, currentTimeUnit: $currentTimeUnit, currentVolumeUnit: $currentVolumeUnit)
                    TextField("Enter your input", value: $inputUnit, format: .number)
                } header: {
                    Text("Convert from")
                }
            }
            .navigationTitle("iConvert")
        }
    }
}

struct DisplayUnit: View {
    
    @Binding var currentConversionType: ConversionType
    @Binding var currentTempUnit: TempUnit
    @Binding var currentLengthUnit: LengthUnit
    @Binding var currentTimeUnit: TimeUnit
    @Binding var currentVolumeUnit: VolumeUnit
    
    var body: some View {
        switch currentConversionType {
        case .temp:
            Picker("Temperature Unit", selection: $currentTempUnit) {
                ForEach(TempUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        case .length:
            Picker("Length Unit", selection: $currentLengthUnit) {
                ForEach(LengthUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        case .time:
            Picker("Time Unit", selection: $currentTimeUnit) {
                ForEach(TimeUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        case .volume:
            Picker("Volume Unit", selection: $currentVolumeUnit) {
                ForEach(VolumeUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
