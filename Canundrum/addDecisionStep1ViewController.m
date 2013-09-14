//
//  decisionsStep1ViewController.m
//  Canundrum
//
//  Created by Robert Evans on 17/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "addDecisionStep1ViewController.h"

@interface addDecisionStep1ViewController ()

@end

@implementation addDecisionStep1ViewController

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
    //self.navigationItem.title = [NSString stringWithFormat:@"%d", [self.dataController countOfList]];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    if (!self.workingDecision) {
        self.workingDecision = [[decision alloc] init];
    }
    if (!self.dataController) {
        self.dataController = [[decisionsDataController alloc] init];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.questionTextField setText:self.workingDecision.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self textFieldShouldReturn:self.questionTextField];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.questionTextField) {
        [self.questionTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)updateNextButtonStatus:(id)sender {
    if (self.questionTextField.text.length>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"step1to2"]) {
        self.workingDecision.name = [self.questionTextField text];
        [[segue destinationViewController] setWorkingDecision:self.workingDecision];
        [[segue destinationViewController] setDataController:self.dataController];
    }
}

@end
