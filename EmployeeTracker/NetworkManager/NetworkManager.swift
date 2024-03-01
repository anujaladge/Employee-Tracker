//
//  NetworkManager.swift
//  EmployeeTracker
//
//  Created by Anuja Ladge on 15/02/24.
//

import Foundation

class NetworkManager{
    
    func getData<T:Decodable>(urlString:String,model:T.Type,completionHandler:@escaping((T)->Void)){
        
        guard let url = URL(string: urlString) else {return}
        
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            
            if error == nil{
                
                let response = response as? HTTPURLResponse
                print(response?.statusCode)
                
                do{
                    let data = try JSONDecoder().decode(model.self, from: data!)
                    completionHandler(data)
                }
                catch let error{
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
        
    }
    
    func postData(urlString:String,employeeData:[String:Any]){
        
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: employeeData, options: .prettyPrinted)
        }
        catch let err{
            print(err.localizedDescription)
        }
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if error == nil{
                
                let response = response as? HTTPURLResponse
                print(response?.statusCode)
                
                do{
                    let data = try JSONDecoder().decode(Employee.self, from: data!)
                    print(data)
                }
                catch let error{
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    func putData(urlString:String,id:Int,data:[String:Any],completionHandler:@escaping((Bool)-> Void)){
        
        guard let url = URL(string: "\(urlString)/\(id)") else { 
            print("invalid url")
            return  }
        print(url)
        
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        }
        catch let err{
            print(err.localizedDescription,"error jsonserialization")
        }
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if error == nil{
                
                let response = response as? HTTPURLResponse
                print(response?.statusCode)
                
                
                do{
                    let data = try JSONDecoder().decode(Employee.self, from: data!)
                    print(data)
                    completionHandler(true)
                }
                catch let err{
                    print(err.localizedDescription,"error while decoding")
                }
            }
        }
        dataTask.resume()
        
        
    }
    
    func deleteData(urlString:String,id:Int){
        
        guard let url = URL(string: "\(urlString)/\(id)") else { return }
        print(url)
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if error == nil{
                
                let response = response as? HTTPURLResponse
                print(response?.statusCode)
                
                do{
                    let data = try JSONDecoder().decode(Employee.self, from: data!)
                    print(data)
                }
                catch let err{
                    print(err.localizedDescription)
                }
            }
        }
        dataTask.resume()
        
    }
    
    
}
