//
//  ViewController.swift
//  ImageFeed
//
//  Created by Тимофей Спирин on 09.12.2024.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    @IBOutlet private var table: UITableView!
    
    private let photoName: [String] = Array (0..<20).map{ "\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.rowHeight = 200
        table.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
//    MARK: - Class
    
}

// MARK: -
    extension ImagesListViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)

            guard let imageListCell = cell as? ImagesListCell else {
                return UITableViewCell()
            }

            configCell(for: imageListCell)

            return imageListCell
        }
    }

    extension ImagesListViewController {
        func configCell(for cell: ImagesListCell) { }
    }

    extension ImagesListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    }

