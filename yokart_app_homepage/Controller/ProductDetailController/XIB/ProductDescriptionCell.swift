//
//  ProductDescriptionCell.swift
//  yokart_app_homepage
//
//  Created by User on 19/09/25.
//

import UIKit

class ProductDescriptionCell: UITableViewCell {

    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var btnToggle: UIButton!


    var isExpanded: Bool = false {
        didSet {
            updateDescriptionText()
        }
    }


    var onToggleExpand: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        btnToggle.addTarget(self, action: #selector(toggleDescription), for: .touchUpInside)
    }

    func configureCell(description: String, isExpanded: Bool) {
        self.isExpanded = isExpanded

        let processedHTML = description
            .replacingOccurrences(of: "<li>", with: "<li>• ")
            .replacingOccurrences(of: "</li>", with: "<br>")

        let divTitles = extractDivTitles(from: processedHTML)

        guard let htmlData = processedHTML.data(using: .utf8) else {
            self.lblProductDescription.text = description
            return
        }

        do {
            let attributedString = try NSMutableAttributedString(
                data: htmlData,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.lineSpacing = 0

            let fullRange = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttributes([
                .font: UIFont.systemFont(ofSize: 15),
                .paragraphStyle: paragraphStyle
            ], range: fullRange)

            let boldFont = UIFont.boldSystemFont(ofSize: 16)
            for title in divTitles {
                let nsString = attributedString.string as NSString
                let range = nsString.range(of: title)
                if range.location != NSNotFound {
                    attributedString.addAttribute(.font, value: boldFont, range: range)
                }
            }

            self.lblProductDescription.attributedText = attributedString
        } catch {
            self.lblProductDescription.text = description
        }

        updateDescriptionText()
    }

    private func updateDescriptionText() {
        lblProductDescription.numberOfLines = isExpanded ? 0 : 3
        btnToggle.setTitle(isExpanded ? "Show Less" : "Show More", for: .normal)
    }

    @objc private func toggleDescription() {
        onToggleExpand?()
    }

    private func extractDivTitles(from html: String) -> [String] {
        var titles: [String] = []

        let pattern = "<div>(.*?)</div>"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let nsString = html as NSString
            let matches = regex.matches(in: html, options: [], range: NSRange(location: 0, length: nsString.length))
            for match in matches {
                if match.numberOfRanges == 2 {
                    let title = nsString.substring(with: match.range(at: 1)).trimmingCharacters(in: .whitespacesAndNewlines)
                    titles.append(title)
                }
            }
        }

        return titles
    }
}
