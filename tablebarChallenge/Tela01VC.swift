//
//  ViewController.swift
//  tablebarChallenge
//
//  Created by Premiersoft on 15/09/23.
//

import UIKit
import PhotosUI

class Tela01VC: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var editPictureButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var data: [Profile] = []
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configElements()
        configTableView()
    
    }
    
    func configImagePicker(){
        var config =  PHPickerConfiguration()
        config.filter = PHPickerFilter.images
        config.selectionLimit = 10
        
        let imagePicker: PHPickerViewController = PHPickerViewController(configuration:config)
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func configElements(){
        view.backgroundColor = .lightGray
        nameLabel.text = "Nome:"
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .black
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height  / 2
        profileImageView.contentMode = .scaleAspectFill
        nameTextField.placeholder = "Digite seu nome:"
    }
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        
    }
    
    
    
    
    @IBAction func tappedEditPictureButton(_ sender: UIButton) {
        let alertController: UIAlertController = UIAlertController(title: "Selecione uma opção", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) {
            (action) in
            
            //Acao camera
            self.configImagePicker()

        }
        
        let library = UIAlertAction(title: "Biblioteca",  style: .default) {
            (action) in
            
            //Acao Biblioteca
            self.configImagePicker()

        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .default)
        
        alertController.addAction(camera)
        alertController.addAction(library)
        alertController.addAction(cancel)
        present(alertController, animated: true)
        
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        if(nameTextField.text?.isEmpty == false) {
            data.append(Profile(name: nameTextField.text ?? "", photo: profileImageView.image ?? UIImage()))
            nameTextField.text = ""
            profileImageView.image = UIImage(systemName: "person.circle.fill")
            tableView.reloadData()

        }

        
    }
    
}

extension Tela01VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        cell?.setupCell(profile: self.data[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 209
    }
    
    
    
}




extension Tela01VC: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        for item in results {
            item.itemProvider.loadObject(ofClass: UIImage.self) { (imagePicker, error)  in
                
                if let image = imagePicker as? UIImage {
                    self.profileImageView.image = image
                }
            }
        }
    }
    
    

}
