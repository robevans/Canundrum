//
//  decisionsStep2ViewController.m
//  Canundrum
//
//  Created by Robert Evans on 17/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "addDecisionStep2ViewController.h"

@interface addDecisionStep2ViewController ()
    @property (nonatomic, assign) UITextField *activeTextField;
@end

@implementation addDecisionStep2ViewController

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
    self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}

- (IBAction)editingChanged:(UITextField *)sender {
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

// Auto scrolling behaviour on keyboard show
- (void)keyboardWasShown:(NSNotification *)notification
{
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    // Adjust the bottom content inset of scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight+35, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    // Scroll the target text field into view.
    CGRect scrollRect = self.scrollView.frame;
    scrollRect.origin.y = 0.0;  // Text fields frames are relative to this
    scrollRect.size.height = self.view.frame.size.height - keyboardHeight - statusBarHeight;
    if (!CGRectContainsPoint(scrollRect, self.activeTextField.frame.origin)) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y + (80 - keyboardHeight));
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

-(void) resetScrollViewInsets {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) keyboardWillHide:(NSNotification *)notification {
    [self resetScrollViewInsets];
}

@end
