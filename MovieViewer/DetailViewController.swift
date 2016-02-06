//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by William Johnson on 2/4/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    var movie: MovieModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        overviewLabel.text = movie.overview
        overviewLabel.sizeToFit()
        titleLabel.text = movie.title
        
        if let posterPath = movie.poster! as String? {
            let lowResPath = "http://image.tmdb.org/t/p/w45"
            let highResPath = "http://image.tmdb.org/t/p/w500"
            let lowResUrlRequest = NSURLRequest(URL: NSURL(string: lowResPath + posterPath)!)
            let highResUrlRequest = NSURLRequest(URL: NSURL(string: highResPath + posterPath)!)
            
            self.posterImageView.setImageWithURLRequest(
                lowResUrlRequest,
                placeholderImage: nil,
                success: { (lowResUrlRequest, lowResResponse, lowResImage) -> Void in
                    self.posterImageView.alpha = 0.0
                    self.posterImageView.image = lowResImage
                    
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.posterImageView.alpha = 1.0
                        }, completion: { (success) -> Void in
                        
                            self.posterImageView.setImageWithURLRequest(
                                highResUrlRequest,
                                placeholderImage: lowResImage,
                                success: { (highResUrlRequest, highResResponse, highResImage) -> Void in
                                    self.posterImageView.image = highResImage
                                }, failure: { (highResUrlRequest, highResResponse, error) -> Void in
                                    self.posterImageView.image = lowResImage
                            })
                        }
                    )
                    
                }, failure: { (lowResUrlRequest, lowResResponse, error) -> Void in
                    self.posterImageView.backgroundColor = UIColor.grayColor()
            })
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
