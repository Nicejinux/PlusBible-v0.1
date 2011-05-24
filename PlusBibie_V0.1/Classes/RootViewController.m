//
//  RootViewController.m
//  DrillDownApp
//
//  Created by iPhone SDK Articles on 3/8/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import "RootViewController.h"
#import "DrillDownAppAppDelegate.h"
#import "DetailViewController.h"
#import "WebViewController.h"
#import "ImageViewController.h"

@implementation RootViewController

@synthesize tableDataSource, CurrentTitle, CurrentLevel;


- (void)viewDidLoad {
    [super viewDidLoad];

    if(CurrentLevel == 0) {
		
		//Initialize our table data source
		NSArray *tempArray = [[NSArray alloc] init];
		self.tableDataSource = tempArray;
		[tempArray release];
		
		DrillDownAppAppDelegate *AppDelegate = (DrillDownAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		self.tableDataSource = [AppDelegate.data objectForKey:@"Rows"];
		
		self.navigationItem.title = @"전체보기";
	}
	else 
		self.navigationItem.title = CurrentTitle;	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableDataSource count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	NSDictionary *dictionary = [self.tableDataSource objectAtIndex:indexPath.row];
	cell.textLabel.text = [dictionary objectForKey:@"Title"];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	//Get the dictionary of the selected data source.
	NSDictionary *dictionary = [self.tableDataSource objectAtIndex:indexPath.row];
	
	//Get the children of the present item.
	NSArray *Children = [dictionary objectForKey:@"Children"];
	
	NSString *newTitle;
	NSString *keyTitle;
	
	if([Children count] == 0) {
		NSInteger ViewNumber = [[dictionary objectForKey:@"View"] integerValue];
		newTitle = [[NSString alloc] initWithFormat:@"%@ %d장", CurrentTitle, ViewNumber];
		keyTitle = [[NSString alloc] initWithFormat:@"%@ %d", CurrentTitle, ViewNumber];
		
		switch (ViewNumber) {
				/*
			case 1: {
				RootViewController *rvc = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
				//Switch the view here
				rvc.view = tbController.view;
				[self.navigationController pushViewController:rvc animated:YES];
				[rvc release];
				}
				break;
			case 2: {
				ImageViewController *ivc = [[ImageViewController alloc] initWithNibName:@"ImageView" bundle:[NSBundle mainBundle]];
				ivc.ImageName = @"Image.jpg";
				[self.navigationController pushViewController:ivc animated:YES];
				[ivc release];
				}
				break;
			case 3: {
				DetailViewController *dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
				dvController.TitleName = newTitle;
				[self.navigationController pushViewController:dvController animated:YES];
				[dvController release];
				}
				break;
			case 4: {
				WebViewController *wvController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:[NSBundle mainBundle]];
				wvController.TitleName = newTitle;
				wvController.KeyTitle = keyTitle;
				[self.navigationController pushViewController:wvController animated:YES];
				[wvController release];
			    }
				break;
				 */
			default: {
				WebViewController *wvController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:[NSBundle mainBundle]];
				wvController.TitleName = newTitle;
				wvController.KeyTitle = keyTitle;
				[self.navigationController pushViewController:wvController animated:YES];
				[wvController release];
			}
				break;
		}
	}
	else {
		
		//Prepare to tableview.
		RootViewController *rvController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
		
		//Increment the Current View
		rvController.CurrentLevel += 1;
		
		//Set the title;
		rvController.CurrentTitle = [dictionary objectForKey:@"Title"];
		
		//Push the new table view on the stack
		[self.navigationController pushViewController:rvController animated:YES];
		
		rvController.tableDataSource = Children;
		
		[rvController release];
	}
}

- (void)dealloc {
	[tbController release];
	[CurrentTitle release];
	[tableDataSource release];
    [super dealloc];
}

@end

