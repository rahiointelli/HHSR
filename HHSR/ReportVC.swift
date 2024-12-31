//
//  MealItemsVC.swift
//  DiningApp
//
//  Created by Intelli on 2022-10-31.
//

import UIKit
import FSCalendar
import SpreadsheetView

class ReportVC: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance, SpreadsheetViewDataSource
{

    @IBOutlet weak var lblRoomName : UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var btn_calendarMonth: UIButton!
    @IBOutlet weak var calendar_container_height: NSLayoutConstraint!
    @IBOutlet weak var calendar_height: NSLayoutConstraint!
    @IBOutlet weak var full_calendar: FSCalendar!
    @IBOutlet weak var Mealsegment: UIStackView!
    @IBOutlet weak var btnBrk: UIButton!
    @IBOutlet weak var btnLunch: UIButton!
    @IBOutlet weak var btnDinner: UIButton!
    @IBOutlet weak var calendar_top_height: NSLayoutConstraint!
    @IBOutlet weak var act_indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblSelectedRoom: UILabel!
    @IBOutlet weak var lblRoomSelection: UILabel!
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    @IBOutlet weak var btnToday: UIButton!
    @IBOutlet weak var lblNoReport: UILabel!
        
    var selectedRoomName : String = ""
    var selectedRoomID : Int = 0
    var selectedDate = Date()
    let CYear = Calendar.current.component(.year, from: Date())
    var formatter = DateFormatter()
    var arItemList : [clsReport] = []
    var arrBreakfastItems : [clsReport] = []
    var arrLunchItems : [clsReport] = []
    var arrDinnerItems : [clsReport] = []
    var arrBrkItemTitle : [clsItemWithCount] = []
    var arrLunchItemTitle : [clsItemWithCount] = []
    var arrDinnerItemTitle : [clsItemWithCount] = []
    var currentSelectedIndex =    0
    var lastMenuDate : Date = Date()
    var arRoomList : [clsReportRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Calendar.current.isDate(self.lastMenuDate, inSameDayAs:self.selectedDate))
        {}
        else if (self.lastMenuDate.compare(Date()) == ComparisonResult.orderedAscending)
        {            
            self.btnToday.isHidden = true
        }
        
