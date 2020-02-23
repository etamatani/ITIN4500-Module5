//
//  QuizModel.swift
//  QuizApp
//
//  Created by Eisuke Tamatani on 1/8/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    
    func questionsRetrieved(_ questions:[Question])
    
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // Fetch the questions
        getRemoteJasonFile()
        
        
    }
    
    func getlocalJasonFile() {
        
        // Get bundle path to jason file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double check that the path isn't nil
        guard path != nil else {
            print("Couldn't find the jason data file")
            return
        }
        
        // Create URL object from the path
        let url = URL(fileURLWithPath: path!)
        
        do {
            // Get the data from url
            let data = try Data(contentsOf: url)
            
            // Try to decode the data into object
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // Notify the delegate of the parsed object
            delegate?.questionsRetrieved(array)
        }
        catch {
            // Error: Couldn't download the data at that URL
        }
    }
    
    func getRemoteJasonFile() {
        
        // Get a URL Object
        let urlString = "https://codewithchris.com/code/QuestionData.json"
        
        let url = URL(string: urlString)
        
        
        guard url != nil else {
            print("Couldn't create the URL object")
            return
        }
        
        
        // Get a URL Session object
        let session = URLSession.shared
        
        // Get a data task object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there wasn't an error
            if error == nil && data != nil {
                
                do {
                    
                    // Create a JSON Decoder object
                    let decoder = JSONDecoder()
                    
                    // Parse the JSON
                    let array = try decoder.decode([Question].self, from: data!)
                    
                    // Use the main thread to notify the view controller for UI Work
                    DispatchQueue.main.async {
                        // Notify the delegate
                        self.delegate?.questionsRetrieved(array)
                    }
                        
                }
                catch {
                    print("Couldn't parse JSON")
                }
                
                
            }
            
            
        }
        
        // Call resume on the dsta tasl
        dataTask.resume()
    }
    
}
