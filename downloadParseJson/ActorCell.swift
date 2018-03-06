import UIKit

class ActorCell: UITableViewCell {
  
  let img: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let label: UILabel = {
    let l = UILabel()
    l.translatesAutoresizingMaskIntoConstraints = false
    l.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    return l
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // don't use awake from nib
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    selectionStyle = .none
    setupImage()
    setupLabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setupImage(){
    addSubview(img)
    img.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
    img.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
    img.widthAnchor.constraint(equalToConstant: 130).isActive = true
    img.heightAnchor.constraint(equalToConstant: 130).isActive = true
    img.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
  }
  
  func setupLabel(){
    addSubview(label)
    label.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    label.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 20).isActive = true
  }
  
  
  func updateViews( name: String,img i: String) {
    label.text = name
    guard let url = URL(string: i ) else { print("not faild url"); return }
    URLSession.shared.dataTask(with: url) { (data, resp, error) in
      if ( error != nil || resp == nil) {
        print("failed to download image")
        return
      }
      
      // propably would wanna cache image for some specified time.
      DispatchQueue.main.async {
        if let image = UIImage(data: data!) {
          self.img.image = image
        }
      }
      
      }.resume()
    
  }
  
}
