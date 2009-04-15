//
//  TimelineController.m
//  Warblr
//
//  Created by Alex on 13/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "TimelineController.h"


@implementation TimelineController

- (void)awakeFromNib
{
	[[[TimelineWindowController sharedController] window] center];
	
	[webView setDrawsBackground:NO];
	[webView setUIDelegate:self];
	[webView setFrameLoadDelegate:self];
	[[webView windowScriptObject] setValue:self forKey:@"TimelineController"]; // can be any unique name you want
    
	NSBundle *themeBundle = [NSBundle bundleWithPath:[[NSBundle pathsForResourcesOfType:@"warblrTheme" inDirectory:[NSString stringWithFormat:@"%@/../Themes", [[NSBundle mainBundle] resourcePath]]] objectAtIndex:0]];
	NSString *htmlPath = [[themeBundle resourcePath] stringByAppendingPathComponent:@"index.html"];
	[[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
	
    //	Notes: 
	//	1. In JavaScript, you can now talk to this object using "window.AppController".
	//
	//	2. You must explicitly allow methods to be called from JavaScript;
	//	See the +isSelectorExcludedFromWebScript: method below for an example.
    //	 
	//	3. The method on this class which we call from JavaScript is -showMessage:
	//	To call it from JavaScript, we use window.AppController.showMessage_()  <-- NOTE colon becomes underscore!
	//	For more on method-name translation, see:
	//	http://developer.apple.com/documentation/AppleApplications/Conceptual/SafariJSProgTopics/Tasks/ObjCFromJavaScript.html#
    
//    // Load the HTML content.
//    NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
//    NSString *htmlPath = [resourcesPath stringByAppendingString:@"/index.html"];
//    [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
//    
//    // Set up the themes chooser.
//    [themeChooser removeAllItems];
//    NSArray *themes = [[NSBundle mainBundle] pathsForResourcesOfType:@"css" inDirectory:nil];
//    for (NSString *theme in themes) {
//        // Get theme name without file-extension
//        NSString *themeName = [theme lastPathComponent];
//        NSRange dotRange = [themeName rangeOfString:@"."];
//        if (dotRange.location != NSNotFound) {
//            themeName = [themeName substringToIndex:dotRange.location];
//        }
//        
//        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:themeName 
//                                                          action:@selector(changeTheme:) 
//                                                   keyEquivalent:@""];
//        [menuItem setTarget:self];
//        [menuItem setRepresentedObject:[theme lastPathComponent]];
//        if ([themeName isEqualToString:@"Default"]) {
//            [menuItem setState:NSOnState];
//        }
//        [[themeChooser menu] addItem:menuItem];
//        [menuItem release];
//    }
}


+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector
{    
//	if (aSelector == @selector(showMessage:)) {
//		return NO;
//	}

	return YES;
}

@end
