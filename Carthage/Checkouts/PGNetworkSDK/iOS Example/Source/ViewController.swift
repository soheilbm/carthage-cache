//
//  ViewController.swift
//  iOS Example
//
//  Created by Suraj Pathak on Sep 22, 2016.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import UIKit
import PGNetworkSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNetwork()
        testAgent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNetwork(){
        let network = PGNetworkSDK.sharedInstance
        network.baseUrl = "https://api.propertyguru.com"
        network.country = "sg"
        network.locale = "en"
        network.networkAccessToken = "00-Et6DeYku-LS2UzPGWDYix7jjmbPfNsOYlWlRWzyMJLmEDyjNQhyeP3~w5W~B6MScEfR-Iiqukp0a143DxYvDAPj3SVrQ2gTQNttOkxcxKa3cfpSDkNFuPRFVdLs6QEfRsXUW30KfnydfOKyk1BIddx4PrclJ3aWVqpRXFXIrW7HxwkVjQ8ZGTgLr7lQR7tI"
        
        let request = PGListingDetailRequest.init("19491861")
        request.send(success: { (value) in
            print(value)
            }) { (failure) in
                print(failure)
        }
    }
    
    func testAgent() {
        let key = "en/agent/search/Wendy%20Lee"
        var request = PGAgentRequest(agentType: key, otherParameters: [:])
        request.baseUrl  = "https://api.propertyguru.com.sg"
        request.send(success: { response in
        	print(response)
        }) { err in
            print(err)
        }
    }


}

