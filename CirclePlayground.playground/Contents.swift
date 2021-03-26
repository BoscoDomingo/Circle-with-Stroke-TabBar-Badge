//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        let circle = UIImage.circleWithStroke(diameter: 100, stroke: 10, color: .white, strokeColor: .black)
        view.addSubview(UIImageView(image: circle))
        self.view = view
    }
}

extension UIImage {
    static func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter)).image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: diameter, height: diameter)
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    }

    static func circleWithStroke(diameter: CGFloat, stroke: CGFloat, color: UIColor, strokeColor: UIColor) -> UIImage {
        let totalDiameter: CGFloat = diameter + stroke * 2

        let circle = UIImage.circle(diameter: diameter, color: color),
            strokeCircle = UIImage.circle(diameter: totalDiameter, color: strokeColor)

        let anchorStrokeBadge = CGPoint(x: 0, y: 0),
            anchorBadge = CGPoint(x: stroke, y: stroke)

        return UIGraphicsImageRenderer(size: CGSize(width: totalDiameter, height: totalDiameter)).image { ctx in
            strokeCircle.draw(in: CGRect(origin: anchorStrokeBadge, size: strokeCircle.size))
            circle.draw(in: CGRect(origin: anchorBadge, size: circle.size))
        }
    }

    func addTabBarBadge(circleDiameter: CGFloat, stroke: CGFloat, color: UIColor, strokeColor: UIColor) -> UIImage {
        let badge = UIImage.circleWithStroke(diameter: circleDiameter, stroke: stroke, color: color, strokeColor: strokeColor),
            rect: CGRect = .init(x: 0, y: 0, width: size.width, height: size.height)

        let anchorIcon = CGPoint(x: rect.midX - (size.width / 2), y: rect.midY - (size.height / 2)),
            anchorBadge = CGPoint(x: rect.width - badge.size.width, y: 0)

        return UIGraphicsImageRenderer(size: rect.size).image { ctx in
            self.draw(in: CGRect(origin: anchorIcon, size: self.size))
            badge.draw(in: CGRect(origin: anchorBadge, size: badge.size))
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
