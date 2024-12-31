//
//  clsTable.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-12.
//

import Foundation
import SwiftyJSON

class clsCategoryItems : NSObject
{
    var CatId : Int!
    var CatName : String!
    var ChineseName : String!
    var CatItems : [clsMenuItems] = []
    var SubCatItems : [clsCategoryItems] = []
    var NoOfItemsSelected : Int = 0
    var LatestSelectedIndex : Int = 0
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        CatId = json[CategoryItemsKeys.CatId].intValue
        CatName = json[CategoryItemsKeys.CatName].stringValue
        ChineseName = json[CategoryItemsKeys.ChineseName].stringValue
        CatItems = json[CategoryItemsKeys.CatItems].arrayValue.compactMap(clsMenuItems.init)
        SubCatItems = json[CategoryItemsKeys.SubCatItems].arrayValue.compactMap(clsCategoryItems.init)
    }
}

class clsPrintItems : NSObject
{
    var Quantity : Int!
    var CatName : String!
    var ItemName : String!
    var SubCatName : String!
    var Preferences : [String] = []
    var ItemOptions : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        Quantity = json["quantity"].intValue
        CatName = json["category"].stringValue
        ItemName = json["item_name"].stringValue
        SubCatName = json["sub_cat"].stringValue
        Preferences = json["preference"].arrayValue.map({$0.stringValue})
        ItemOptions = json["options"].stringValue
    }
    
    init(catName : String, itemName : String) {
        self.CatName = catName
        self.ItemName = itemName
        self.SubCatName = ""
        self.ItemOptions = ""
    }
}

class clsCombinedPrintItems : NSObject
{
  
    var Items : [clsPrintItems] = []
    var isForGuest : Int!
    var IsTrayForBrk : Int!
    var IsTrayForLunch : Int!
    var IsTrayForDinner : Int!
    var IsEscortForBrk : Int!
    var IsEscortForLunch : Int!
    var IsEscortForDinner : Int!
    var RoomId : Int!
    var RoomName : String!
    var ResidentName : String!
    var SpecialInst : String!
    var FoodTexture : String!
   
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
      
        Items = json["Items"].arrayValue.compactMap(clsPrintItems.init)
        isForGuest = json["is_guest"].intValue
        IsTrayForBrk = json["is_brk_tray_service"].intValue
        IsTrayForLunch = json["is_lunch_tray_service"].intValue
        IsTrayForDinner = json["is_dinner_tray_service"].intValue
        IsEscortForBrk = json["is_brk_escort_service"].intValue
        IsEscortForLunch = json["is_lunch_escort_service"].intValue
        IsEscortForDinner = json["is_dinner_escort_service"].intValue
        RoomId = json["room_id"].intValue
        RoomName = json["room_name"].stringValue
        ResidentName = json["resident_name"].stringValue
        SpecialInst = json["special_instruction"].stringValue
        FoodTexture = json["food_texture"].stringValue
    }
    
  
}
