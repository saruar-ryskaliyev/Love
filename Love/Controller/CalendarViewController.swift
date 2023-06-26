//
//  CalendarViewController.swift
//  Love
//
//  Created by Saruar on 17.06.2023.
//

import UIKit
import FSCalendar
import SwiftUI


var dateIdeaCalendar: String?

class CalendarViewController: UIViewController {
    
    private var selectedDates = [Date : String]()
    private var selectedLabel: UILabel!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.appearance.titleDefaultColor = .systemPink
        calendar.appearance.imageOffset = CGPoint(x: 0, y: -10)
        
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
        calendar.frame = CGRect(x: 0, y: 150, width: self.view.frame.width, height: 650)
        


        view.addSubview(calendar)
        

    }
    
    @objc func randomDatePicked(){
        let vc = UIHostingController(rootView: ContentView())
        
        self.present(vc, animated: true)
    }
    
    

}


extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "DIYCalendarCell", for: date, at: position)
     
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        
        if selectedDates.contains(where: {$0.key == date}){
            let alert = UIAlertController(title: "Select", message: "action", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Info", style: .default , handler:{ (UIAlertAction)in
                let info = UIAlertController(title: "This day:", message: self.selectedDates[date]! , preferredStyle: .alert)
              
                let OKAction = UIKit.UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                }
                
                info.addAction(OKAction)
                
                
                self.present(info, animated: true)
            }))
                
            alert.addAction(UIAlertAction(title: "Change date idea", style: .default , handler:{ (UIAlertAction)in
                let change = UIAlertController(title: "Type your date", message: nil, preferredStyle: .alert)
                
                change.addTextField { (textField) in
                    textField.placeholder = "Type your date idea"
                }
       
                let changeAction = UIKit.UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                    
                    self.selectedDates.updateValue((change.textFields?[0].text!)!, forKey: date)
                
                })
                

    
                change.addAction(changeAction)
                
                self.present(change, animated: true)
                
            }))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
                self.selectedDates.removeValue(forKey: date)
                calendar.reloadData()
            }))
                
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                    print("User click Dismiss button")
            }))
            
            self.present(alert, animated: true)
        } else{
            selectedDates[date] = dateIdeaCalendar
    
        }
        
        
        
        calendar.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        
        if selectedDates.contains(where: {$0.key == date}){
            return UIImage(systemName: "heart.fill")?.withTintColor(.systemPink, renderingMode: .alwaysTemplate).scaled(with: CGFloat(1.0))
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
