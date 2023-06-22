import QuartzCore
import UIKit
import FSCalendar



class DateCalendarCell: FSCalendarCell {



    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)


       self.shapeLayer.isHidden = true
       

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.eventIndicator.isHidden = true
        self.backgroundView?.frame = self.bounds.insetBy(dx: 0, dy: 0)
        self.titleLabel.textColor = .red

        

    }



}
