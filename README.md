# VKAfterTimeTextField
## Description
Did you ever need to know when some of your `UITextField`s was edited last time? Or maybe you did need to now when user did end edit it? If yes then this control is made directly for you!
<br>
**VKAfterTimeTextField** is a sub-class of `UITextField` which allows you to know when user edited it last time during current use session. Also it allows to notify after specific time interval when user ends editing. This is gives you a some kind of 'setContinouos:false' feature like `UISlider` has.

## Installation
For now you can install **VKAfterTimeTextField** manually only. 
This control is available for both Objective-C and Swift projects.

1. Navigate to "Objective-C" or "Swift" directory and copy **VKAfterTimeTextField** class into your project.

2. Add `UITextField` in your storyboard and subclass it as `VKAfterTimeTextField` or Create it manually from code like a typical `UITextField`.

## Example project
Repo contains two example projects: Objective-C and Swfit.
Example projects are showing how you can use **VKAfterTimeTextField** with

## Usage
### Editing Did End notification
The main feature of this control is getting know when user ends editing. Feature mechanism is base on protocol named 'VKAfterTimeTextFieldDelegate'.
See how setup it and use in the code below:

### Swift
```swift
@IBOutlet weak var afterTimeTextField: VKAfterTimeTextField!
    
override func viewDidLoad()
{
	super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // Set VKAfterTimeTextFieldDelegate delegate    
	self.afterTimeTextField.afterTimeDelegate = self
        
    // Set time interval when notification should fire
	self.afterTimeTextField.notificationInterval = 1
}

// MARK: - VKAfterTimeTextFieldDelegate

func afterTimeTextFieldDidEndEditing(textField: VKAfterTimeTextField, afterTimeInterval timeInterval: NSTimeInterval)
{
	print("Text Field did end editing. Notification interval: \(timeInterval)")
}
```

### Objective-C
```Objective-C
@property (nonatomic, strong) id <UITextFieldDelegate> textFieldDelegate;
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Set VKAfterTimeTextFieldDelegate delegate    
	self.afterTimeTextField.afterTimeDelegate = self;
        
    // Set time interval when notification should fire
	self.afterTimeTextField.notificationInterval = 1;
}

#pragma mark - VKAfterTimeTextFieldDelegate

-(void)afterTimeTextField:(VKAfterTimeTextField *)textField didEndEditing:(NSTimeInterval)timeInterval
{
    NSLog(@"Text Field did end edit. Notification interval: %i", (int)timeInterval);
}
```

## Last time edit
There is two ways to check when **VKAfterTimeTextField** was last edited. You can get seconds and 'NSDate' date time object. 

### Swift
```swift
let seconds = self.afterTimeTextField.getEditSecondsAgo()
let date 	= self.afterTimeTextField.getEditDateTime()
```

### Objective-C
```Objective-C
NSTimeInterval seconds 	= [self.afterTimeTextField getEditSecondsAgo]
NSDate *date 			= [self.afterTimeTextField getEditDateTime];
```

## Author
Vladislav Kovalyov, http://woopss.com/

## License
**VKAfterTimeTextField** is available under the MIT License. See the LICENSE file for more info.