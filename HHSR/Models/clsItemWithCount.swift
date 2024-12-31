//
//  clsTable.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-12.
//

import Foundation
import SwiftyJSON

class clsItemWithCount : NSObject
{
    var ItemName : String!
    var ItemRealName : String!
    var TotalCount : Int = 0
    
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        ItemName = json["item_name"].stringValue
        ItemRealName = json["real_item_name"].stringValue
        TotalCount = json["total_count"].intValue
    }
}


class clsItemForChargesReport : NSObject
{
    var ItemName : String!
    var ItemRealName : String!
        
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        ItemName = json["item_name"].stringValue
        ItemRealName = json["real_item_name"].stringValue
    }
}