        self.btnToday.setTitle("today".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
        
        self.spreadsheetView.isHidden = true
        self.spreadsheetView.bounces = false
        self.spreadsheetView.alwaysBounceVertical = false
        self.lblRoomName.text = "report".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        self.spreadsheetView.dataSource = self
        self.spreadsheetView.register(RoomNumberCell.self, forCellWithReuseIdentifier: String(describing: RoomNumberCell.self))
        self.spreadsheetView.register(ItemNameCell.self, forCellWithReuseIdentifier: String(describing: ItemNameCell.self))
        self.spreadsheetView.register(ItemQuantityCell.self, forCellWithReuseIdentifier: String(describing: ItemQuantityCell.self))
        self.spreadsheetView.register(ItemTotalCountCell.self, forCellWithReuseIdentifier: String(describing: ItemTotalCountCell.self))
        self.spreadsheetView.gridStyle = .none
            
        // Do any additional setup after loading the view.
        
        let frame = CGRect(x: 0, y: 48.5, width: UIScreen.main.bounds.size.width/3, height: 1.5)
        let BrkborderBottom = UIView(frame: frame)
        BrkborderBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        BrkborderBottom.tag = 1111
        let LunchborderBottom = UIView(frame: frame)
        LunchborderBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        LunchborderBottom.tag = 1111
        let DnrborderBottom = UIView(frame: frame)
        DnrborderBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        DnrborderBottom.tag = 1111
        self.btnBrk.addSubview(BrkborderBottom)
        self.btnLunch.addSubview(LunchborderBottom)
        self.btnDinner.addSubview(DnrborderBottom)
        
        self.btnBrk.setTitle("brk".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
        self.btnLunch.setTitle("lunch".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
        self.btnDinner.setTitle("dnr".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode), for: .normal)
                       
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.calendar_top_height.constant = 52
        }
        self.compareSelectedDate()
                     
        self.full_calendar.dataSource = self
        self.full_calendar.delegate = self
        self.full_calendar.scrollDirection = .vertical
        self.full_calendar.allowsMultipleSelection = false
        self.full_calendar.pagingEnabled = false
        //self.full_calendar.setScope(FSCalendarScope.week, animated: false)
        //self.full_calendar.appearance.headerMinimumDissolvedAlpha = 0
        self.full_calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase;
        self.full_calendar.appearance.weekdayTextColor = UIColor.black
        self.full_calendar.appearance.headerTitleColor = UIColor.black
        self.full_calendar.appearance.selectionColor = CommonUtility.shared.hexStringToUIColor(hex: "102139")
        self.full_calendar.appearance.todayColor = CommonUtility.shared.hexStringToUIColor(hex: "ef433b")
        //self.full_calendar.appearance.titleTodayColor = calendar.appearance.titleDefaultColor
        self.full_calendar.appearance.borderRadius = 0.4
        self.full_calendar.appearance.titleFont = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica", size: 24.0)! : UIFont(name: "Helvetica", size: 19.0)!
        self.full_calendar.appearance.headerTitleFont = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica-Bold", size: 22.0)! : UIFont(name: "Helvetica-Bold", size: 17.0)!
        self.full_calendar.appearance.weekdayFont = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica-Bold", size: 17.0)! : UIFont(name: "Helvetica-Bold", size: 12.0)!
        self.full_calendar.select(self.selectedDate, scrollToDate: true)
        self.full_calendar.placeholderType = .none
        
        if(AppDelegate.sharedDelegate().LanguagePref == 1)
        {
            self.full_calendar.locale = NSLocale(localeIdentifier: "zh-Hans") as Locale
        	self.calendar.locale = NSLocale(localeIdentifier: "zh-Hans") as Locale
        }
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.calendar.scrollDirection = .horizontal
        self.calendar.allowsMultipleSelection = false
        self.calendar.setScope(FSCalendarScope.week, animated: false)
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0
        self.calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase;
        self.calendar.appearance.weekdayTextColor = UIColor.black
        self.calendar.appearance.headerTitleColor = UIColor.white // UIColor.black
        self.calendar.appearance.selectionColor = CommonUtility.shared.hexStringToUIColor(hex: "102139")
        //self.calendar.appearance.todayColor = nil
        //self.calendar.appearance.titleTodayColor = calendar.appearance.titleDefaultColor
        self.calendar.appearance.borderRadius = 0.4
        self.calendar.appearance.todayColor = CommonUtility.shared.hexStringToUIColor(hex: "ef433b")
        //calendar.appearance.titleTodayColor = UIColor.white
        self.calendar.appearance.titleFont = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica", size: 24.0)! : UIFont(name: "Helvetica", size: 19.0)!
        self.calendar.appearance.headerTitleFont = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica-Bold", size: 22.0)! : UIFont(name: "Helvetica-Bold", size: 17.0)!
        self.calendar.appearance.weekdayFont = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica-Bold", size: 17.0)! : UIFont(name: "Helvetica-Bold", size: 12.0)!
        self.calendar.select(self.selectedDate, scrollToDate: true)
        let mnth = self.selectedDate.toString(dateFormat: "MMMM")
        let cl_mnth = mnth.localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        self.btn_calendarMonth.setTitle(cl_mnth, for: .normal)
        self.setSelectedDateLabel()
        self.CallReportListService()
    }
      
