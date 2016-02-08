//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by William Johnson on 2/4/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var movies: [MovieModel] = []
    var endpoint: String!
    var filteredData: [MovieModel]!
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        networkErrorView.hidden = true;
        
        filteredData = movies
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self

        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                
                if(error != nil) {
                    self.networkErrorView.hidden = false
                }
                
                if let data = dataOrNil {
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            let moviesArr: NSArray = (responseDictionary["results"] as? NSArray)!
                            
                            for movie in moviesArr {
                                self.movies.append(MovieModel(json: (movie as? NSDictionary)!))
                            }
                            
                            self.filteredData = self.movies

                            self.tableView.reloadData()
                            
                    }
                }
        })
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = filteredData[indexPath.row]
        
        if let posterPath = movie.poster! as String? {
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: baseUrl + posterPath)
            cell.titleLabel.text = "\(movie.title!)"
            cell.overviewLabel.text = "\(movie.overview!)"
            cell.posterView.setImageWithURL(posterUrl!)
            
        }
        
        //let backgroundView = UIView()
        //backgroundView.backgroundColor = UIColor.redColor()
        //cell.selectedBackgroundView = backgroundView
        cell.selectionStyle = .None


        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? movies : movies.filter({(movie: MovieModel) -> Bool in
            return movie.title!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        tableView.reloadData()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
                
                // ... Use the new data to update the data source ...
                
                // Reload the tableView now that there is new data
                self.tableView.reloadData()
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
        });
        task.resume()
    }

    func highlightCell(cell: UITableViewCell){
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blackColor()
        cell.selectedBackgroundView = backgroundView
        cell.textLabel?.textColor = UIColor.whiteColor()
    }

    
    // MARK: - Navigation
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies[indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        detailViewController.movie = movie
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
