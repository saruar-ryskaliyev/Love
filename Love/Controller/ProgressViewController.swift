//
//  ProgressViewController.swift
//  Love
//
//  Created by Saruar on 17.06.2023.
//

import UIKit
import MapKit
import AVFoundation
import CLTypingLabel

class ProgressViewController: UIViewController {
    
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var startDate: Date!
    private var timer: Timer!
    static let pinkColor = UIColor(red: 0.91, green: 0.75, blue: 0.82, alpha: 1.00)

    
    var musicPlayer: AVAudioPlayer?
    
    
    
    
    public var aigerimFirstMessage: CLTypingLabel = {
        let label = CLTypingLabel()
        //label.text = "Хэлоу хэлоу"
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.charInterval = 0.05
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aigerimSecondMessage: CLTypingLabel = {
        let label = CLTypingLabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.charInterval = 0.05
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let saruarFirstMessage: CLTypingLabel = {
        let label = CLTypingLabel()
        label.charInterval = 0.05
        label.text = "Салем, помнишь, когда мы в меге были, ты хотела в чаплин сходить?"
        label.backgroundColor = .systemBlue
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
       
        
        return label
    }()
    
    
    private let saruarSecondMessage: CLTypingLabel = {
        let label = CLTypingLabel()
        label.charInterval = 0.05
        label.backgroundColor = .systemBlue
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let saruarThirdMessage: CLTypingLabel = {
        let label = CLTypingLabel()
        label.charInterval = 0.05
        label.backgroundColor = .systemBlue
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.text = "First message:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    
    private let mdeeCover: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mdee"))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
    
        return button
    }()

    
    private let favMusLabel: UILabel = {
        let label = UILabel()
        label.text = "Our favorite music:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.backgroundColor = .systemCyan
        map.layer.cornerRadius = 8
        return map
    }()
    
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Place where I first saw your beautiful eyes:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    
    private let daysLabel: UILabel = {
        let label = UILabel()
        
        label.text = "days"
        label.font = .systemFont(ofSize: 25, weight: .bold)

        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Together for"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        
        return label
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Looove"
        

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        mapView.delegate = self
        
      
        view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        startDate = dateFormatter.date(from: "2022-09-07 00:00:00")

        
        startTimer()
        // Start the timer

        setupMap()
        
        
        configureUI()
        
        
        
        saruarFirstMessage.onTypingAnimationFinished = {
            self.aigerimFirstMessage.text = "Хэллоу хэллоу"
        }
        
        aigerimFirstMessage.onTypingAnimationFinished = {
            self.aigerimSecondMessage.text = "Иееп"
        }
        
        aigerimSecondMessage.onTypingAnimationFinished = {
            self.saruarSecondMessage.text = "Пошли завтра в чаплин?"
        }
        
        saruarSecondMessage.onTypingAnimationFinished = {
            self.saruarThirdMessage.text = "Я хотел на стренджа или я краснею сходить"
        }
        // Do any additional setup after loading the view.
    }


    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop the timer when the view controller is about to disappear
        timer.invalidate()
    }
    
    private func configureUI(){
        
        
        
        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: view.frame.size.height - 20))
        view.addSubview(scrollView)
        
        
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(timerLabel)
        scrollView.addSubview(daysLabel)
        scrollView.addSubview(placeLabel)
        scrollView.addSubview(mapView)
        scrollView.addSubview(favMusLabel)
        scrollView.addSubview(playButton)
        scrollView.addSubview(mdeeCover)
        scrollView.addSubview(firstTextLabel)
        scrollView.addSubview(saruarFirstMessage)
        scrollView.addSubview(aigerimFirstMessage)
        scrollView.addSubview(aigerimSecondMessage)
        scrollView.addSubview(saruarSecondMessage)
        scrollView.addSubview(saruarThirdMessage)
        
        
        
        
        
        
        let firstTextLabelConstraint = [
            firstTextLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            firstTextLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30)
        ]
        
        let saruarFirstMessageConstraint = [
            saruarFirstMessage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 50),
            saruarFirstMessage.topAnchor.constraint(equalTo: firstTextLabel.bottomAnchor, constant: 10),
            saruarFirstMessage.widthAnchor.constraint(equalToConstant: 300),
            saruarFirstMessage.heightAnchor.constraint(equalToConstant: 80),
            
