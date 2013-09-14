//
//  decisionsStep2ViewController.m
//  Canundrum
//
//  Created by Robert Evans on 17/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "addDecisionStep2ViewController.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface addDecisionStep2ViewController ()

@end

@implementation addDecisionStep2ViewController

CGFloat animatedDistance;
@synthesize textField1;
@synthesize textField2;
@synthesize textField3;
@synthesize textField4;
@synthesize textField5;
@synthesize textField6;
NSMutableArray *textFields;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        textFields = [[NSMutableArray alloc] init];
        for (UIView *view in [self.view subviews]) {
            if ([view isKindOfClass:[UITextField class]]) {
                [textFields addObject:view];
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    self.scrollView.delegate = self;
    
    // Register observers of keyboard events
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self displayAttributesInTextFields];
    [self setNextBarButtonEnabledOrDisabled];
}

-(NSInteger)numberOfFilledTextFields {
    NSInteger count = 0;
    if (self.textField1.text.length>0) count++;
    if (self.textField2.text.length>0) count++;
    if (self.textField3.text.length>0) count++;
    if (self.textField4.text.length>0) count++;
    if (self.textField5.text.length>0) count++;
    if (self.textField6.text.length>0) count++;
    return count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    animatedDistance = 0;
}

- (IBAction)textField1EditingChanged:(id)sender {
    [self setNextBarButtonEnabledOrDisabled];
}
- (IBAction)textField2EditingChanged:(id)sender {
    [self setNextBarButtonEnabledOrDisabled];
}
- (IBAction)textField3EditingChanged:(id)sender {
    [self setNextBarButtonEnabledOrDisabled];
}
- (IBAction)textField4EditingChanged:(id)sender {
    [self setNextBarButtonEnabledOrDisabled];
}
- (IBAction)textField5EditingChanged:(id)sender {
    [self setNextBarButtonEnabledOrDisabled];
}
- (IBAction)textField6EditingChanged:(id)sender {
    [self setNextBarButtonEnabledOrDisabled];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setNextBarButtonEnabledOrDisabled];
    
    if (self.textField1.isFirstResponder)
        [self.textField2 becomeFirstResponder];
    else if (self.textField2.isFirstResponder)
        [self.textField3 becomeFirstResponder];
    else if (self.textField3.isFirstResponder)
        [self.textField4 becomeFirstResponder];
    else if (self.textField4.isFirstResponder)
        [self.textField5 becomeFirstResponder];
    else if (self.textField5.isFirstResponder)
        [self.textField6 becomeFirstResponder];
    else if (self.textField6.isFirstResponder)
        [self.textField6 resignFirstResponder];
    
    return YES;
}

-(void)setNextBarButtonEnabledOrDisabled
{
    if ([self numberOfFilledTextFields]>1) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

-(void)displayAttributesInTextFields
{
    if (self.workingDecision.attributesList.count > 0) {
        self.textField1.text = [self.workingDecision.attributesList objectAtIndex:0];
    } else {
        self.textField1.text=@"";
    }
    if (self.workingDecision.attributesList.count > 1) {
        self.textField2.text = [self.workingDecision.attributesList objectAtIndex:1];
    } else {
        self.textField2.text=@"";
    }
    if (self.workingDecision.attributesList.count > 2) {
        self.textField3.text = [self.workingDecision.attributesList objectAtIndex:2];
    } else {
        self.textField3.text=@"";
    }
    if (self.workingDecision.attributesList.count > 3) {
        self.textField4.text = [self.workingDecision.attributesList objectAtIndex:3];
    } else {
        self.textField4.text=@"";
    }
    if (self.workingDecision.attributesList.count > 4) {
        self.textField5.text = [self.workingDecision.attributesList objectAtIndex:4];
    } else {
        self.textField5.text=@"";
    }
    if (self.workingDecision.attributesList.count > 5) {
        self.textField6.text = [self.workingDecision.attributesList objectAtIndex:5];
    } else {
        self.textField6.text=@"";
    }
    }

-(void)storeTextFieldsInDecisionModel
{
    NSMutableArray *aList = [[NSMutableArray alloc] init];
    if (self.textField1.text.length>0) [aList addObject:textField1.text];
    if (self.textField2.text.length>0) [aList addObject:textField2.text];
    if (self.textField3.text.length>0) [aList addObject:textField3.text];
    if (self.textField4.text.length>0) [aList addObject:textField4.text];
    if (self.textField5.text.length>0) [aList addObject:textField5.text];
    if (self.textField6.text.length>0) [aList addObject:textField6.text];
    [self.workingDecision setAttributesList:aList];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"step2to3"]) {
        [self.view endEditing:NO];
        [self storeTextFieldsInDecisionModel];
        [self displayAttributesInTextFields];
        [[segue destinationViewController] setWorkingDecision:self.workingDecision];
        [[segue destinationViewController] setDataController:self.dataController];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self storeTextFieldsInDecisionModel];
    [self displayAttributesInTextFields];
    [super viewWillDisappear:animated];
}

// Scroll view delegate methods
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.view endEditing:NO];
}

@end
