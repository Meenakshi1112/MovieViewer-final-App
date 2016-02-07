//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by user115593 on 1/24/16.
//  Copyright © 2016 user115593. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let refreshControl = UIRefreshControl()
    var movies: [NSDictionary]?
    
    var endpoint: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        tableView.dataSource = self
        tableView.delegate = self
        
        
    
        //MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        /*let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(endpoint)? api_key=\(apiKey)")
        
        let request = NSURLRequest(
            URL: url!)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
            data, options:[]) as? NSDictionary {
            print("response: \(responseDictionary)")
                
            self.movies = responseDictionary["results"] as! [NSDictionary]
            self.tableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            }
            }
            })
        task.resume()*/
        
        networkCall()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            if let movies  = movies {
                return movies.count
                
            } else {
                return 0
            }
            
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        _ = self.view
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.grayColor()
        cell.selectedBackgroundView = backgroundView
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.Title.text = title
        cell.Overview.text = overview
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String {
        let imageUrl = NSURL(string: baseUrl + posterPath)
        cell.posterView.setImageWithURL(imageUrl!)
        }
        return cell
        
    }
    
    func networkCall(){
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        print("THIS IS THE ENDPOINT: ", endpoint)
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!)
            //cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            //timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                            
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            self.refreshControl.endRefreshing()
                            
                    }
                }
        })
        task.resume()
    }

            
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        networkCall()
        
        /*MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(endpoint)?"api_key="\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
            data, options:[]) as? NSDictionary {
            print("response: \(responseDictionary)")
            
            }
            }
            })
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        refreshControl.endRefreshing()
        task.resume()
        // Reload the tableView now that there is new data
        self.tableView.reloadData()
        
        // Tell the refreshControl to stop spinning*/
        
    }


// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexpath = tableView.indexPathForCell(cell)
        let movie = movies![indexpath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movie = movie 
        
        //Get the new view controller using segue.destinationViewController.
//Pass the selected object to the new view controller.
}

}