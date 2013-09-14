//
//  decisionsMasterViewController.m
//  Canundrum
//
//  Created by Robert Evans on 16/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "optionsTableViewController.h"
#import "canundrumLaunchViewController.h"
#import "decisionsMasterViewController.h"
#import "editOptionViewController.h"
#import "addDecisionStep1ViewController.h"
#import "addDecisionStep3ViewController.h"
#import "decisionsDataController.h"
#import "decision.h"
#import <QuartzCore/QuartzCore.h>
 
@implementation decisionsMasterViewController

@synthesize dataController=_dataController;

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (!self.dataController) {
        self.dataController = [[decisionsDataController alloc] init];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [[self navigationController] setToolbarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setToolbarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Add edit button on bottom bar
    self.editButtonItem.action = @selector(switchEditingMode);
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *toolbarItemsList = [NSArray arrayWithObjects:flexibleSpace,self.editButtonItem,flexibleSpace,nil];
    self.toolbarItems = toolbarItemsList;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DecisionCell"];
    decision *decisionAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
    cell.textLabel.text = decisionAtIndex.name;
    
    if (self.editing) {
        cell.detailTextLabel.text = @"Tap arrow to edit";
    } else {
        if (decisionAtIndex.sortedOptionsList.count > 0) {
            option *topOption = decisionAtIndex.sortedOptionsList[0];
            cell.detailTextLabel.text = topOption.name;
        } else {
            cell.detailTextLabel.text = @"Tap me to add options!";
        }
    }
    
    return cell;
}

- (void)switchEditingMode {
    [CATransaction begin];
    [CATransaction setCompletionBlock: ^{
        [self.tableView reloadData];
    }];
    if(self.editing)
    {
        [self setEditing:false animated:YES];
    }
    else
    {
        [self setEditing:true animated:YES];
    }
    [CATransaction commit];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataController.masterDecisionsList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
 // Reorder items in data model
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showOptions"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        decision *decisionAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
        NSLog(@"Selected decision: %@",decisionAtIndex.name);
        optionsTableViewController *optionsList = [segue destinationViewController];
        [optionsList setSelectedDecision:decisionAtIndex];
    }
    
    if ([[segue identifier] isEqualToString:@"editDecision"]) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle: @"Cancel"
                                       style: UIBarButtonItemStyleBordered
                                       target: nil action: nil];
        [self.navigationItem setBackBarButtonItem: backButton];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        decision *decisionAtIndex = [self.dataController objectInListAtIndex:indexPath.row];
        NSLog(@"Selected decision: %@",decisionAtIndex.name);
        editDecisionViewController *dvc = [segue destinationViewController];
        dvc.delegate = self;
        dvc.selectedDecision = decisionAtIndex;
    }

    if ([[segue identifier] isEqualToString:@"returnToLaunch"]) {
        canundrumLaunchViewController *lc = [segue destinationViewController];
        lc.dataController = self.dataController;
    }
    
    if ([[segue identifier] isEqualToString:@"masterToStep1"]) {
        addDecisionStep1ViewController *s1c = [segue destinationViewController];
        s1c.dataController = self.dataController;
    }
}

// Protocol methods for modal view handling
-(void)editDecisionViewController:(editDecisionViewController *)viewController didEditDecision:(decision *)decision {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)editDecisionViewControllerDidCancel:(editDecisionViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