    func setSelectedDateLabel()
    {
        let mnth = self.selectedDate.toString(dateFormat: "MMMM")
        let cl_mnth = mnth.localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        
        if(Calendar.current.isDateInToday(self.selectedDate))
        {
            let td = "today".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
            self.lblSelectedDate.text = "\(td) \(cl_mnth) \(self.selectedDate.toString(dateFormat: "d, yyyy"))"
        }
        else
        {
            self.lblSelectedDate.text = "\(cl_mnth) \(self.selectedDate.toString(dateFormat: "d, yyyy"))"
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar)
    {
        self.setTitleAsCalMonthInHeader(calendar)
    }
    
    func setTitleAsCalMonthInHeader(_ calendar: FSCalendar)
    {
        var cDate = calendar.currentPage
        //print("current date is \(cDate.toString(dateFormat: "yyyy MM dd"))")
        formatter.dateFormat = "yyyy MM dd"
        let lastDtOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: formatter.date(from: cDate.toString(dateFormat: "yyyy MM dd"))!)!
        if(Calendar.current.component(.month, from: cDate) != Calendar.current.component(.month, from: lastDtOfWeek))
        {
            let MidDtOfWeek = Calendar.current.date(byAdding: .day, value: 3, to: formatter.date(from: cDate.toString(dateFormat: "yyyy MM dd"))!)!
            if(Calendar.current.component(.month, from: cDate) != Calendar.current.component(.month, from: MidDtOfWeek))
            {
                cDate = MidDtOfWeek
            }
            
        }
        
        let yr = Calendar.current.component(.year, from: cDate)
        let mnth = cDate.toString(dateFormat: "MMMM")
        let cl_mnth = mnth.localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        if(yr == CYear)
        {
            self.btn_calendarMonth.setTitle(cl_mnth, for: .normal)
        }
        else
        {
        let tl = "\(cl_mnth) \(cDate.toString(dateFormat: "yyyy"))"
            self.btn_calendarMonth.setTitle(tl, for: .normal)
        }
    }
    
    @IBAction func btnBack_Clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
      
    @IBAction func btnToday_Clicked(_ sender: Any)
    {
        self.calendar.select(Date(), scrollToDate: true)
        self.selectedDate = Date()
        self.compareSelectedDate()
        self.setSelectedDateLabel()
        self.CallReportListService()
        
        if(self.full_calendar.isHidden == false)
        {
            self.setTitleAsCalMonthInHeader(self.calendar)
            self.full_calendar.isHidden = true
        }
        
        self.full_calendar.select(Date(), scrollToDate: true)
      //  self.CallLogListService()
    }
    
    @IBAction func btnCalendar_Clicked(_ sender: Any)
    {
        if(self.full_calendar.isHidden == true)
        {
            self.full_calendar.setCurrentPage(self.calendar.currentPage, animated: true)
        }
        else
        {
            self.calendar.setCurrentPage(self.full_calendar.currentPage, animated: true)
        }
        
        self.full_calendar.isHidden = !self.full_calendar.isHidden
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        //return  Date() //stDate!
        formatter.dateFormat = "yyyy MM dd"
        var minDate = Calendar.current.date(byAdding: .month, value: -1, to: formatter.date(from: Date().toString(dateFormat: "yyyy MM dd"))!)!
        if self.lastMenuDate.compare(minDate) == ComparisonResult.orderedAscending
        {
            NSLog("date1 before date2");
            minDate = Calendar.current.date(byAdding: .month, value: -1, to: formatter.date(from: self.lastMenuDate.toString(dateFormat: "yyyy MM dd"))!)!
        }        
        return minDate
        
    }

    func maximumDate(for calendar: FSCalendar) -> Date {
//        formatter.dateFormat = "yyyy MM dd"
//        let endDate = Calendar.current.date(byAdding: .month, value: 2, to: formatter.date(from: Date().toString(dateFormat: "yyyy MM dd"))!)!
//        let range = Calendar.current.range(of: .day, in: .month, for: endDate)!
//        let edDate = formatter.date(from: "\(endDate.toString(dateFormat: "yyyy MM")) \(range.count)")
//        return edDate!
        return self.lastMenuDate
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let dateString = date.toString(dateFormat: "yyyy/MM/dd")
        let todaydate = Date().toString(dateFormat: "yyyy/MM/dd")
        if (dateString == todaydate) {
            return CommonUtility.shared.hexStringToUIColor(hex: "ef433b")
        }

        return appearance.selectionColor
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectedDate = date
        self.compareSelectedDate()
        self.setSelectedDateLabel()
        self.CallReportListService()
        
        if(calendar == self.full_calendar)
        {
            self.calendar.select(date, scrollToDate: true)
            self.full_calendar.isHidden = true
        }
        else
        {
            self.full_calendar.select(date, scrollToDate: true)
        }
        
        let diff = Date().interval(ofComponent: .day, fromDate: self.selectedDate)
          print("difference is \(diff)")
        
        //self.CallLogListService()
    }
   
