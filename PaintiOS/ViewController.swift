//
//  ViewController.swift
//  PaintiOS
//
//  Created by Omar Aldair Romero Pérez on 1/26/19.
//  Copyright © 2019 Omar Aldair Romero Pérez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var colors = [UIColor]()
    @IBOutlet weak var imageView: DrawingImage!
    @IBOutlet weak var countWidthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // create new colors to array
        self.colors += [.red, .orange, .yellow, .green, .blue, .purple]
        
        for hue in 0...9{
            for sat in 1...10{
                let color = UIColor(hue: CGFloat(hue)/10, saturation: CGFloat(sat)/10, brightness: 1, alpha: 1)
                self.colors.append(color)
            }
        }
        
        // Add share button to nav
        let sharedButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMyImageAction))
        
        self.navigationItem.rightBarButtonItems?.append(sharedButton)
        
        
    
    }

    // MARK: Actions
    @IBAction func deleteDrawAction(_ sender: UIBarButtonItem) {
        deleteMyDraw()
    }
    
    
    // Share my image
    @objc func shareMyImageAction(sender: UIBarButtonItem){
        
        if let image = self.imageView.image{
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityController.popoverPresentationController?.barButtonItem = sender
            present(activityController, animated: true)
        }
        
    }
    
    // Set width pencil
    @IBAction func sliderAction(_ sender: UISlider) {
        let sliderValue = CGFloat(sender.value)
        let sliderIntValue = Int(sliderValue)
        self.countWidthLabel.text = "\(sliderIntValue)"
        self.imageView.currentLineWith = sliderValue
        
    }
    
    // Delete a part of my draw
    @IBAction func deletePartialDrawAction(_ sender: UIBarButtonItem) {
        self.imageView.currentColor = UIColor.white
    }
    
    
    // Delete all my draw
    func deleteMyDraw(){
        /*let renderer = UIGraphicsImageRenderer(size: self.imageView.bounds.size)
        self.imageView.image = renderer.image(actions: { (context) in
            UIColor.white.setFill()
            context.fill(self.imageView.bounds)
        })*/
        
        self.imageView.deleteMyDraw()
    }
    
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.colors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        cell.backgroundColor = self.colors[indexPath.row]
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
        
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = self.colors[indexPath.row]
        self.imageView.currentColor = color
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 3.0
        cell?.layer.borderColor = UIColor.black.cgColor
        collectionView.allowsMultipleSelection = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 3.0
        cell?.layer.borderColor = UIColor.white.cgColor
    }
    


    
    
}

