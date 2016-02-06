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
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: baseUrl + posterPath)
            posterImageView.alpha = 0.0
            posterImageView.setImageWithURL(posterUrl!)
            
            UIView.animateWithDuration(0.666, animations: { () -> Void in
                    self.posterImageView.alpha = 1.0
                }
            )
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
