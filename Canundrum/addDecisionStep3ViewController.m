//
//  decisionsStep3ViewController.m
//  Canundrum
//
//  Created by Robert Evans on 17/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "addDecisionStep3ViewController.h"
#import "decisionsMasterViewController.h"
#import "decisionsDataController.h"

@interface addDecisionStep3ViewController ()

@end

@implementation addDecisionStep3ViewController

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
	// Do any additional setup after loading the view.
    //self.navigationItem.title = [NSString stringWithFormat:@"%d", [self.dataController countOfList]];
    [self loadData];
}

-(void)storeSliderValuesInDecisionModel
{
    NSMutableArray *aList = [[NSMutableArray alloc] init];
    if (self.slider1.hidden == NO) [aList addObject:[[NSNumber alloc] initWithFloat:self.slider1.value]];
    if (self.slider2.hidden == NO) [aList addObject:[[NSNumber alloc] initWithFloat:self.slider2.value]];
    if (self.slider3.hidden == NO) [aList addObject:[[NSNumber alloc] initWithFloat:self.slider3.value]];
    if (self.slider4.hidden == NO) [aList addObject:[[NSNumber alloc] initWithFloat:self.slider4.value]];
    if (self.slider5.hidden == NO) [aList addObject:[[NSNumber alloc] initWithFloat:self.slider5.value]];
    if (self.slider6.hidden == NO) [aList addObject:[[NSNumber alloc] initWithFloat:self.slider6.value]];
    [self.workingDecision setWeightingsList:aList];
}

-(void)loadData
{
    if (self.workingDecision.attributesList.count > 0) {
        self.label1.text = [self.workingDecision.attributesList objectAtIndex:0];
        if (self.workingDecision.weightingsList.count > 0)
            if ([self.workingDecision.weightingsList objectAtIndex:0])
                self.slider1.value = [[self.workingDecision.weightingsList objectAtIndex:0] floatValue];
    } else {
        self.label1.hidden = YES;
        self.slider1.hidden = YES;
    }
    if (self.workingDecision.attributesList.count > 1) {
        self.label2.text = [self.workingDecision.attributesList objectAtIndex:1];
        if (self.workingDecision.weightingsList.count > 1)
            if ([self.workingDecision.weightingsList objectAtIndex:1])
                self.slider2.value = [[self.workingDecision.weightingsList objectAtIndex:1] floatValue];
    } else {
        self.label2.hidden = YES;
        self.slider2.hidden = YES;
    }
    if (self.workingDecision.attributesList.count > 2) {
        self.label3.text = [self.workingDecision.attributesList objectAtIndex:2];
        if (self.workingDecision.weightingsList.count > 2)
            if ([self.workingDecision.weightingsList objectAtIndex:2])
                self.slider3.value = [[self.workingDecision.weightingsList objectAtIndex:2] floatValue];
    } else {
        self.label3.hidden = YES;
        self.slider3.hidden = YES;
    }
    if (self.workingDecision.attributesList.count > 3) {
        self.label4.text = [self.workingDecision.attributesList objectAtIndex:3];
        if (self.workingDecision.weightingsList.count > 3)
            if ([self.workingDecision.weightingsList objectAtIndex:3])
                self.slider4.value = [[self.workingDecision.weightingsList objectAtIndex:3] floatValue];
    } else {
        self.label4.hidden = YES;
        self.slider4.hidden = YES;
    }
    if (self.workingDecision.attributesList.count > 4) {
        self.label5.text = [self.workingDecision.attributesList objectAtIndex:4];
        if (self.workingDecision.weightingsList.count > 4)
            if ([self.workingDecision.weightingsList objectAtIndex:4])
                self.slider5.value = [[self.workingDecision.weightingsList objectAtIndex:4] floatValue];
    } else {
        self.label5.hidden = YES;
        self.slider5.hidden = YES;
    }
    if (self.workingDecision.attributesList.count > 5) {
        self.label6.text = [self.workingDecision.attributesList objectAtIndex:5];
        if (self.workingDecision.weightingsList.count > 5)
            if ([self.workingDecision.weightingsList objectAtIndex:5])
                self.slider6.value = [[self.workingDecision.weightingsList objectAtIndex:5] floatValue];
    } else {
        self.label6.hidden = YES;
        self.slider6.hidden = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"step3toDecisions"]) {
        [self storeSliderValuesInDecisionModel];
        [self.dataController addDecision:self.workingDecision];
        decisionsMasterViewController *mc = [segue destinationViewController];
        mc.dataController = self.dataController;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self storeSliderValuesInDecisionModel];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