    func compareSelectedDate()
    {
        if(Calendar.current.isDate(Date(), inSameDayAs:self.selectedDate))
        {
            print("both dates are same")
            let hours = (Calendar.current.component(.hour, from: Date()))
            if(hours < 10)
            {
               self.currentSelectedIndex = 0
            }
            else if(hours < 15)
            {
                self.currentSelectedIndex = 1
            }
            else
            {
                self.currentSelectedIndex = 2
            }
        }
        else if Date().compare(self.selectedDate) == ComparisonResult.orderedDescending
        {
            self.currentSelectedIndex = 0
            NSLog("date1 after date2");
        } else if Date().compare(self.selectedDate) == ComparisonResult.orderedAscending
        {
            self.currentSelectedIndex =   0
            NSLog("date1 before date2");
        }
    }
 
    
    func setUpMealCategoryArray(selectedIndex : Int)
    {
        self.currentSelectedIndex = selectedIndex
       // self.CallOrderListService()
        if(selectedIndex == 0)
        {
            self.lblNoReport.isHidden = (self.arrBrkItemTitle.count == 0) ? false : true
            self.spreadsheetView.isHidden = (self.arrBrkItemTitle.count == 0) ? true : false
            self.btnBrk.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            self.btnLunch.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnDinner.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.arItemList = self.arrBreakfastItems
            
            self.btnBrk.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory } })
            self.btnLunch.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnDinner.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
        }
        else if(selectedIndex == 1)
        {
            self.lblNoReport.isHidden = (self.arrLunchItemTitle.count == 0) ? false : true
            self.spreadsheetView.isHidden = (self.arrLunchItemTitle.count == 0) ? true : false
            self.btnBrk.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnLunch.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            self.btnDinner.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.arItemList = self.arrLunchItems
            
            self.btnBrk.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnLunch.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory} })
            self.btnDinner.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })

        }
        else
        {
            self.lblNoReport.isHidden = (self.arrDinnerItemTitle.count == 0) ? false : true
            self.spreadsheetView.isHidden = (self.arrDinnerItemTitle.count == 0) ? true : false
            self.btnBrk.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnLunch.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnDinner.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            self.arItemList = self.arrDinnerItems
            
            self.btnBrk.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnLunch.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnDinner.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory} })
        }
        
        self.spreadsheetView.reloadData()
    }
    
    @IBAction func btnMeal_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        self.setUpMealCategoryArray(selectedIndex: btn.tag)
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        if(self.currentSelectedIndex == 0)
        {
            return 1 + self.arrBrkItemTitle.count
        }
        else if(self.currentSelectedIndex == 1)
        {
            return 1 + self.arrLunchItemTitle.count
        }
        else
        {
            return 1 + self.arrDinnerItemTitle.count
        }
            
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + 1 + self.arRoomList.count
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if(column == 0){return 60}
        let available_width = (UIScreen.main.bounds.size.width - 60)
        if(self.currentSelectedIndex == 0)
        {
            return (available_width-CGFloat(self.arrBrkItemTitle.count)-2)/CGFloat(self.arrBrkItemTitle.count)
        }
        else if(self.currentSelectedIndex == 1)
        {
            return (available_width-CGFloat(self.arrLunchItemTitle.count)-2)/CGFloat(self.arrLunchItemTitle.count)
        }
        else
        {
            return (available_width-CGFloat(self.arrDinnerItemTitle.count)-2)/CGFloat(self.arrDinnerItemTitle.count)
        }
        //return 45
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
       // if(row == 0){return 80}
      return 40
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        
        if(indexPath.row == 0 && indexPath.column == 0)
        {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemNameCell.self), for: indexPath) as! ItemNameCell
            cell.label.text = "#"
            cell.backgroundColor = UIColor.ColorCodes.reportTitleBgColor
            cell.gridlines = .all(.solid(width: 1, color: UIColor.ColorCodes.reportTitleBgColor))
            return cell
        }
        else if(indexPath.row == 1 && indexPath.column == 0)
        {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: RoomNumberCell.self), for: indexPath) as! RoomNumberCell
            cell.label.text = "total".localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
            cell.gridlines.bottom = .solid(width: 1, color: .lightGray)
            cell.gridlines.right = .solid(width: 1, color: .white)
            return cell
        }
        else if(indexPath.row > 1 && indexPath.column == 0)
        {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: RoomNumberCell.self), for: indexPath) as! RoomNumberCell
                       
            let attributedString = NSMutableAttributedString.init(string: self.arRoomList[indexPath.row - 2].RoomName)
            // Add Underline Style Attribute.
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                NSRange.init(location: 0, length: attributedString.length));
            cell.label.attributedText = attributedString
            cell.label.isUserInteractionEnabled = true
            cell.label.tag = indexPath.row
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapRecognized(_:)))
            cell.label.addGestureRecognizer(tapGesture)
            
            cell.label.textColor = (self.arRoomList[indexPath.row - 2].HasSpecialInst == 0) ? UIColor.black : UIColor.ColorCodes.homeSelectedCategory
            cell.gridlines.bottom = .solid(width: 1, color: .lightGray)
            cell.gridlines.right = .solid(width: 1, color: .white)
            return cell
        }
        else if(indexPath.row == 0) && indexPath.column > 0
        {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemNameCell.self), for: indexPath) as! ItemNameCell
            if(self.currentSelectedIndex == 0)
            {
                cell.label.text = self.arrBrkItemTitle[indexPath.column - 1].ItemName
            }
            else if(self.currentSelectedIndex == 1)
            {
                cell.label.text = self.arrLunchItemTitle[indexPath.column - 1].ItemName
            }
            else
            {
                cell.label.text = self.arrDinnerItemTitle[indexPath.column - 1].ItemName
            }
            cell.backgroundColor = UIColor.ColorCodes.reportTitleBgColor
            cell.gridlines = .all(.solid(width: 1, color: UIColor.ColorCodes.reportTitleBgColor))
            //self.arItemList[indexPath.column - 1].ItemName
            return cell
        }
        else if(indexPath.row == 1)
        {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemTotalCountCell.self), for: indexPath) as! ItemTotalCountCell
            if(self.currentSelectedIndex == 0)
            {
                cell.label.text = "\(self.arrBrkItemTitle[indexPath.column - 1].TotalCount)"
            }
            else if(self.currentSelectedIndex == 1)
            {
                cell.label.text = "\(self.arrLunchItemTitle[indexPath.column - 1].TotalCount)"
            }
            else
            {
                cell.label.text = "\(self.arrDinnerItemTitle[indexPath.column - 1].TotalCount)"
            }
            cell.gridlines.bottom = .solid(width: 1, color: .lightGray)
            cell.gridlines.right = .solid(width: 1, color: .white)
            return cell
        }
        else
        {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemQuantityCell.self), for: indexPath) as! ItemQuantityCell
            if(self.currentSelectedIndex == 0)
            {
                cell.label.text = "\(self.arrBreakfastItems[indexPath.row - 2].Quantity[indexPath.column - 1])"
            }
            else if(self.currentSelectedIndex == 1)
            {
                cell.label.text = "\(self.arrLunchItems[indexPath.row - 2].Quantity[indexPath.column - 1])"
            }
            else
            {
                cell.label.text = "\(self.arrDinnerItems[indexPath.row - 2].Quantity[indexPath.column - 1])"
            }
            
            cell.gridlines.bottom = .solid(width: 1, color: .lightGray)
            cell.gridlines.right = .solid(width: 1, color: .white)
            return cell
            
        }
    }
    
    @objc func tapRecognized(_ sender: UITapGestureRecognizer)
    {
        let lbl = sender.view as! UILabel
       // print("Room clicked \(lbl.tag)")
        var isRedirect = false
        if(self.currentSelectedIndex == 0 && self.arRoomList[lbl.tag - 2].HasBrkOrder == 1)
        {
            isRedirect = true
        }
        else if(self.currentSelectedIndex == 1 && self.arRoomList[lbl.tag - 2].HasLunchOrder == 1)
        {
            isRedirect = true
        }
        else if(self.currentSelectedIndex == 2 && self.arRoomList[lbl.tag - 2].HasDinnerOrder == 1)
        {
            isRedirect = true
        }
        
        if(isRedirect)
        {
            let printVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrintVC") as! PrintVC
            printVC.selectedRoomID = self.arRoomList[lbl.tag - 2].RoomId
            printVC.selectedRoomName = self.arRoomList[lbl.tag - 2].RoomName
            printVC.selectedDate = self.selectedDate
            printVC.currentSelectedIndex = self.currentSelectedIndex
            printVC.isForGuest = self.arRoomList[lbl.tag - 2].isForGuest
            self.navigationController?.pushViewController(printVC, animated: false)
        }
        else
        {
            self.showMessageAlert(message: "Order not placed.")
        }
    }
    
    func CallReportListService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
