//
//  CalendarViewController.swift
//  Love
//
//  Created by Saruar on 17.06.2023.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    private var selectedDates = [Date]()
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.appearance.titleDefaultColor = .systemPink
        calendar.appearance.imageOffset = CGPoint(x: 0, y: -45)
        
        calendar.register(DateCalendarCell.self, forCellReuseIdentifier: "DIYCalendarCell")
        return calendar
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "Date picker"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Random date", style: .plain, target: self, action: #selector(randomDatePicked))
        
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.frame = CGRect(x: 0, y: 150, width: self.view.frame.width, height: 800)
        
        view.addSubview(calendar)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func randomDatePicked(){
        print("LOL")
    }
    
}


extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "DIYCalendarCell", for: date, at: position)
     
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        

        if selectedDates.contains(date){
            selectedDates.removeAll(where: {$0 == date})
        } else{
            selectedDates.append(date)
        }

        
        calendar.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        
        if selectedDates.contains(date){
            
            return UIImage(systemName: "heart")?.withTintColor(.systemPink, renderingMode: .alwaysTemplate).scaled(with: CGFloat(2.0))
        }
        
        return nil

    }
    
   
    
    
}


extension UIImage {
    
    func scaled(with scale: CGFloat) -> UIImage? {
        // size has to be integer, otherwise it could get white lines
        let size = CGSize(width: floor(self.size.width * scale), height: floor(self.size.height * scale))
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
