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

    @IBOutlet var dtPicker : UIDatePicker!
    @IBOutlet weak var vw_clearBG: UIView!
    @IBOutlet weak var vw_header: UIView!
    @IBOutlet var vw_DatePickerContainer: UIView!
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
    
    @IBOutlet weak var btnSngDate: UIButton!
    @IBOutlet weak var btnMltDate: UIButton!
    @IBOutlet weak var btnStDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
        
    var selectedRoomName : String = ""
    var selectedRoomID : Int = 0
    var selectedDate = Date()
    let CYear = Calendar.current.component(.year, from: Date())
    var formatter = DateFormatter()
    var arItemList : [clsReport] = []
//    var arrBreakfastItems : [clsReport] = []
//    var arrLunchItems : [clsReport] = []
//    var arrDinnerItems : [clsReport] = []
    var arrBrkItemTitle : [clsItemWithCount] = []
    var arrLunchItemTitle : [clsItemWithCount] = []
    var arrDinnerItemTitle : [clsItemWithCount] = []
    var currentSelectedIndex =    0
    var lastMenuDate : Date = Date()
    var arRoomList : [clsReportRoom] = []
    var TotalQuantity : [String:Any] = [:]
    var brkColumnCount = 0
    var lunchColumnCount = 0
    var dinnerColumnCount = 0
    var currentSelectedDatePrefIndex = 0
    let dtpickerWidth : CGFloat = ((UIDevice.current.userInterfaceIdiom == .pad) ? 480 : 320)
    var CurrentDateSelection = "start"
    var StDate = Date()
    var EndDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.dtPicker.overrideUserInterfaceStyle = .light
        }
        
        if(Calendar.current.isDate(self.lastMenuDate, inSameDayAs:self.selectedDate))
        {}
        else if (self.lastMenuDate.compare(self.selectedDate) == ComparisonResult.orderedAscending)//Date()
        {
            self.selectedDate = self.lastMenuDate
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
        
        let frame1 = CGRect(x: 0, y: 38.5, width: (UIScreen.main.bounds.size.width+1)/2, height: 1.5)
        let sngDateBottom = UIView(frame: frame1)
        sngDateBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        sngDateBottom.tag = 1111
        let mltDateBottom = UIView(frame: frame1)
        mltDateBottom.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory
        mltDateBottom.tag = 1111
        self.btnSngDate.addSubview(sngDateBottom)
        self.btnMltDate.addSubview(mltDateBottom)
        
        self.setUpDatewiseUI(selectedIndex: 0)
                       
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
    
    @IBAction func btnStDateClicked(_ sender: Any)
    {
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        self.dtPicker.maximumDate = self.EndDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = self.dtPicker.locale
        self.dtPicker.minimumDate = dateFormatter.date(from: "01/01/2000")!
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)
                
        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        let date = dateFormatter.date(from: self.btnStDate.title(for: .normal)!)
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        let yourDate = dateFormatter.string(from: date!)
        print(yourDate)
        self.dtPicker.date = dateFormatter.date(from: yourDate)!
        self.CurrentDateSelection = "start"
    }
    
    @IBAction func btnEndDateClicked(_ sender: Any)
    {
                
        self.view.endEditing(true)
        self.vw_clearBG.isHidden = false
        self.vw_header.isUserInteractionEnabled = false
        let wd = UIScreen.main.bounds.size.width
        
        self.dtPicker.minimumDate = self.StDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = self.dtPicker.locale
        self.dtPicker.maximumDate = dateFormatter.date(from: "12/31/2050")!
        
        self.vw_DatePickerContainer.frame = CGRect(x: (wd - dtpickerWidth)/2, y: ((UIScreen.main.bounds.size.height - self.vw_DatePickerContainer.frame.size.height)/2), width: dtpickerWidth, height: self.vw_DatePickerContainer.frame.size.height)
   
        self.view.addSubview(self.vw_DatePickerContainer)

        //"dd MMM YYYY hh:mm a"
        // HH:mm:ss z
        let date = dateFormatter.date(from: self.btnEndDate.title(for: .normal)!)
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        let yourDate = dateFormatter.string(from: date!)
        print(yourDate)
        self.dtPicker.date = dateFormatter.date(from: yourDate)!
        self.CurrentDateSelection = "end"
    }
    
    @IBAction func btnCancelDateClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
    }
    
    @IBAction func btnAddDateClicked(_ sender: Any)
    {
        self.vw_clearBG.isHidden = true
        self.vw_header.isUserInteractionEnabled = true
        self.vw_DatePickerContainer.removeFromSuperview()
                
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let myString = formatter.string(from: self.dtPicker.date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "MM/dd/yyyy"
        let selectedDate = formatter.string(from: yourDate!)
        
        if(self.CurrentDateSelection == "start")
        {
            self.StDate = self.dtPicker.date
            self.btnStDate.setTitle(selectedDate, for: .normal)
        }
        else
        {
            self.EndDate = self.dtPicker.date
            self.btnEndDate.setTitle(selectedDate, for: .normal)
        }
        
        self.setDateRangeTitle()
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
        var minDate = Calendar.current.date(byAdding: .month, value: -3, to: formatter.date(from: Date().toString(dateFormat: "yyyy MM dd"))!)!
        if self.lastMenuDate.compare(minDate) == ComparisonResult.orderedAscending
        {
            NSLog("date1 before date2");
            minDate = Calendar.current.date(byAdding: .month, value: -3, to: formatter.date(from: self.lastMenuDate.toString(dateFormat: "yyyy MM dd"))!)!
        }
        return minDate
        
    }

    func maximumDate(for calendar: FSCalendar) -> Date {
        formatter.dateFormat = "yyyy MM dd"
        let endDate = Calendar.current.date(byAdding: .month, value: 2, to: formatter.date(from: Date().toString(dateFormat: "yyyy MM dd"))!)!
        let range = Calendar.current.range(of: .day, in: .month, for: endDate)!
        let edDate = formatter.date(from: "\(endDate.toString(dateFormat: "yyyy MM")) \(range.count)")
        return edDate!
       // return self.lastMenuDate
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
            //self.arItemList = self.arrBreakfastItems
            
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
            //self.arItemList = self.arrLunchItems
            
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
            //self.arItemList = self.arrDinnerItems
            
            self.btnBrk.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnLunch.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            self.btnDinner.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory} })
        }
        
        self.spreadsheetView.reloadData()
    }
    
    func setUpDatewiseUI(selectedIndex : Int)
    {
        self.currentSelectedDatePrefIndex = selectedIndex
        if(selectedIndex == 0)
        {
            self.selectedDate = Date()
            self.calendar_container_height.constant = 78
            self.btnToday.isHidden = false
            self.btn_calendarMonth.isHidden = false
            self.btnStDate.isHidden = true
            self.btnEndDate.isHidden = true
            
            self.btnSngDate.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            self.btnMltDate.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
                       
            self.btnSngDate.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory } })
            self.btnMltDate.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory} })
            
            if(Calendar.current.isDate(self.lastMenuDate, inSameDayAs:self.selectedDate))
            {}
            else if (self.lastMenuDate.compare(self.selectedDate) == ComparisonResult.orderedAscending)
            {
                self.selectedDate = self.lastMenuDate
                self.btnToday.isHidden = true
            }
            
            self.calendar.select(self.selectedDate, scrollToDate: true)
            self.full_calendar.select(self.selectedDate, scrollToDate: true)
            self.compareSelectedDate()
            self.setSelectedDateLabel()
        }
        else
        {
            self.calendar_container_height.constant = 0
            self.btnToday.isHidden = true
            self.btn_calendarMonth.isHidden = true
            self.btnStDate.isHidden = false
            self.btnEndDate.isHidden = false
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            self.StDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
            
            self.btnStDate.setTitle("\(dateFormatter.string(from: self.StDate))", for: .normal)
            self.btnEndDate.setTitle("\(dateFormatter.string(from: self.EndDate))", for: .normal)
         
            self.setDateRangeTitle()
            
            self.btnSngDate.setTitleColor(UIColor.ColorCodes.homeUnselectedCategory, for: .normal)
            self.btnMltDate.setTitleColor(UIColor.ColorCodes.homeSelectedCategory, for: .normal)
            
            self.btnSngDate.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeUnselectedCategory } })
            self.btnMltDate.subviews.forEach({ if($0.tag == 1111) {$0.backgroundColor = UIColor.ColorCodes.homeSelectedCategory} })
        }
        
        self.CallReportListService()
       // self.spreadsheetView.reloadData()
    }
    
    func setDateRangeTitle()
    {
        let st_mnth = self.StDate.toString(dateFormat: "MMM")
        let st_cl_mnth = st_mnth.localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        let stDateStr = "\(st_cl_mnth) \(self.StDate.toString(dateFormat: "d, yyyy"))"
        
        let end_mnth = self.EndDate.toString(dateFormat: "MMM")
        let end_cl_mnth = end_mnth.localizeString(string: AppDelegate.sharedDelegate().LanguagePrefCode)
        let EndDateStr = "\(end_cl_mnth) \(self.EndDate.toString(dateFormat: "d, yyyy"))"

                    
        self.lblSelectedDate.text = "\(stDateStr) to \(EndDateStr)"
    }
    
    @IBAction func btnMeal_Clicked(_ sender: Any)
    {
        let btn = sender as! UIButton
        self.setUpMealCategoryArray(selectedIndex: btn.tag)
    }
    
    @IBAction func btnDate_Clicked(_ sender: Any)
    {
        if(self.full_calendar.isHidden == true)
        {
            let btn = sender as! UIButton
            self.setUpDatewiseUI(selectedIndex: btn.tag)
        }
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 2
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
            if(self.currentSelectedDatePrefIndex == 0)
            {
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
            }
            cell.label.attributedText = attributedString
            cell.label.isUserInteractionEnabled = true
            cell.label.tag = indexPath.row
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapRecognized(_:)))
            cell.label.addGestureRecognizer(tapGesture)
            
            if(self.arRoomList[indexPath.row - 2].isForGuest == 1)
            {
                cell.label.textColor = UIColor.black
            }
            else
            {
                cell.label.textColor = (self.arRoomList[indexPath.row - 2].HasSpecialInst == 0) ? UIColor.black : UIColor.ColorCodes.homeSelectedCategory
            }
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
                let ky = self.arrBrkItemTitle[indexPath.column - 1].ItemName!
                cell.label.text = "\(self.TotalQuantity[ky] as! Int)"
                //cell.label.text = "\(self.arrBrkItemTitle[indexPath.column - 1].TotalCount)"
            }
            else if(self.currentSelectedIndex == 1)
            {
                let ky = self.arrLunchItemTitle[indexPath.column - 1].ItemName!
                cell.label.text = "\(self.TotalQuantity[ky] as! Int)"
                //cell.label.text = "\(self.arrLunchItemTitle[indexPath.column - 1].TotalCount)"
            }
            else
            {
                let ky = self.arrDinnerItemTitle[indexPath.column - 1].ItemName!
                cell.label.text = "\(self.TotalQuantity[ky] as! Int)"
                //cell.label.text = "\(self.arrDinnerItemTitle[indexPath.column - 1].TotalCount)"
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
                let ky = self.arrBrkItemTitle[indexPath.column - 1].ItemName!
                cell.label.text = "\(self.arItemList[indexPath.row - 2].Quantity[ky] as! Int)"
            }
            else if(self.currentSelectedIndex == 1)
            {
                let ky = self.arrLunchItemTitle[indexPath.column - 1].ItemName!
                cell.label.text = "\(self.arItemList[indexPath.row - 2].Quantity[ky] as! Int)"
            }
            else
            {
                let ky = self.arrDinnerItemTitle[indexPath.column - 1].ItemName!
                cell.label.text = "\(self.arItemList[indexPath.row - 2].Quantity[ky] as! Int)"
            }
            
            cell.gridlines.bottom = .solid(width: 1, color: .lightGray)
            cell.gridlines.right = .solid(width: 1, color: .white)
            return cell
            
        }
    }
    
    @objc func tapRecognized(_ sender: UITapGestureRecognizer)
    {
        if(self.currentSelectedDatePrefIndex == 0)
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
    }
    
    func CallReportListService()
    {
        self.view.isUserInteractionEnabled = false
        self.act_indicator.startAnimating()
//API.order_list_api
        //"get-categorywise-data" //get-report-data
        
        var para = [:] as [String : AnyObject]
        if(self.currentSelectedDatePrefIndex == 0)
        {
            para["search_date"] = self.selectedDate.toString(dateFormat: "yyyy-MM-dd") as AnyObject
        }
        else
        {
            para["start_date"] = self.StDate.toString(dateFormat: "yyyy-MM-dd") as AnyObject
            para["end_date"] = self.EndDate.toString(dateFormat: "yyyy-MM-dd") as AnyObject
        }
        
        //["room_id" : "101", "search_date" : self.selectedDate.toString(dateFormat: "yyyy-MM-dd"), "type" : self.currentSelectedIndex + 1]
        NetworkUtilities.shared.makeGETRequest(with: API.baseURL + "reports", parameters: para) { (response) in
            
            self.view.isUserInteractionEnabled = true
            self.act_indicator.stopAnimating()
            if(response.error == nil)
            {
                if(response.result[MainResponseCodeConstant.keyResponseCode].intValue == MainResponseCodeConstant.keyResponseCodeOne)
                {
                    if(response.result["columns"].count > 0 && response.result["columns"][0].count >= 4)
                    {
                        let allMealCount = response.result["columns"][0]
                        self.brkColumnCount = allMealCount[1]["colspan"].intValue
                        self.lunchColumnCount = allMealCount[2]["colspan"].intValue
                        self.dinnerColumnCount = allMealCount[3]["colspan"].intValue
                        self.TotalQuantity = response.result["total"].dictionaryObject!
                    }
                
                    self.arItemList.removeAll()
                    self.arrBrkItemTitle.removeAll()
                    self.arrLunchItemTitle.removeAll()
                    self.arrDinnerItemTitle.removeAll()
                    self.arRoomList.removeAll()
                
                    let allTitle = response.result["columns"][2]
                    for i in 0..<allTitle.count
                    {
                        if(i<self.brkColumnCount)
                        {
                            self.arrBrkItemTitle.append(clsItemWithCount(iName: allTitle[i]["title"].rawString()!, iRealName: allTitle[i]["tooltip"].rawString()!))
                        }
                        else if(i<self.brkColumnCount + self.lunchColumnCount)
                        {
                            self.arrLunchItemTitle.append(clsItemWithCount(iName: allTitle[i]["title"].rawString()!, iRealName: allTitle[i]["tooltip"].rawString()!))
                        }
                        else
                        {
                            self.arrDinnerItemTitle.append(clsItemWithCount(iName: allTitle[i]["title"].rawString()!, iRealName: allTitle[i]["tooltip"].rawString()!))
                        }
                    }
                    
                    let RoomArray = response.result["result"]["rows"]
                    RoomArray.forEach({
                        let rName = (($0.1)["room_name"]).rawString()!
                        let rId = (($0.1)["room_id"]).rawString()!
                        let hasSplInst =  (($0.1)["has_special_ins"]).rawString()!
                        
                        if(self.currentSelectedDatePrefIndex == 0)
                        {
                            let hasBrkOrder =  (($0.1)["has_breakfast_order"]).rawString()!
                            let hasLunchOrder =  (($0.1)["has_lunch_order"]).rawString()!
                            let hasDinnerOrder =  (($0.1)["has_dinner_order"]).rawString()!
                            let hasSplInst =  (($0.1)["has_special_ins"]).rawString()!
                            let isForGuest =  (($0.1)["is_for_guest"]).rawString()!
                            self.arRoomList.append(clsReportRoom(RName: rName, RId: Int(rId)!, HasSplInst: Int(hasSplInst)!, HasBrkOrder: Int(hasBrkOrder)!, HasLunchOrder: Int(hasLunchOrder)!, HasDinnerOrder: Int(hasDinnerOrder)!, IsForGuest: Int(isForGuest)!))
                        }
                        else
                        {
                            self.arRoomList.append(clsReportRoom(RName: rName, RId: Int(rId)!, HasSplInst: Int(hasSplInst)!))
                        }
                        
                        self.arItemList.append(clsReport(RName: rName))
                        //print("for each obj rawdict is \(($0.1).dictionaryObject!)")
                        self.arItemList[self.arItemList.count - 1].Quantity = ($0.1).dictionaryObject!
    //                    self.arrLunchItems.append(clsReport(RName: rName))
    //                    self.arrLunchItems[self.arrLunchItems.count - 1].Quantity = ($0.1).dictionaryObject!
    //                    self.arrDinnerItems.append(clsReport(RName: rName))
    //                    self.arrDinnerItems[self.arrDinnerItems.count - 1].Quantity = ($0.1).dictionaryObject!
                        //= (response.result["rooms_list"].arrayValue.compactMap(clsReportRoom.init))
                    })
                
                    print("api changes result is \(self.arrBrkItemTitle)")
//response.result["total"].dictionaryValue.keys)")
                
//                    self.arrBreakfastItems.removeAll()
//                    self.arrLunchItems.removeAll()
//                    self.arrDinnerItems.removeAll()
//                    
//                    self.arrBrkItemTitle = (response.result["breakfast_item_list"].arrayValue.compactMap(clsItemWithCount.init))
//                    self.arrLunchItemTitle = (response.result["lunch_item_list"].arrayValue.compactMap(clsItemWithCount.init))
//                    self.arrDinnerItemTitle = (response.result["dinner_item_list"].arrayValue.compactMap(clsItemWithCount.init))
//                    
//                    self.arrBreakfastItems = (response.result["report_breakfast_list"].arrayValue.compactMap(clsReport.init))
//                    
//                    //.forEach({self.arrBreakfastItems.append(contentsOf: $0.CatItems.filter({ $0.ItemType == "item" || $0.ItemType == "sub_cat_item" })) })
//                    
//                    self.arrLunchItems = (response.result["report_lunch_list"].arrayValue.compactMap(clsReport.init))
//                    
//                    self.arrDinnerItems =  (response.result["report_dinner_list"].arrayValue.compactMap(clsReport.init))
//                    
//                    self.arRoomList = (response.result["rooms_list"].arrayValue.compactMap(clsReportRoom.init))
                    
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
        reportVC.lastMenuDate = AppDelegate.sharedDelegate().LastMenuDate
//        if (reportVC.lastMenuDate.compare(Date()) == ComparisonResult.orderedAscending)
//        {
//            reportVC.selectedDate = reportVC.lastMenuDate
//        }
//        else
//        {
//            reportVC.selectedDate = Date()
//        }
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

