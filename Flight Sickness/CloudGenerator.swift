//
//  CloudGenerator.swift
//  
//
//  Created by Coleman Oei on 12/3/17.
//

import UIKit

class CloudGenerator{
    
    var clouds: [UIImageView]
    
    init() {
        clouds = [UIImageView]()
    }
    
    func genCloud(view: UIView, xpos: CGFloat, ypos: CGFloat){
        let randNum = arc4random_uniform(3) + 1
        let cloudimg = UIImage(named: "Cloud\(randNum)")
        let cloud = UIImageView(image: cloudimg)
        self.clouds.append(cloud)
        view.addSubview(cloud)
        cloud.center.x = xpos
        cloud.center.y = ypos
        view.sendSubview(toBack: cloud)
        let dir = arc4random_uniform(2)
        var end = 0 - (cloud.frame.width)/2
        if(dir == 1){
            end = view.frame.width + (cloud.frame.width)/2
        }
        let randDur = Double(arc4random_uniform(20) + 20)
        UIView.animate(withDuration: randDur, delay: 0, options: [.curveLinear], animations: {
            cloud.center.x = end
        }, completion: {
            (value: Bool) in
            if value {
                self.resetCloud(cloud: cloud, view: view)
            }else{
                self.genCloud(view: view, xpos: CGFloat(arc4random_uniform(UInt32(view.frame.width))) , ypos: CGFloat(arc4random_uniform(UInt32(view.frame.height))))
            }
        })

    }
    
    func resetCloud(cloud:UIImageView, view:UIView){
        let randNum = arc4random_uniform(3) + 1
        let cloudimg = UIImage(named: "Cloud\(randNum)")
        cloud.image = cloudimg
        cloud.frame.size.height = (cloudimg?.size.height)!
        cloud.frame.size.width = (cloudimg?.size.width)!
        let dir = arc4random_uniform(2)
        var start = view.frame.width + (cloud.frame.width)/2
        var end = 0 - (cloud.frame.width)/2
        if(dir == 1){
            start = end
            end = view.frame.width + (cloud.frame.width)/2
        }
        let yStart = CGFloat(arc4random_uniform(UInt32(view.frame.height)))
        cloud.center.x = start
        cloud.center.y = yStart
        let randDur = Double(arc4random_uniform(20) + 30)
        UIView.animate(withDuration: randDur, delay: 0, options: [.curveLinear], animations: {
            cloud.center.x = end
        }, completion: {
            (value: Bool) in
            if value {
                self.resetCloud(cloud: cloud, view: view)
            }
            else{
                self.genCloud(view: view, xpos: CGFloat(arc4random_uniform(UInt32(view.frame.width))) , ypos: CGFloat(arc4random_uniform(UInt32(view.frame.height))))
            }
        })
    }
    
    func genClouds(view: UIView){
        
        for _ in 1...5{
            genCloud(view: view, xpos: CGFloat(arc4random_uniform(UInt32(view.frame.width))) , ypos: CGFloat(arc4random_uniform(UInt32(view.frame.height))))
        }
    }
}