//API.order_list_api
        //"get-categorywise-data"
        NetworkUtilities.shared.makePOSTRequest(with: API.baseURL + "get-report-data", parameters: ["room_id" : "101", "date" : self.selectedDate.toString(dateFormat: "yyyy-MM-dd"), "type" : self.currentSelectedIndex + 1]) { (response) in
            if(response.error == nil)
            {
                self.view.isUserInteractionEnabled = true
                self.act_indicator.stopAnimating()
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    print(response.result)              
                    
                    self.arrBreakfastItems.removeAll()
                    self.arrLunchItems.removeAll()
                    self.arrDinnerItems.removeAll()
                    
                    self.arrBrkItemTitle = (response.result["breakfast_item_list"].arrayValue.compactMap(clsItemWithCount.init))
                    self.arrLunchItemTitle = (response.result["lunch_item_list"].arrayValue.compactMap(clsItemWithCount.init))
                    self.arrDinnerItemTitle = (response.result["dinner_item_list"].arrayValue.compactMap(clsItemWithCount.init))
                    
                    self.arrBreakfastItems = (response.result["report_breakfast_list"].arrayValue.compactMap(clsReport.init))
                    
                    //.forEach({self.arrBreakfastItems.append(contentsOf: $0.CatItems.filter({ $0.ItemType == "item" || $0.ItemType == "sub_cat_item" })) })
                    
                    self.arrLunchItems = (response.result["report_lunch_list"].arrayValue.compactMap(clsReport.init))
                    
                    self.arrDinnerItems =  (response.result["report_dinner_list"].arrayValue.compactMap(clsReport.init))
                    
                    self.arRoomList = (response.result["rooms_list"].arrayValue.compactMap(clsReportRoom.init))
                    
                    self.setUpMealCategoryArray(selectedIndex: self.currentSelectedIndex)

                }
                else
                {
                    self.showMessageAlert(message: response.result[MainResponseCodeConstant.keyResponseText].stringValue)
                }
            }
            else
            {
                self.showMessageAlert(message: response.error!.localizedDescription)
            }
        }
    }
    
    @IBAction func btnReportForCharges_Clicked(_ sender: Any)
    {
        let reportVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReportChargesVC") as! ReportChargesVC
        reportVC.lastMenuDate = self.lastMenuDate
        self.navigationController?.pushViewController(reportVC, animated: false)
    }
    
}


class RoomNumberCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica", size: 21.0)! : UIFont(name: "Helvetica", size: 16.0)!
        //UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ItemNameCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica-Bold", size: 24.0)! : UIFont(name: "Helvetica-Bold", size: 19.0)!
        //UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.ColorCodes.reportTitleTextColor

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ItemTotalCountCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica-Bold", size: 22.0)! : UIFont(name: "Helvetica-Bold", size: 17.0)!
        //UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .red

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ItemQuantityCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.textColor = .black
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font =  (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Helvetica", size: 21.0)! : UIFont(name: "Helvetica", size: 16.0)!
        //UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

