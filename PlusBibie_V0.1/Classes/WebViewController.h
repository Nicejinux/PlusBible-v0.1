//
//  WebViewController.h
//  DrillDownApp
//
//  Created by Nicejinux on 11. 5. 23..
//  Copyright 2011 NICE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController <UIWebViewDelegate> {

	IBOutlet UIWebView *webView;
	NSString *TitleName;
	NSString *KeyTitle;
	
	NSString *contStr;
	NSString *prevStr;
	NSString *nextStr;
}

@property (nonatomic, retain) NSString *TitleName;
@property (nonatomic, retain) NSString *KeyTitle;
@property (nonatomic, retain) UIWebView *webView;

@end
