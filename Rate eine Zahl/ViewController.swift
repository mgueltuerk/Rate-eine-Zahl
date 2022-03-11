//
//  ViewController.swift
//  Rate eine Zahl
//
//  Created by Murat Gültürk on 11.03.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEstimatedNumber: UITextField!
    @IBOutlet weak var imgSave: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtProposedNumber: UITextField!
    @IBOutlet weak var imgProposalStatus: UIImageView!
    @IBOutlet weak var btnTry: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!


    var stars : [UIImageView] = [UIImageView]()
    var maxTry : Int = 5
    var tryStatus : Int = 0
    var goal : Int = -1
    var gameSuccessful = false

    override func viewDidLoad() {
        super.viewDidLoad()

        stars = [imgStar1, imgStar2, imgStar3, imgStar4, imgStar5]
        imgSave.isHidden = true
        imgProposalStatus.isHidden = true
        btnTry.isEnabled = false
        txtEstimatedNumber.isSecureTextEntry = true
        lblResult.text = ""
    }

    @IBAction func btnSaveClicked(_ sender: UIButton) {
        imgSave.isHidden = false
        if let t = Int(txtEstimatedNumber.text!){
            goal = t
            btnTry.isEnabled = true
            txtEstimatedNumber.isEnabled = false
            btnSave.isEnabled = false
            imgSave.image = UIImage(named: "ok")

        }else{
            imgSave.image = UIImage(named: "error")
        }

    }

    @IBAction func btnTryClicked(_ sender: Any) {

        if gameSuccessful == true || tryStatus > maxTry{
            return
        }

        imgProposalStatus.isHidden = false
        if let numberEntered = Int(txtProposedNumber.text!){
            tryStatus += 1
            stars[tryStatus-1].image = UIImage(named: "star-ligt")


            if numberEntered > goal{
                imgProposalStatus.image = UIImage(named: "down")
                txtProposedNumber.backgroundColor = UIColor.red

            }else if numberEntered < goal{
                imgProposalStatus.image = UIImage(named: "up")
                txtProposedNumber.backgroundColor = UIColor.red
            }
        else{
            imgProposalStatus.image = UIImage(named: "good")
            btnSave.isEnabled = true
            lblResult.text = "Glückwunsch!"
            txtProposedNumber.backgroundColor = UIColor.green
            txtEstimatedNumber.isSecureTextEntry = false
            gameSuccessful = true

            let alertController = UIAlertController(title: "🎉🎉🎉", message: "Du bist der beste!", preferredStyle: UIAlertController.Style.alert)

            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)

            let playAgainAction = UIAlertAction(title: "Nochmal?", style: UIAlertAction.Style.default) { UIAlertAction in
                return
            }

            alertController.addAction(playAgainAction)
            alertController.addAction(okAction)
            if playAgainAction == playAgainAction{
                tryStatus = 0
                goal = 0
                txtEstimatedNumber.isSecureTextEntry = true
                btnTry.isEnabled = false
                txtEstimatedNumber.isEnabled = true
                txtProposedNumber.isEnabled = false
                imgProposalStatus.isHidden = true
                //imgProposalStatus = 0
                tryStatus = 0
                maxTry = 0
                imgSave.isHidden = true
                lblResult.text = ""
                txtProposedNumber.backgroundColor = UIColor.white


            }

            return

            }

        }else {
            imgProposalStatus.image = UIImage(named: "error")
        }
        if tryStatus == maxTry{
            btnTry.isEnabled = false
            imgProposalStatus.image = UIImage(named: "error")
            lblResult.text = "GAME OVER! \n😀😀 \nGeheime Zahl war \(goal)!"
            txtEstimatedNumber.isSecureTextEntry = false
            let alertController = UIAlertController(title: "GAME OVER! \n😀😀", message: "Geheime Zahl war \(goal)!", preferredStyle: UIAlertController.Style.alert)

            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)

            return
        }
    }

}

