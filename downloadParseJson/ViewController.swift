//
//  ViewController.swift
//  downloadParseJson
//
//  Created by Ahmed Eid on 05/03/2018.
//  Copyright © 2018 Ahmed Eid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var data: Actors = Actors(actors: [])

  lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.delegate = self
    tv.dataSource = self
    return tv
  }()
  
  lazy var tableViewCell: UITableViewCell = {
    let tvc = UITableViewCell()
    // outta habbit .
    tvc.translatesAutoresizingMaskIntoConstraints = false
    return tvc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableSetup()
    fetchData()
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  let actorCell = "ACTOR_CELL"
  let defaultCell = "DEFAULT_CELL"
}


extension ViewController {
  
  func tableSetup(){
    tableView.addSubview(tableViewCell)
    tableView.register(ActorCell.self, forCellReuseIdentifier: actorCell )
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCell )
    view.addSubview(tableView)
    addTableViewConstraints()
  }
  
  func addTableViewConstraints(){
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
  }
  
  
  func fetchData(){
    guard let url = URL(string: "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors")
    else {return}
    
    URLSession.shared.dataTask(with: url) { (data, resp, error) in
      if error != nil || resp == nil {
        // it failed needs feed back.
        print(error.debugDescription)
        return
      }
      
      let decoder = JSONDecoder()
      if let actors = try? decoder.decode(Actors.self, from: data!) {
        print(actors)
        
        DispatchQueue.main.async {
          self.data = actors
          self.tableView.reloadData()
        }
        
      }else{
        print("parsing failed")
      }

    }.resume()
    
    
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.actors.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: actorCell ) as? ActorCell {
      cell.updateViews(name: (data.actors[indexPath.row].name) , img: (data.actors[indexPath.row].image))
      return cell
    }
    
    return tableView.dequeueReusableCell(withIdentifier: defaultCell)!
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
  
}

