import Foundation

<<<<<<< HEAD
let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)

extension String {
    func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
=======
extension String {
    public static let fontSFCompactRoundedBold: String = "SFCompactRounded-Bold"
    public static let fontSFCompactRoundedRegular: String = "SFCompactRounded-Regular"
>>>>>>> d32e507d6967874cc17b1f75b315a7a2d5502fd3
}
