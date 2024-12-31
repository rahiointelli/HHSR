//
//  File.swift
//  iTask
//
//  Created by Intelli on 2019-08-19.
//  Copyright © 2019 Intelli. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showMessageAlert(_ title: String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        }))
        
        DispatchQueue.main.async {
            if ( UIDevice.current.model.range(of: "iPad") != nil)
            {
                alert.popoverPresentationController?.sourceView = self.view
                alert.popoverPresentationController?.sourceRect = self.view.bounds
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension Date
{
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
    
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func WithDayString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        let day = dateFormatter.string(from: self)
        dateFormatter.dateFormat = format
        return "\(day), \(dateFormatter.string(from: self))"
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
}

extension UIView {
    func createDottedLine(width: CGFloat, color: CGColor, maxX : CGFloat) {
      let caShapeLayer = CAShapeLayer()
      caShapeLayer.strokeColor = color
      caShapeLayer.lineWidth = width
      caShapeLayer.lineDashPattern = [6,2]
      let cgPath = CGMutablePath()
      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: maxX, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
      layer.addSublayer(caShapeLayer)
        //self.frame.width
   }
}

extension UITextField
{
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.text)
    }
}

extension UIColor
{
    struct ColorCodes
    {
        static let statusbar  = UIColor(red: 9.0/255.0, green: 98.0/255.0, blue: 176.0/255.0, alpha: 1)
        static let txtaddTaskColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1)
        static let themeBlkColor = UIColor(red: 16.0/255.0, green: 33.0/255.0, blue: 57.0/255.0, alpha: 1)
        static let themeGoColor = UIColor(red: 98.0/255.0, green: 171.0/255.0, blue: 201.0/255.0, alpha: 1)
        static let addPrjLightGrayColor = UIColor(red: 125.0/255.0, green: 125.0/255.0, blue: 125.0/255.0, alpha: 1)
        static let addPrjSeperatorVwColor = UIColor(red: 237.0/255.0, green: 240.0/255.0, blue: 242.0/255.0, alpha: 1)
        static let addPrjFlgSelectionBgColor = UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1)
        static let OverdueColor = UIColor(red: 221.0/255.0, green: 76.0/255.0, blue: 72.0/255.0, alpha: 1)
        
        static let dinningTblHeaderColor  = UIColor(red: 46.0/255.0, green: 81.0/255.0, blue: 125.0/255.0, alpha: 1)
        static let dinningTblHeaderBgColor  = UIColor(red: 218.0/255.0, green: 228.0/255.0, blue: 238.0/255.0, alpha: 1)
        static let homeSelectedCategory  = UIColor(red: 9.0/255.0, green: 98.0/255.0, blue: 176.0/255.0, alpha: 1)
        //UIColor(red: 0.0/255.0, green: 113.0/255.0, blue: 175.0/255.0, alpha: 1)
        static let homeUnselectedCategory  = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1)
        static let reportTitleBgColor  = UIColor(red: 218.0/255.0, green: 227.0/255.0, blue: 238.0/255.0, alpha: 1)
        static let reportTitleTextColor  = UIColor(red: 54.0/255.0, green: 79.0/255.0, blue: 118.0/255.0, alpha: 1)
        static let followUpBgColor  = UIColor(red: 255.0/255.0, green: 238.0/255.0, blue: 153.0/255.0, alpha: 1)
        
    }    
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func captureSS(hgtToMinus : CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: bounds.size.width, height: bounds.size.height - hgtToMinus - 40))

       // defer{ UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: -40)
        
        self.layer.render(in: context!)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func toImage(hgtToMinus : CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: bounds.size.width, height: bounds.size.height - hgtToMinus), false, UIScreen.main.scale)

        //let hgt = (540.0 * bounds.size.width)/(bounds.size.height - 100)
        
        //self.bounds
        drawHierarchy(in: self.bounds , afterScreenUpdates: true)
        //drawHierarchy(in: CGRect(origin: .zero, size: CGSize(width: 540.0, height: hgt)) , afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIScrollView {

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }

    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }

    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }

}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

// MARK:-  Error
extension NSError {
    class func error(with message: String) -> NSError {
        let error = NSError.init(domain: "Local", code: 0, userInfo: [NSLocalizedDescriptionKey : message])
        return error
    }
}

extension UIImage {
    func imageWithSize(scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIColor {

    // MARK: - Initialization

    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    // MARK: - Computed Properties

    var toHex: String? {
        return toHex()
    }

    // MARK: - From UIColor to String

    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

}

extension UIImage
{
    func fixOrientation(withPercentage percentage: CGFloat) -> UIImage? {
        
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
         imageView.image = self
         UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
         guard let context1 = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context1)
         guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
         UIGraphicsEndImageContext()
        
        guard let cgImage = result.cgImage else {
            return nil
        }
        

        if result.imageOrientation == UIImage.Orientation.up {
            return result
        }

        let width  = result.size.width
        let height = result.size.height

        var transform = CGAffineTransform.identity

        switch result.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: width, y: height)
            transform = transform.rotated(by: CGFloat.pi)

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.rotated(by: 0.5*CGFloat.pi)

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: height)
            transform = transform.rotated(by: -0.5*CGFloat.pi)

