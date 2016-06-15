//
//  MessageViewController.swift
//  Postcard
//
//  Created by Adelita Schule on 5/13/16.
//  Copyright © 2016 operatorfoundation.org. All rights reserved.
//

import Cocoa

class MessageViewController: NSViewController
{
    @IBOutlet weak var replyButton: NSButton!
    @IBOutlet weak var deleteButton: NSButton!
    @IBOutlet var postcardObjectController: NSObjectController!
    
    var managedContext = (NSApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do view setup here.
        styleButtons()
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?)
    {
        //Populate compose view with this message information.
        
        if segue.identifier == "Reply To Message"
        {
            if let rePostcard = postcardObjectController.content as? Postcard
            {
                if let composeVC = segue.destinationController as? ComposeViewController
                {
                    if let from = rePostcard.from, let sendTo = from.email, let subject = rePostcard.subject
                    {
                        composeVC.sendTo = sendTo
                        composeVC.reSubject = "re: \(subject)"
                    }
                }
            }
        }
    }
    
    func styleButtons()
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        var buttonFont = NSFont.boldSystemFontOfSize(13)
        if let maybeFont = NSFont(name: PostcardUI.boldFutura, size: 13)
        {
            buttonFont = maybeFont
        }
        
        let attributes = [NSForegroundColorAttributeName: NSColor.whiteColor(),NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: buttonFont]
        let altAttributes = [NSForegroundColorAttributeName: PostcardUI.blue, NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: buttonFont]
        
        replyButton.attributedTitle = NSAttributedString(string: "REPLY", attributes: attributes)
        replyButton.attributedAlternateTitle = NSAttributedString(string: "REPLY", attributes: altAttributes)
        
        deleteButton.attributedTitle = NSAttributedString(string: "DELETE", attributes: attributes)
        deleteButton.attributedAlternateTitle = NSAttributedString(string: "DELETE", attributes: altAttributes)
    }
}
