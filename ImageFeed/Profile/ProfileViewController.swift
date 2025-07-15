import UIKit

final class ProfileViewController: UIViewController {
    
    private let profileImage = UIImage(named: "unsplash")
    private let logoutImage = UIImage(named: "Logout")
    private var profilePhoto = UIImageView()
    private var usernameLabel = UILabel()
    private var bioLabel = UILabel()
    private var userTagLabel = UILabel()
    private var logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI
        configView()
        
        // Turning it off Autoresizing
        [profilePhoto, usernameLabel, bioLabel, userTagLabel, logoutButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        // Constraints
        NSLayoutConstraint.activate([
            profilePhoto.widthAnchor.constraint(equalToConstant: 70),
            profilePhoto.heightAnchor.constraint(equalToConstant: 70),
            profilePhoto.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profilePhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            usernameLabel.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            userTagLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            userTagLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: userTagLabel.bottomAnchor, constant: 8),
            bioLabel.leadingAnchor.constraint(equalTo: userTagLabel.leadingAnchor),
            
            logoutButton.centerYAnchor.constraint(equalTo: profilePhoto.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func configView() {
        view.backgroundColor = UIColor(named: "YPBlack")
        
        usernameLabel.text = "Екатерина Новикова"
        usernameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        usernameLabel.textColor = UIColor(named: "YPWhite")
        
        userTagLabel.text = "@ekaterina_nov"
        userTagLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        userTagLabel.textColor = UIColor(named: "YPGray")
        
        bioLabel.text = "Hello,world!"
        bioLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        bioLabel.textColor = UIColor(named: "YPWhite")
        
        profilePhoto.image = profileImage
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.cornerRadius = 35
        
        logoutButton.setImage(logoutImage, for: .normal)
        logoutButton.tintColor = UIColor(named: "YPRed")
        logoutButton.contentHorizontalAlignment = .right
    }
}

