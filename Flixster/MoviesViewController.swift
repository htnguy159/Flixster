//
//  MoviesViewController.swift
//  Flixster
//
//  Created by Huong on 9/25/20.
//

import UIKit
import AlamofireImage

// STEP 1: add in UITableViewDataSource and UITableViewDelagate
// click fix to add the expected two functions

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
   
    // Properties available for the lifetime of that screen
    // Array of dictionaries
    // Parenthesis at the end to indication of something
    // Creation of an array of dictionaries
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // STEP 3
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        print("Hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
                // make movies look at dataDictionary and get out results
                // cast as an array of dictionaries
                // download array of movies and store it here
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                // have tableview call the 2 functions again to avoid empty screen
                self.tableView.reloadData()
                
                print(dataDictionary)
            
                
            
              

           }
        }
        task.resume()
    }
    // STEP 2: implement the two expected functions
    // Asking for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // For this particular row, give cell
    // This function is called 50 times
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell = UITableViewCell()
        // dequeueReusableCell if another cell is off screen, recycle cell
        // uses less space
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
    
        
        let movie = movies[indexPath.row]
        // cast title to type String => as! String
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string:
                                baseUrl + posterPath)!
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
