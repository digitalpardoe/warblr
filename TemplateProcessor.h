//
//  TemplateProcessor.h
//  Warblr
//
//  Created by Alex on 15/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AutoHyperlinks/AutoHyperlinks.h>
#import "RKLMatchEnumerator.h"
#import "RegexKitLite.h"


@interface TemplateProcessor : NSObject {
	NSString *templatePath;
	NSDictionary *templateContent;
	bool URLProcess;
}

- (TemplateProcessor *)initWithTemplatePath:(NSString *)templatePath content:(NSDictionary *)templateContent processURLs:(BOOL)process;

- (NSString *)result;

@end
