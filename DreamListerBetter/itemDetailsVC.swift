//
//  itemDetailsVC.swift
//  DreamListerBetter
//
//  Created by Bhawna Verma on 21/05/1939 Saka.
//  Copyright © 1939 Saka Bhawna Verma. All rights reserved.
//

import UIKit
import CoreData

class itemDetailsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var thumbimage: UIImageView!
    @IBOutlet weak var Titletextfield: CustomTextField!
    @IBOutlet weak var DetailsTextfield: CustomTextField!
    @IBOutlet weak var Pricetextfield: CustomTextField!
    @IBOutlet weak var StorePicker: UIPickerView!
    
    var stores = [Store]()
    var itemToEdit:Item?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem  {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        StorePicker.delegate = self
        StorePicker.dataSource = self
        imagePicker.delegate = self
        getstores()
        if itemToEdit != nil {
                loadItemData()
        }
        
    
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //did select the row and update
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func getstores() {
        let fetchrequest:NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchrequest)
            self.StorePicker.reloadAllComponents()
            
        } catch {
            print("error")
            //catch the error that occurs here
        }
    }
    
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        var  item:Item
        let picture = Image(context: context)
        picture.image = thumbimage.image
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
                item = itemToEdit!
        }
        
        item.toimage = picture
        
        if let price = Pricetextfield.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let title = Titletextfield.text {
            item.title = title
        }
        
        if let details = DetailsTextfield.text {
            item.details = details
        }
        
        item.tostore = stores[StorePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    func loadItemData() {
        
        if let item = itemToEdit {
            
            Pricetextfield.text = "/(item.price)"
            Titletextfield.text = item.title
            DetailsTextfield.text = item.details
            thumbimage.image = item.toimage?.image as? UIImage
            var index = 0
            if let store = item.tostore {
            repeat {
                let s = stores[index]
                if s.name == store.name {
                    StorePicker.selectRow(index, inComponent: 0, animated: false)
                    break
                }
                
                index += 1
            } while ( index < stores.count )
            
            }
        }
        
    }
    @IBAction func deleteBtnPressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as?UIImage {
            thumbimage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    
    
    
    

}
