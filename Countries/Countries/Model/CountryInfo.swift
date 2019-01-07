//
//  CountryInfo.swift
//  Countries
//
//  Created by Juhi Gautam on 05/01/19.
//  Copyright © 2019 Juhi Gautam. All rights reserved.
//

import UIKit

class CountryInfo: NSObject,NSCoding {
    
    var countryName: String?
    var region : String?
    var subregion: String?
    var population: String?
    var currencies: String?
    var languages: String?
    var flagUrl : String?
    
    init(countryName: String?,region: String?,subregion: String?,population: String?,languages: String?,flagUrl: String?,currencies: String?){
        self.countryName = countryName
        self.region = region
        self.subregion = subregion
        self.population = population
        self.languages = languages
        self.flagUrl = flagUrl
        self.currencies = currencies
        
    }
    
    // MARK: - NSCoding
    required init(coder aDecoder: NSCoder) {
        countryName = aDecoder.decodeObject(forKey: "countryName") as? String
        region = aDecoder.decodeObject(forKey: "region") as? String
        subregion = aDecoder.decodeObject(forKey: "subregion") as? String
        population = aDecoder.decodeObject(forKey: "population") as? String
        languages = aDecoder.decodeObject(forKey: "languages") as? String
        flagUrl = aDecoder.decodeObject(forKey: "flagUrl") as? String
        currencies = aDecoder.decodeObject(forKey: "currencies") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(countryName, forKey: "countryName")
        aCoder.encode(region, forKey: "region")
        aCoder.encode(subregion, forKey: "subregion")
        aCoder.encode(population, forKey: "population")
        aCoder.encode(languages, forKey: "languages")
        aCoder.encode(flagUrl, forKey: "flagUrl")
        aCoder.encode(currencies, forKey: "currencies")
    }

}
