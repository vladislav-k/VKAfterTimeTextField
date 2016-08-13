//
//  ViewController.swift
//  VKATTextFieldExample-Swift
//
//  Created by Vladislav Kovalyov on 8/12/16.
//  Copyright © 2016 WOOPSS.com http://woopss.com/
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class ViewController: UIViewController, VKAfterTimeTextFieldDelegate
{
    @IBOutlet weak var afterTimeTextField: VKAfterTimeTextField!
    @IBOutlet weak var labelTimeAgo: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.afterTimeTextField.afterTimeDelegate = self
        
        // Check time interval when notification should fire
        self.afterTimeTextField.notificationInterval = 1
        
        self.afterTimeTextField.text = "Aloha!"
    }
    
    // MARK: - Actions
    @IBAction func onCheckSeconds(sender: AnyObject)
    {
        self.labelTimeAgo.text = "Edited \(Int(self.afterTimeTextField.getEditSecondsAgo())) seconds ago"
    }
    
    @IBAction func onCheckTime(sender: AnyObject)
    {
        let date = self.afterTimeTextField.getEditDateTime()
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        
        self.labelTimeAgo.text = "Last time edited at \(formatter.stringFromDate(date))"
    }
    
    // MARK: - VKAfterTimeTextFieldDelegate
    func afterTimeTextFieldDidEndEditing(textField: VKAfterTimeTextField, afterTimeInterval timeInterval: NSTimeInterval)
    {
        print("Text Field did end edit. Notification interval: \(timeInterval)")
    }
    
    // MARK: - Other
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if self.afterTimeTextField.isFirstResponder()
        {
            self.afterTimeTextField.resignFirstResponder()
        }
    }
}

