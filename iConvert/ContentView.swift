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

class UnitConverter: ObservableObject {
    @Published var inputUnit: Double?
    @Published var outputUnit: Double = 0
}

struct ContentView: View {

    @State var currentConversionType = ConversionType.temp
    @State var currentTempUnit = TempUnit.celcius
    @State var currentLengthUnit = LengthUnit.meters
    @State var currentTimeUnit = TimeUnit.seconds
    @State var currentVolumeUnit = VolumeUnit.mililiters
    
    @State var convertToTempUnit = TempUnit.celcius
    @State var convertToLengthUnit = LengthUnit.meters
    @State var convertToTimeUnit = TimeUnit.seconds
    @State var convertToVolumeUnit = VolumeUnit.mililiters
    
    @ObservedObject var uc: UnitConverter = UnitConverter()
        
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
                    DisplayUnit(currentConversionType: $currentConversionType,
                                currentTempUnit: $currentTempUnit,
                                currentLengthUnit: $currentLengthUnit,
                                currentTimeUnit: $currentTimeUnit,
                                currentVolumeUnit: $currentVolumeUnit,
                                uc: uc)
                        .onChange(of: uc.inputUnit) { newValue in
                            convertValue()
                        }
                        .onChange(of: currentTempUnit) { newValue in
                            convertValue()
                        }
                        .onChange(of: currentLengthUnit) { newValue in
                            convertValue()
                        }
                        .onChange(of: currentTimeUnit) { newValue in
                            convertValue()
                        }
                        .onChange(of: currentVolumeUnit) { newValue in
                            convertValue()
                        }
                    TextField("Enter your input", value: $uc.inputUnit, format: .number)
                } header: {
                    Text("Convert from")
                }
                // Convert output unit
                Section {
                    DisplayUnit(currentConversionType: $currentConversionType,
                                currentTempUnit: $convertToTempUnit,
                                currentLengthUnit: $convertToLengthUnit,
                                currentTimeUnit: $convertToTimeUnit,
                                currentVolumeUnit: $convertToVolumeUnit,
                                uc: uc)
                        .onChange(of: convertToTempUnit) { newValue in
                            convertValue()
                        }
                        .onChange(of: convertToLengthUnit) { newValue in
                            convertValue()
                        }
                        .onChange(of: convertToTimeUnit) { newValue in
                            convertValue()
                        }
                        .onChange(of: convertToVolumeUnit) { newValue in
                            convertValue()
                        }
                } header: {
                    Text("Convert to")
                }
                // Output
                Section {
                    Text(String(uc.outputUnit))
                } header: {
                    Text("Converted result")
                }
            }
            .navigationTitle("iConvert")
        }
    }
    func convertValue() {
        
        switch currentConversionType {
        case .temp:
            let tempInC: Double
            
            switch currentTempUnit {
            case .celcius:
                tempInC = uc.inputUnit ?? 0
            case .kelvin:
                tempInC = (uc.inputUnit ?? 0) - 273.15
            case .fahrenheit:
                tempInC = ((uc.inputUnit ?? 0) - 32) * 5/9
            }
            
            switch convertToTempUnit {
            case .celcius:
                uc.outputUnit = tempInC
            case .fahrenheit:
                uc.outputUnit = (tempInC * 9/5) + 32
            case .kelvin:
                uc.outputUnit = tempInC + 273.15
            }
        case .length:
            let lengthInMeters: Double
            
            switch currentLengthUnit {
            case .meters:
                lengthInMeters = uc.inputUnit ?? 0
            case .kilometers:
                lengthInMeters = (uc.inputUnit ?? 0) * 1000
            case .feet:
                lengthInMeters = (uc.inputUnit ?? 0) / 3.2808399
            case .yards:
                lengthInMeters = (uc.inputUnit ?? 0) / 1.094
            case .miles:
                lengthInMeters = (uc.inputUnit ?? 0) * 1609
            }
            
            switch convertToLengthUnit {
            case .meters:
                uc.outputUnit = lengthInMeters
            case .kilometers:
                uc.outputUnit = lengthInMeters / 1000
            case .feet:
                uc.outputUnit = lengthInMeters * 3.2808399
            case .yards:
                uc.outputUnit = lengthInMeters * 1.094
            case .miles:
                uc.outputUnit = lengthInMeters / 1609
            }
        case .time:
            let lengthInSeconds: Double
            
            switch currentTimeUnit {
            case .seconds:
                lengthInSeconds = uc.inputUnit ?? 0
            case .minutes:
                lengthInSeconds = (uc.inputUnit ?? 0) * 60
            case .hours:
                lengthInSeconds = (uc.inputUnit ?? 0) * 3600
            case .days:
                lengthInSeconds = (uc.inputUnit ?? 0) * 86400
            }
            
            switch convertToTimeUnit {
            case .seconds:
                uc.outputUnit = lengthInSeconds
            case .minutes:
                uc.outputUnit = lengthInSeconds / 60
            case .hours:
                uc.outputUnit = lengthInSeconds / 3600
            case .days:
                uc.outputUnit = lengthInSeconds / 86400
            }
        case .volume:
            let sizeInML: Double
            
            switch currentVolumeUnit {
            case .mililiters:
                sizeInML = uc.inputUnit ?? 0
            case .liters:
                sizeInML = (uc.inputUnit ?? 0) * 1000
            case .cups:
                sizeInML = (uc.inputUnit ?? 0) * 236.5882365
            case .pints:
                sizeInML = (uc.inputUnit ?? 0) / 473.176473
            case .gallons:
                sizeInML = (uc.inputUnit ?? 0) * 4546.09
            }
            
            switch convertToVolumeUnit {
            case .mililiters:
                uc.outputUnit = sizeInML
            case .liters:
                uc.outputUnit = sizeInML / 1000
            case .cups:
                uc.outputUnit = sizeInML / 236.5882365
            case .pints:
                uc.outputUnit = sizeInML * 473.176473
            case .gallons:
                uc.outputUnit = sizeInML / 4546.09
            }
        }
    }
}

struct DisplayUnit: View {
    
    @Binding var currentConversionType: ConversionType
    @Binding var currentTempUnit: TempUnit
    @Binding var currentLengthUnit: LengthUnit
    @Binding var currentTimeUnit: TimeUnit
    @Binding var currentVolumeUnit: VolumeUnit
    
    @ObservedObject var uc: UnitConverter
        
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
