//
//  ViewController.m
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

#import "ViewController.h"
#import "VKAfterTimeTextField.h"

@interface ViewController () <VKAfterTimeTextFieldDelegate>

@property (weak, nonatomic) IBOutlet VKAfterTimeTextField *afterTimeTextField;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeAgo;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Set VKAfterTimeTextFieldDelegate delegate
    self.afterTimeTextField.afterTimeDelegate = self;
    
    // Set time interval when notification should fire
    self.afterTimeTextField.notificationInterval = 1;
    
    self.afterTimeTextField.text = @"Aloha!";
}

#pragma mark - VKAfterTimeTextFieldDelegate

-(void)afterTimeTextField:(VKAfterTimeTextField *)textField didEndEditing:(NSTimeInterval)timeInterval
{
    NSLog(@"Text Field did end edit. Notification interval: %i", (int)timeInterval);
}

#pragma mark - Actions

- (IBAction)buttonCheckSeconds:(id)sender
{
    self.labelTimeAgo.text = [NSString stringWithFormat:@"Edited %i seconds ago", (int)[self.afterTimeTextField getEditSecondsAgo]];
}

- (IBAction)buttonCheckTime:(id)sender
{
    NSDate *date = [self.afterTimeTextField getEditDateTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.labelTimeAgo.text = [NSString stringWithFormat:@"Last time edited at %@", [formatter stringFromDate:date]];
}

#pragma mark - Other

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.afterTimeTextField isFirstResponder])
        [self.afterTimeTextField resignFirstResponder];
}

@end
