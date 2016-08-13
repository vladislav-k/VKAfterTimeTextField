//
//  VKAfterTimeTextField.m
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

#import "VKAfterTimeTextField.h"

@interface VKAfterTimeTextField()

@property (nonatomic, strong) id <UITextFieldDelegate> textFieldDelegate;
@property (nonatomic, assign) NSTimeInterval lastTimeEdit;

@end

@implementation VKAfterTimeTextField

#pragma mark - Init

-(instancetype)init
{
    if (self = [super init])
    {
        [self setupTextField];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupTextField];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupTextField];
    }
    
    return self;
}

#pragma mark - Public methods

-(NSDate *)getEditDateTime
{
    return [NSDate dateWithTimeIntervalSince1970:self.lastTimeEdit];
}

-(NSTimeInterval)getEditSecondsAgo
{
    return [[NSDate date] timeIntervalSince1970] - self.lastTimeEdit;
}

#pragma mark - Private mthods
-(void)setupTextField
{
    self.notificationInterval = 0.5;
    self.lastTimeEdit = [[NSDate date] timeIntervalSince1970];
    [self addTarget:self action:@selector(textFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldEditingChanged
{
    self.lastTimeEdit = [[NSDate date] timeIntervalSince1970];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(triggerNotification) object:nil];
    
    if (self.notificationInterval < 0.5)
        self.notificationInterval = 0.5;
    
    [self performSelector:@selector(triggerNotification) withObject:nil afterDelay:self.notificationInterval];
}

-(void)triggerNotification
{
    if (self.afterTimeDelegate)
        [self.afterTimeDelegate afterTimeTextField:self didEndEditing:self.notificationInterval];
}

@end
