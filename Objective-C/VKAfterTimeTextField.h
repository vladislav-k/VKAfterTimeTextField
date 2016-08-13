//
//  VKAfterTimeTextField.h
//  Version: 1.0
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

#import <UIKit/UIKit.h>

@class VKAfterTimeTextField;

/*!
 @protocol  VKAfterTimeTextFieldDelegate
 @abstract  Delegate protocol of `VKAfterTimeTextField`
 */
@protocol VKAfterTimeTextFieldDelegate <NSObject>

/*!
 @method    afterTimeTextField:didEndEditing:
 @abstract  Delegate method which called after time interval is
 @param     textField
            <code>VKAfterTimeTextField</code> which called this method
 @param     timeInterval
            Time interval after which this method was called
 */
-(void)afterTimeTextField:(VKAfterTimeTextField *)textField didEndEditing:(NSTimeInterval)timeInterval;

@end

@interface VKAfterTimeTextField : UITextField

/*!
 @property  afterTimeDelegate
 @abstract  Set VKAfterTimeTextFieldDelegate of text field
 @See       VKAfterTimeTextFieldDelegate protocol
 */
@property (nonatomic, weak) id <VKAfterTimeTextFieldDelegate> afterTimeDelegate;

/*!
 @property  notificationInterval
 @abstract  Set time interval which <code>VKAfterTimeTextField</code> should send notification after used did end editing
 @note      Min value is 0.5 seconds. Default value is 0.5 seconds
 */
@property (nonatomic, assign) NSTimeInterval notificationInterval;

/*!
 @method    getEditDateTime
 @abstract  Allows you to get date time object of last edit time
 @return    Date time object `NSDate`
 */
-(NSDate *)getEditDateTime;

/*!
 @method    getEditSecondsAgo
 @abstract  Allows you to check how many seconds ago text field was edited
 @return    Seconds since last edit
 */
-(NSTimeInterval)getEditSecondsAgo;

@end
