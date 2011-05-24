//
//  DetailViewController.m
//  DrillDownApp
//
//  Created by iPhone SDK Articles on 3/8/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize TitleName;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *tmp = @"";
	if (TitleName == tmp) {
		self.navigationItem.title = @"Detail View";
	}
	else
		self.navigationItem.title = TitleName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[TitleName release];
    [super dealloc];
}


@end
