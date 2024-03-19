//
//  TabContoller.swift
//  exam_app
//
//  Created by br3nd4nt on 19.03.2024.
//

import UIKit

class TabController : UITabBarController {
    static let tileSizeNotif: String = "TileSizeChangedNotification"
    static var bgColor: UIColor = .systemBackground
    private let notifications = Notification.Name(tileSizeNotif)
    
    
    override func viewDidLoad() {
        view.backgroundColor = TabController.bgColor
        super.viewDidLoad()
        self.setupTabs()
    }
    
    private func setupTabs() {
        let content_vc = ContentViewController()
        let settings_vc = SettingsViewController()
        self.setupSettingsView(settings_vc, content_vc)
        let content = self.createNav(with: "Content", and: UIImage(systemName: "house"), vc: content_vc)
        let settings = self.createNav(with: "Settings", and: UIImage(systemName: "gearshape.fill"), vc: settings_vc)
        self.setViewControllers([content, settings], animated: true)
        self.tabBar.isTranslucent = false
        
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
    private func setupSettingsView(_ sv: SettingsViewController, _ content: ContentViewController) {
        //scroller
        let sliderlabel = UILabel()
        sliderlabel.text = "Choose size of tiles:"
        sliderlabel.textColor = .white
        sv.addSettings(sliderlabel)
        
        let slider = UISlider()
        slider.minimumValue = 100
        slider.maximumValue = 390
        slider.setValue(350, animated: false)
        slider.addTarget(self, action: #selector(sliderChangedValue(sender:)), for: .valueChanged)
        sv.addSettings(slider)
        
        //color picker
//        let colorlabel = UILabel()
//        colorlabel.text = "Choose new background color:"
//        colorlabel.textColor = .white
//        sv.addSettings(sliderlabel)
//        
//        let colorPicker: UIColorPickerViewController = UIColorPickerViewController()
//        colorPicker.delegate = self
//
    }
    
    @objc
    private func sliderChangedValue(sender: UISlider) {
        let newSize = sender.value
        NotificationCenter.default.post(name: notifications, object: self, userInfo: ["newSize": newSize])
    }
    
}
