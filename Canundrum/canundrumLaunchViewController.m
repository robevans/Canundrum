//
//  canundrumLaunchViewController.m
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "canundrumLaunchViewController.h"
#import "decisionsDataController.h"
#import "decisionsMasterViewController.h"

@interface canundrumLaunchViewController ()

@end

@implementation canundrumLaunchViewController

@synthesize dataController=_dataController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataController = [[decisionsDataController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"launchToMaster"]) {
        UINavigationController *nc = [segue destinationViewController];
        decisionsMasterViewController *mc = [[nc viewControllers] objectAtIndex:0];
        mc.dataController = self.dataController;
    }
}

@end
