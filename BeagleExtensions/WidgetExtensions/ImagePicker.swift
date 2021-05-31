import Foundation
import Beagle

public struct ImagePicker: ServerDrivenComponent {
    
    var url: String
    var width: Int?
    var height: Int?
    var cornerRadius: Double?
    public static var instance: UIImageView?
    
    public func toView(renderer: BeagleRenderer) -> UIView {
        let imagePicker = UIImageView()
        guard let width = width, let height = height, let cornerRadius = cornerRadius, let url = URL(string: url) else {
            return UIView()
        }
        imagePicker.frame.size.width = CGFloat(width)
        imagePicker.frame.size.height = CGFloat(height)
        imagePicker.layer.masksToBounds = true
        imagePicker.layer.cornerRadius = CGFloat(cornerRadius)
        
        imagePicker.contentMode = .scaleToFill
      
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                imagePicker.image = image
                imagePicker.contentMode = .scaleToFill
            })
        }.resume()

//        imagePicker.sd_setImage(with: url) { (image, error, cache, url) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//                imagePicker.image = image
//            })
//
//        }
        ImagePicker.instance = imagePicker
        return imagePicker
    }
}
