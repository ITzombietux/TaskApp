//
//  TableViewCell.swift
//  TasksApp
//
//  Created by zombietux on 12/02/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView?
    @IBOutlet weak var checkboxImageView: UIImageView?
    
    var updatingDelegate: TaskCellUpdating?
    var object: Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView?.textContainerInset = .zero
        textView?.textContainer.lineFragmentPadding = 0
        
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        commonInit()
    }
    
    func commonInit() {
        setText("", completed: false)
        
        textView?.delegate = self
        
        updatingDelegate = nil
        object = nil
    }
    
    func setText(_ text: String, completed: Bool)
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        
        var attributes = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-ExtraLight", size: 15.0)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.22, green: 0.24, blue: 0.25, alpha: 1.0),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        if completed
        {
            checkboxImageView?.image = UIImage(named: "checkbox-ticked")
            
            attributes[NSAttributedString.Key.strikethroughStyle] = NSNumber(value: NSUnderlineStyle.single.rawValue)
        }
        else
        {
            checkboxImageView?.image = UIImage(named: "checkbox")
        }
        
        textView?.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    
    func beginEditing() {
        textView?.becomeFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updatingDelegate?.onTextViewChanged(text: textView.text, object: object)
    }
}
