//
//  ImageFetch.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageWithURL(urlString: String?) {
        
        self.image = nil //clears image
        
        if let articleImageViewURL = urlString {
            let url = URL(string: articleImageViewURL)
            if let url = url {
                
                DispatchQueue.global(qos: .background).async{
                    do {
                        let data = try Data(contentsOf: url)
                        DispatchQueue.main.async{
                            self.image = UIImage(data: data)
                            
                        }
                    }
                    catch {
                        print(error)
                    }
                }
                
            }
        }
        
    }
}
