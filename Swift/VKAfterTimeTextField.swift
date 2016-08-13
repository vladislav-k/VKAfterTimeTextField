//
//  VKAfterTimeTextField.m
//  VKATTestFieldExample
//
//  Created by Vladislav Kovalyov on 8/11/16.
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

class VKAfterTimeTextField: UITextField
{
    /**
     Set time interval which VKAfterTimeTextField should send notification after used did end editing
     Min value is 0.5 seconds
     Default value is 0.5 seconds
     */
    var notificationInterval: NSTimeInterval = 0.5
    {
        didSet
        {
            if notificationInterval < 0.5
            {
                notificationInterval = 0.5
            }
        }
    }
    
    /**
     Set VKAfterTimeTextFieldDelegate of text field
     - See: VKAfterTimeTextFieldDelegate protocol
     */
    var afterTimeDelegate: VKAfterTimeTextFieldDelegate?
    
    /**
     Property stores time interval since 1970 after user did end editing
     */
    private var lastTimeEdit: NSTimeInterval = NSDate().timeIntervalSince1970
    
    // MARK: - Init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setupTextField()
    }
    
    // MARK: - Public methods
    
    /**
     Function allows you to get date time object of last edit time
     - Returns: Date time object `NSDate`
     */
    func getEditDateTime() -> NSDate
    {
        return NSDate(timeIntervalSince1970: self.lastTimeEdit)
    }
    
    /**
     Function allows you to check how many seconds ago text field was edited
     - Returns: Seconds since last edit
     */
    func getEditSecondsAgo() -> NSTimeInterval
    {
        return NSDate().timeIntervalSince1970 - self.lastTimeEdit
    }
    
    // MARK: - Private mthods
    
    /**
     Perform initial setup of `VKAfterTimeTextField`
     */
    private func setupTextField()
    {
        // Set default last time edit
        self.lastTimeEdit = NSDate().timeIntervalSince1970
        
        // Add listener for .EditingChanged event
        self.addTarget(self, action: #selector(VKAfterTimeTextField.textFieldEditingChanged), forControlEvents: .EditingChanged)
    }
    
    /**
     Function which listens for text field's .EditingChanged event
     */
    @objc private func textFieldEditingChanged()
    {
        self.lastTimeEdit = NSDate().timeIntervalSince1970
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(VKAfterTimeTextField.triggerNotification), object: nil)
        self.performSelector(#selector(VKAfterTimeTextField.triggerNotification), withObject: nil, afterDelay: self.notificationInterval)
    }
    
    /**
     Function calls `afterTimeDelegate` and lets you know when user did end editing with specfic time interval
     - See `notificationInterval` property
     - See `VKAfterTimeTextFieldDelegate` protocol
     */
    @objc private func triggerNotification()
    {
        self.afterTimeDelegate?.afterTimeTextFieldDidEndEditing(self, afterTimeInterval: self.notificationInterval)
    }
}

/**
 Base protocol of `VKAfterTimeTextField`
 */
protocol VKAfterTimeTextFieldDelegate
{
    /**
     Delegate method which called after time interval is expired.
     - Parameter textField VKAfterTimeTextField which called this method
     - Parameter timeInterval Time interval after which this method was called
     */
    func afterTimeTextFieldDidEndEditing(textField: VKAfterTimeTextField, afterTimeInterval timeInterval: NSTimeInterval)
}