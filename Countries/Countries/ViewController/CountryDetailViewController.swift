//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Juhi Gautam on 06/01/19.
//  Copyright © 2019 Juhi Gautam. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subRegionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    var countryDetailInfo : CountryInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updatUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updatUI(){
        self.title = "Country Detail"
        self.nameLabel.text = countryDetailInfo.countryName
        self.regionLabel.text = countryDetailInfo.region
        self.subRegionLabel.text = countryDetailInfo.subregion
        self.populationLabel.text = countryDetailInfo.population
        self.currenciesLabel.text = countryDetailInfo.currencies
        self.languageLabel.text = countryDetailInfo.languages
        self.flagImageView.dowloadFromServer(link: countryDetailInfo.flagUrl!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
