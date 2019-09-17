//
//  APIHelper.swift
//  GoogleBookApp
//
//  Created by Consultant on 9/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

enum URLStrings : String
{
    case searchGoogleBookVolumes = "https://www.googleapis.com/books/v1/volumes?q="
}

class BookAPI
{
    let session: URLSession
    var dataTask: URLSessionDataTask?
    static let sharedInstance : BookAPI = BookAPI()
    
    init()
    {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession.init(configuration: configuration)
    }
    
    func getDataWithQuery (searchString: String, successBlock:@escaping (Any)->Void, errorBlock:@escaping ((_ errorString: String?)->Void))
    {
        if (self.dataTask?.state == .running)
        {
            self.dataTask?.cancel()
        }
        
        let urlReq = self.makeGetRequest(searchString: searchString)
        self.dataTask = self.session.dataTask(with: urlReq) { (data, resp, err) in
            
            if (err != nil)
            {
                return
            }
            
            if ((resp as! HTTPURLResponse).statusCode == 200)
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                    
                    successBlock(json)
                }
                catch let err
                {
                    print("\(err.localizedDescription)")
                    let str = "Error reading Google Books response."
                    errorBlock(str)
                }
            }
        }
        
        self.dataTask!.resume()
    }
    
    func makeGetRequest(searchString: String) -> URLRequest
    {
        let urlStr = URLStrings.searchGoogleBookVolumes.rawValue + searchString
        let encodedURLStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: encodedURLStr!)
        let urlReq = URLRequest(url: url!)
        
        return urlReq
    }
    
}
