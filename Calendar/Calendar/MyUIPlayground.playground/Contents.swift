//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

class ForeCastStatusView : UIView {


  var statusLabel: UILabel!
  var statusIconImageView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor =  UIColor(named: "skyColor")


    statusIconImageView =  UIImageView(frame: CGRect(x:frame.size.width -  20 , y: 0, width:20 , height: 20))
    statusIconImageView.image = UIImage(named: "background")
    statusIconImageView.contentMode = .scaleAspectFill
    addSubview(statusIconImageView)



    statusLabel = UILabel(frame: CGRect(x:0 , y: frame.size.height -  20, width:frame.size.width , height: 20))
    statusLabel.textColor =  UIColor.white
    statusLabel.text = "Cloudly"
    addSubview(statusLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

let f = ForeCastStatusView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