            saruarSecondMessage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 100),
            saruarSecondMessage.topAnchor.constraint(equalTo: aigerimSecondMessage.bottomAnchor, constant: 10),
            saruarSecondMessage.widthAnchor.constraint(equalToConstant: 180),
            saruarSecondMessage.heightAnchor.constraint(equalToConstant: 65),
            
            saruarThirdMessage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 100),
            saruarThirdMessage.topAnchor.constraint(equalTo: saruarSecondMessage.bottomAnchor, constant: 10),
            saruarThirdMessage.widthAnchor.constraint(equalToConstant: 180),
            saruarThirdMessage.heightAnchor.constraint(equalToConstant: 85)
            
        ]
        
        let aigerimMessageConstraint = [
            aigerimFirstMessage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
            aigerimFirstMessage.topAnchor.constraint(equalTo: saruarFirstMessage.bottomAnchor, constant: 10),
            aigerimFirstMessage.widthAnchor.constraint(equalToConstant: 180),
            aigerimFirstMessage.heightAnchor.constraint(equalToConstant: 40),
            
            aigerimSecondMessage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100),
            aigerimSecondMessage.topAnchor.constraint(equalTo: aigerimFirstMessage.bottomAnchor, constant: 10),
            aigerimSecondMessage.widthAnchor.constraint(equalToConstant: 180),
            aigerimSecondMessage.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        let mainLabelConstraint = [
            mainLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: saruarThirdMessage.topAnchor, constant: 100),
            mainLabel.widthAnchor.constraint(equalToConstant: 300)
        ]

        let timerLabelConstraint = [
            timerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5)
        ]
        
        let daysLabelConstraint = [
            daysLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            daysLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 5)
        ]
        
        let placeLabelConstraint = [
            placeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            placeLabel.topAnchor.constraint(equalTo: daysLabel.bottomAnchor, constant: 30),
            placeLabel.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        let mapViewConstraint = [
            mapView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mapView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 10),
            mapView.widthAnchor.constraint(equalToConstant: 200),
            mapView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let favMusLabelConstraint = [
            favMusLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            favMusLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 30)
        ]

        
        let mdeeCoverConstraint = [
            mdeeCover.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mdeeCover.topAnchor.constraint(equalTo: favMusLabel.bottomAnchor, constant: 5),
            mdeeCover.widthAnchor.constraint(equalToConstant: 150),
            mdeeCover.heightAnchor.constraint(equalToConstant: 150)
        
        ]
        
        let playButtonConstraint = [
            playButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: mdeeCover.bottomAnchor, constant: 5),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalToConstant: 80)
        ]

        
        scrollView.contentSize = CGSize(width: view.frame.size.width - 30, height: 1170)

 
            
        NSLayoutConstraint.activate(mainLabelConstraint)
        NSLayoutConstraint.activate(timerLabelConstraint)
        NSLayoutConstraint.activate(daysLabelConstraint)
        NSLayoutConstraint.activate(placeLabelConstraint)
        NSLayoutConstraint.activate(mapViewConstraint)
        NSLayoutConstraint.activate(favMusLabelConstraint)
        NSLayoutConstraint.activate(playButtonConstraint)
        NSLayoutConstraint.activate(mdeeCoverConstraint)
        NSLayoutConstraint.activate(firstTextLabelConstraint)
        NSLayoutConstraint.activate(saruarFirstMessageConstraint)
        NSLayoutConstraint.activate(aigerimMessageConstraint)
        
        playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
    }
    
    
    
    @objc func playPressed(){
        if let musicPlayer = musicPlayer, musicPlayer.isPlaying{
            DispatchQueue.main.async {

                
                self.playButton.setImage(UIImage(systemName: "play.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            }
            
            musicPlayer.stop()
        } else{
            
            
            playButton.setImage(UIImage(systemName: "pause.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            
            let urlString = Bundle.main.path(forResource: "music", ofType: "mp3")
            
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let musicPlayer = musicPlayer else{
                    return
                }
                
                musicPlayer.play()
                
                
            } catch{
                print("error")
            }
            
        }
    }
    

}


extension ProgressViewController: MKMapViewDelegate {
    private func setupMap(){
        let annotation = MKPointAnnotation()

               // Set the coordinate property of the MKPointAnnotation object to the location you want to show on the map
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.124377, longitude: 71.459444)

               // Add the MKPointAnnotation object to the map view
        mapView.addAnnotation(annotation)

               // Set the map view's region to the location of the pin
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)
    }
}


extension ProgressViewController {
    
    private func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            // Calculate the time interval between the start date and the current date
            let elapsedTime = Date().timeIntervalSince(self?.startDate ?? Date())
            
            let days = Int(elapsedTime / (3600 * 24))
            let hoursComponent = self?.calendar.dateComponents([.hour], from: self?.startDate ?? Date(), to: Date()).hour ?? 0
            let hours = (hoursComponent + 24) % 24
            let minutes = Int((elapsedTime / 60).truncatingRemainder(dividingBy: 60))
            let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))

            
            DispatchQueue.main.async {
                self?.timerLabel.text = String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
            }

        }
    }
    
    
}
    