        case .up, .upMirrored:        
            break
        @unknown default:
            break
        }

        switch result.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        default:
            break;
        }

        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        guard let colorSpace = cgImage.colorSpace else {
            return nil
        }

        guard let
            context = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: UInt32(cgImage.bitmapInfo.rawValue)
            ) else {
                return nil
        }

        context.concatenate(transform);

        switch result.imageOrientation {

        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: height, height: width))

        default:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        }

        // And now we just create a new UIImage from the drawing context
        guard let newCGImg = context.makeImage() else {
            return nil
        }

        let img = UIImage(cgImage: newCGImg)

        return img;
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
          let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
          return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
              _ in draw(in: CGRect(origin: .zero, size: canvas))
          }
      }
      func resized(withMaxVal val: CGFloat) -> UIImage? {
        
        var width = size.width
        var height = size.height
        
        if size.width > val || size.height > val {
            let ratio = size.width / size.height
            if ratio > 1 {
                width = CGFloat(val)
                height = CGFloat(roundf(Float(width / CGFloat(ratio))))
            } else {
                height = CGFloat(val)
                width = CGFloat(roundf(Float(height * CGFloat(ratio))))
            }
        }
        
         // let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
          let canvas = CGSize(width: width, height: height)
          return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
              _ in draw(in: CGRect(origin: .zero, size: canvas))
          }
      }
    
    
    func scaleAndRotateImages() -> UIImage?
    {
        let kMaxResolution = 640 // Or whatever

        let imgRef = self.cgImage

        let width = imgRef!.width
        let height = imgRef!.height


        var transform: CGAffineTransform = .identity
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        if width > kMaxResolution || height > kMaxResolution {
            let ratio = CGFloat(width) / CGFloat(height)
            if ratio > 1 {
                bounds.size.width = CGFloat(kMaxResolution)
                bounds.size.height = CGFloat(roundf(Float(bounds.size.width / CGFloat(ratio))))
            } else {
                bounds.size.height = CGFloat(kMaxResolution)
                bounds.size.width = CGFloat(roundf(Float(bounds.size.height * CGFloat(ratio))))
            }
        }

        let scaleRatio = bounds.size.width / CGFloat(width)
        let imageSize = CGSize(width: imgRef!.width, height: imgRef!.height)
        var boundHeight : CGFloat
        
        let orient = self.imageOrientation
        switch orient {
            case .up /*EXIF = 1 */:
                transform = CGAffineTransform.identity
            case .upMirrored /*EXIF = 2 */:
                transform = CGAffineTransform(translationX: imageSize.width, y: 0.0)
                transform = transform.scaledBy(x: -1.0, y: 1.0)
            case .down /*EXIF = 3 */:
                transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
                transform = transform.rotated(by: .pi)
            case .downMirrored /*EXIF = 4 */:
                transform = CGAffineTransform(translationX: 0.0, y: imageSize.height)
                transform = transform.scaledBy(x: 1.0, y: -1.0)
            case .leftMirrored /*EXIF = 5 */:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
                transform = transform.scaledBy(x: -1.0, y: 1.0)
                transform = transform.rotated(by: 3.0 * .pi / 2.0)
            case .left /*EXIF = 6 */:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(translationX: 0.0, y: imageSize.width)
                transform = transform.rotated(by: 3.0 * .pi / 2.0)
            case .rightMirrored /*EXIF = 7 */:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                transform = transform.rotated(by: .pi / 2.0)
            case .right /*EXIF = 8 */:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(translationX: imageSize.height, y: 0.0)
                transform = transform.rotated(by: .pi / 2.0)
        @unknown default:
                transform = CGAffineTransform.identity
        }
        
        
        UIGraphicsBeginImageContext(bounds.size)

        let context = UIGraphicsGetCurrentContext()

        if orient == .right || orient == .left {
            context?.scaleBy(x: -scaleRatio, y: scaleRatio)
            context?.translateBy(x: CGFloat(-height), y: 0)
        } else {
            context?.scaleBy(x: scaleRatio, y: -scaleRatio)
            context?.translateBy(x: 0, y: CGFloat(-height))
        }

        context?.concatenate(transform)

        UIGraphicsGetCurrentContext()?.draw(imgRef!, in: CGRect(x: 0, y: 0, width: width, height: height))
       // UIGraphicsGetCurrentContext()?.draw(in: imgRef, image: CGRect(x: 0, y: 0, width: width, height: height))
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCopy;
    }
}


extension String
{
    func ChangeSpacetoPer20()->String{
        return self.replacingOccurrences(of: " ", with: "%20")
    }
    
    func localizeString(string: String)->String {
        let path = Bundle.main.path(forResource: string, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}


extension Array {
  mutating func remove(at indexes: [Int]) {
    for index in indexes.sorted(by: >) {
      remove(at: index)
    }
  }
}
