//
//  decisionOptionsTableViewController.m
//  Canundrum
//
//  Created by Robert Evans on 27/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "optionsTableViewController.h"
#import "decision.h"

@interface optionsTableViewController ()

@end

@implementation optionsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Reloading options table view data, %i options",self.selectedDecision.sortedOptionsList.count);
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = self.selectedDecision.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedDecision.sortedOptionsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"];
    
    [[cell textLabel] setText:[[self.selectedDecision.sortedOptionsList objectAtIndex:indexPath.row] name]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%.01lf%%",[self.selectedDecision percentageScoreOfoption:[self.selectedDecision.sortedOptionsList objectAtIndex:indexPath.row]]]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.selectedDecision.sortedOptionsList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
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
    if ([[segue identifier] isEqualToString:@"addOption"]) {
        NSLog(@"Adding option");
        editOptionViewController *optionEditor = [segue destinationViewController];
        optionEditor.option = [[[option class] alloc] init];
        optionEditor.isAdd = true;
        optionEditor.delegate = self;
        optionEditor.attributesList = self.selectedDecision.attributesList;
        optionEditor.navigationItem.title = self.selectedDecision.name;
    }
    if ([[segue identifier] isEqualToString:@"editOption"]) {
        NSLog(@"Editing option");
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        option *optionAtIndex = [[self.selectedDecision sortedOptionsList] objectAtIndex:indexPath.row];
        editOptionViewController *optionEditor = [segue destinationViewController];
        optionEditor.option = optionAtIndex;
        optionEditor.isAdd = false;
        optionEditor.delegate = self;
        optionEditor.attributesList = self.selectedDecision.attributesList;
        optionEditor.navigationItem.title = self.selectedDecision.name;
    }
}

// Implement the delegate methods for editOptionDelegate
-(void)optionDetailViewController:(editOptionViewController *)viewController didAddOption:(option *)option {
    // Add option to decision
    [self.selectedDecision.sortedOptionsList addObject:option];
    
    // Dismiss view controller
    NSLog(@"Dismissing modal view controller: %@",self.presentedViewController.description);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)optionDetailViewController:(editOptionViewController *)viewController didEditOption:(option *)option {
    // Do something with option...
    
    // Dismiss view controller
    NSLog(@"Dismissing modal view controller: %@",self.presentedViewController.description);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)optionDetailViewControllerDidCancel:(editOptionViewController *)viewController {
    // Dismiss view controller
    NSLog(@"Dismissing modal view controller: %@",self.presentedViewController.description);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
