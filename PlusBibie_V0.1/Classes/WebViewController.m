//
//  WebViewController.m
//  DrillDownApp
//
//  Created by Nicejinux on 11. 5. 23..
//  Copyright 2011 NICE. All rights reserved.
//

#import "WebViewController.h"
#import <sqlite3.h>


@implementation WebViewController

@synthesize webView;
@synthesize TitleName;
@synthesize KeyTitle;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)viewDidLoad {
	[super viewDidLoad];
	NSString *tmp = @"";
	
	if (TitleName == tmp) {
		self.navigationItem.title = @"Detail View";
	}
	else
		self.navigationItem.title = TitleName;

/*
	NSString *urlAddress = @"http://www.google.com";
	
	//Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	
	[webView loadRequest:requestObj];
*/
	sqlite3 *database;
	
	NSString *filePath = [NSString stringWithFormat: @"%@/korvb.sqlite3", [[NSBundle mainBundle] resourcePath]];
	sqlite3_stmt *statement;
	
	if (sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
		NSString *query = @"SELECT content, previous_reference_human, next_reference_human FROM chapters ";
		query = [query stringByAppendingFormat:@"where reference_human = '%@'", KeyTitle];
		NSLog(@"%@\n", query);
		if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) != SQLITE_OK) {
			NSLog(@"DB Open error: %s\n", sqlite3_errmsg(database));
		} else {
			while (sqlite3_step(statement) == SQLITE_ROW) {
				contStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				prevStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
				nextStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
			}
		}
		
		[webView loadHTMLString:contStr baseURL:nil];

		sqlite3_close(database);
		
		database = NULL;
	} else {
		NSLog(@"DB Connection error: %s\n", sqlite3_errmsg(statement));
	}
}


- (void)dealloc {
	//[contStr release];
	//[prevStr release];
	//[nextStr release];
    [super dealloc];
}


@end
