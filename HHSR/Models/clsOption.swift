//
//  clsTable.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-12.
//

import Foundation
import SwiftyJSON

class clsOption : NSObject
{
    var Id : Int!
    var Name : String!
    var CName : String!
    var IsSelected : Int!
    var ItemQuantity : Int!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        Id = json["id"].intValue
        Name = json["name"].stringValue
        CName = json["c_name"].stringValue
        IsSelected = json["is_selected"].intValue
        ItemQuantity = json["item_count"].intValue
    }
    
}