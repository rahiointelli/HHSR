//
//  clsMenuItems.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-12.
//

import Foundation
import SwiftyJSON

class clsMenuItems : NSObject
{
    var ItemId : Int!
    var ItemName : String!
    var ItemQuantity : Int!
    var Comment : String! = ""
    var OrderId : Int = 0
    var ItemImage : String!
    var ItemType : String!
    var ChineseName : String!
    var ItemOptions : [clsOption] = []
    var Preferences : [clsPreference] = []
    var isExpanded : Int = 0
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        ItemId = json[ItemsKeys.ItemId].intValue
        ItemName = json[ItemsKeys.ItemName].stringValue
        ItemQuantity = json[ItemsKeys.ItemQuantity].intValue
        Comment = json[ItemsKeys.Comment].stringValue
        OrderId = json[ItemsKeys.OrderId].intValue
        ItemImage = json[ItemsKeys.ItemImage].stringValue
        ItemType = json[ItemsKeys.ItemType].stringValue
        ChineseName = json[ItemsKeys.ChineseName].stringValue
        ItemOptions = json[ItemsKeys.ItemOptions].arrayValue.compactMap(clsOption.init)
        Preferences = json[ItemsKeys.Preferences].arrayValue.compactMap(clsPreference.init)
        if(json["is_expanded"].exists())
        {
            isExpanded = json["is_expanded"].intValue
        }
    }
    
    init(ItmId : Int, ItmName : String, ItmQuant : Int) {
        self.ItemId = ItmId
        self.ItemName = ItmName
        self.ItemQuantity = ItmQuant
    }
}
