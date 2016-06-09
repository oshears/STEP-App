//
//  PostSnapTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 6/4/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class PostSnapTableViewController: UITableViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var snapImageView: UIImageView!
   
    
    @IBOutlet weak var snapCaptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snapCaptionTextView.layer.borderColor = UIColor.blackColor().CGColor
        snapCaptionTextView.layer.borderWidth = 0.5
        snapCaptionTextView.layer.cornerRadius = 5
        snapCaptionTextView.delegate = self
        //snapCaptionTextView.returnKeyType = .Done
        
        
        //No excess
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postQuestion(){
        let notBlank = snapCaptionTextView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != ""
        if notBlank{
            let snap:PFObject = PFObject(className: "SnapImage")
            snap["caption"] = snapCaptionTextView.text
            
            //Compress before upload(?)
            
            //snapImageView.image?.imageOrientation = UIImageOrientation.Up
            //var someCiImage = CIImage(image: snapImageView.image)

            //var newImage = UIImage(CIImage: someCiImage, scale: 1.0, orientation: UIImageOrientation.Up)
            //let scaledImage = self.scaledImageWith(snapImageView, newSize: CGSizeMake())
            let imageData = UIImageJPEGRepresentation(snapImageView.image!,0.8)
            let imageFile = PFFile(name:"snapimage.png", data:imageData!)
            snap["image"] = imageFile

            snap.saveInBackgroundWithTarget(nil, selector: nil)
            //performSegueWithIdentifier("unwindToFaqsScreen", sender: self)

            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            let errorAlert:UIAlertController = UIAlertController(title: "Textfields Not Filled", message: "Please fill out all textfields before posting a Snap.", preferredStyle: UIAlertControllerStyle.Alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(errorAlert,animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Selected the image
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //Image Picker Controller
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        snapImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        snapImageView.contentMode = UIViewContentMode.ScaleAspectFit
        snapImageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //cosnovae
    //https://github.com/cosnovae/fixUIImageOrientation
   /*
    func fixImageOrientation(src:UIImage)->UIImage {
        
        if src.imageOrientation == UIImageOrientation.Up {
            return src
        }
        
        var transform: CGAffineTransform = CGAffineTransformIdentity
        
        switch src.imageOrientation {
        case UIImageOrientation.Down, UIImageOrientation.DownMirrored:
            transform = CGAffineTransformTranslate(transform, src.size.width, src.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            break
        case UIImageOrientation.Left, UIImageOrientation.LeftMirrored:
            transform = CGAffineTransformTranslate(transform, src.size.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            break
        case UIImageOrientation.Right, UIImageOrientation.RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, src.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
            break
        case UIImageOrientation.Up, UIImageOrientation.UpMirrored:
            break
        default:
            break
        }
        
        switch src.imageOrientation {
        case UIImageOrientation.UpMirrored, UIImageOrientation.DownMirrored:
            CGAffineTransformTranslate(transform, src.size.width, 0)
            CGAffineTransformScale(transform, -1, 1)
            break
        case UIImageOrientation.LeftMirrored, UIImageOrientation.RightMirrored:
            CGAffineTransformTranslate(transform, src.size.height, 0)
            CGAffineTransformScale(transform, -1, 1)
        case UIImageOrientation.Up, UIImageOrientation.Down, UIImageOrientation.Left, UIImageOrientation.Right:
            break
        default:
            break
        }
        
        //var ctv:CGContextRef = CGBitmapContextCreate(<#data: UnsafeMutablePointer<Void>#>, <#width: Int#>, <#height: Int#>, <#bitsPerComponent: Int#>, <#bytesPerRow: Int#>, <#space: CGColorSpace!#>, <#bitmapInfo: CGBitmapInfo#>)
        
        var ctx:CGContextRef = CGBitmapContextCreate(nil, Int(src.size.width), Int(src.size.height), CGImageGetBitsPerComponent(src.CGImage), 0, CGImageGetColorSpace(src.CGImage), CGImageGetBitmapInfo(src.CGImage))
        
        CGContextConcatCTM(ctx, transform)
        
        switch src.imageOrientation {
        case UIImageOrientation.Left, UIImageOrientation.LeftMirrored, UIImageOrientation.Right, UIImageOrientation.RightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, src.size.height, src.size.width), src.CGImage)
            break
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, src.size.width, src.size.height), src.CGImage)
            break
        }
        
        let cgimg:CGImageRef = CGBitmapContextCreateImage(ctx)!
        var img:UIImage = UIImage(CGImage: cgimg)
        
        return img
    }
    
    func scaledImageWith (image:UIImage, newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect((CGRectMake(0, 0, newSize.width, newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }*/

}
