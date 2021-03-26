import UIKit

extension UIImage {
    static func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter)).image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: diameter, height: diameter)
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    }

    static func circleWithStroke(circleDiameter: CGFloat, stroke: CGFloat, color: UIColor, strokeColor: UIColor) -> UIImage {
        let totalDiameter: CGFloat = circleDiameter + stroke * 2

        let circle = UIImage.circle(diameter: diameter, color: color),
            strokeCircle = UIImage.circle(diameter: totalDiameter, color: strokeColor)

        let anchorStrokeBadge = CGPoint(x: 0, y: 0),
            anchorBadge = CGPoint(x: stroke, y: stroke)

        return UIGraphicsImageRenderer(size: totalDiameter).image { ctx in
            strokeCircle.draw(in: CGRect(origin: anchorStrokeBadge, size: strokeCircle.size))
            circle.draw(in: CGRect(origin: anchorBadge, size: circle.size))
        }
    }

    func addTabBarBadge(circleDiameter: CGFloat, stroke: CGFloat, color: UIColor, strokeColor: UIColor) -> UIImage {
        let badge = UIImage.circleWithStroke(diameter: diameter, stroke: stroke, color: color, strokeColor: strokeColor),
            rect: CGRect = .init(x: 0, y: 0, width: size.width, height: size.height)

        let anchorIcon = CGPoint(x: rect.midX - (size.width / 2), y: rect.midY - (size.height / 2)),
            anchorBadge = CGPoint(x: rect.width - badge.size.width, y: 0),

        return UIGraphicsImageRenderer(size: rect.size).image { ctx in
            self.draw(in: CGRect(origin: anchorIcon, size: self.size))
            badge.draw(in: CGRect(origin: anchorBadge, size: badge.size))
        }
    }
}
