//
//  SettingsViewController.swift
//  exam_app
//
//  Created by br3nd4nt on 19.03.2024.
//

import UIKit

class SettingsViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    private var subviews: [UIView] = [];
    private let titleLabel: UILabel = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TabController.bgColor
        view.addSubview(titleLabel);
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        titleLabel.pinCenterX(to: view)
        subviews.append(titleLabel)
        titleLabel.text = "Your Settings "
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .white
        // Do any additional setup after loading the view.
    }
    
    func addSettings(_ newView: UIView) {
        view.addSubview(newView)
        if subviews.last != nil{
            newView.pinTop(to: subviews.last!.bottomAnchor, 20)
            newView.pinCenterX(to: view)
            newView.pinLeft(to: view, 20)
            newView.pinRight(to: view, 20)
            subviews.append(newView)
            print(subviews)
        }
    }
}
