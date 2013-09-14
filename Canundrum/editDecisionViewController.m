//
//  editDecisionViewController.m
//  Canundrum
//
//  Created by Robert Evans on 08/09/2013.
//  Copyright (c) 2013 Robert Evans. All rights reserved.
//

#import "editDecisionViewController.h"
#import "decision.h"

@interface editDecisionViewController ()
    @property (nonatomic, assign) UITextField *activeTextField;
@end

@implementation editDecisionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetScrollViewInsets];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    // Register observers of keyboard events
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // Order fields and sliders
    NSComparator compareTags = ^(id a, id b) {
        NSInteger aTag = [a tag];
        NSInteger bTag = [b tag];
        return aTag > bTag ? NSOrderedDescending
        : aTag < bTag ? NSOrderedAscending
        : NSOrderedSame;
    };
    self.attributeFields = [self.attributeFields sortedArrayUsingComparator:compareTags];
    self.attributeSliders = [self.attributeSliders sortedArrayUsingComparator:compareTags];
    
    [self displayDecisionData:self.selectedDecision];
}

- (IBAction)attributeEditingChanged:(UITextField *)sender {
    UISlider *slider = self.attributeSliders[[self.attributeFields indexOfObject:sender]];
    slider.enabled = sender.text.length > 0 ? true : false;
}


-(void)displayDecisionData:(decision *) decision {
    self.decisionNameField.text = decision.name;
    for (int i=0; i<decision.attributesList.count; i++) {
        UITextField *field = self.attributeFields[i];
        UISlider *slider = self.attributeSliders[i];
        field.text = decision.attributesList[i];
        slider.enabled = true;
        slider.value = [decision.weightingsList[i] floatValue];
    }
}

-(void)saveDecisionData {
    self.selectedDecision.name = self.decisionNameField.text;
    NSMutableArray *attributeList = [[NSMutableArray alloc] init];
    NSMutableArray *weightingsList = [[NSMutableArray alloc] init];
    for (int i=0; i<self.attributeFields.count; i++) {
        UITextField *field = self.attributeFields[i];
        UISlider *slider = self.attributeSliders[i];
        
        if (field.text.length>0) {
            [attributeList addObject:field.text];
            [weightingsList addObject:[[NSNumber alloc] initWithFloat:slider.value]];
        }
        
        self.selectedDecision.attributesList = attributeList;
        self.selectedDecision.weightingsList = weightingsList;
    }
}

// Text field delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return NO;
}

// Auto scrolling behaviour on keyboard show
- (void)keyboardWasShown:(NSNotification *)notification
{
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat navBarHeight = self.navBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    // Adjust the bottom content inset of scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight+35, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    // Scroll the target text field into view.
    CGRect scrollRect = self.scrollView.frame;
    scrollRect.origin.y = 0.0;  // Text fields frames are relative to this
    scrollRect.size.height = self.view.frame.size.height - navBarHeight - keyboardHeight - statusBarHeight;
    if (!CGRectContainsPoint(scrollRect, self.activeTextField.frame.origin)) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y + (80 - keyboardHeight));
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}
-(void) resetScrollViewInsets {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 35, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (void) keyboardWillHide:(NSNotification *)notification {
    [self resetScrollViewInsets];
}

// Nav bar actions
- (IBAction)cancel:(UIBarButtonItem *)sender {
    if ([self.delegate respondsToSelector:@selector(editDecisionViewControllerDidCancel:)]) {
        [self.delegate editDecisionViewControllerDidCancel:self];
    }
}
- (IBAction)done:(UIBarButtonItem *)sender {
    [self saveDecisionData];
    if ([self.delegate respondsToSelector:@selector(editDecisionViewController:didEditDecision:)]) {
        [self.delegate editDecisionViewController:self didEditDecision:self.selectedDecision];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
