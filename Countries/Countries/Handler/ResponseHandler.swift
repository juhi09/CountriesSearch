//
//  ResponseHandler.swift
//  Countries
//
//  Created by Juhi Gautam on 05/01/19.
//  Copyright © 2019 Juhi Gautam. All rights reserved.
//

import UIKit

class ResponseHandler: NSObject {
    
    static let sharedResponseHandler = ResponseHandler()
    private override init(){}
    
    func saveData(jsonData : NSArray){
        print(jsonData)
        var countriesInfoList = [CountryInfo]()
        
        for responseDict in jsonData{
            let dataDict = responseDict as! NSDictionary
            let countryName = dataDict["name"] as! String
            let region = dataDict["region"] as! String
            let subregion = dataDict["subregion"] as! String
            
            let populationDigit = dataDict["population"] as! NSNumber
            let population = populationDigit.stringValue
            
            let currenciesArray = dataDict["currencies"] as! NSArray
            let currenciesDict = currenciesArray[0] as! NSDictionary
            let currencies = currenciesDict["name"] as! String
            
            let languagesArray = dataDict["languages"] as! NSArray
            let languagesDict = languagesArray[0] as! NSDictionary
            let languages = languagesDict["name"] as! String
            
            let flagUrl = dataDict["flag"] as! String
            
            let countryInfo : CountryInfo = CountryInfo.init(countryName: countryName, region: region, subregion: subregion, population: population, languages: languages, flagUrl: flagUrl,currencies: currencies)
            countriesInfoList.append(countryInfo)
        }
        
        let userDefault = UserDefaults.standard
        if (UserDefaults.standard.value(forKey: "countryInfoList") != nil){
            userDefault.removeObject(forKey: "countryInfoList")
        }
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: countriesInfoList)
        userDefault.set(encodedData, forKey: "countryInfoList")
    }

}
