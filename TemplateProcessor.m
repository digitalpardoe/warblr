//
//  TemplateProcessor.m
//  Warblr
//
//  Created by Alex on 15/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "TemplateProcessor.h"

#define REGEX_TAG @"\\(% [\\p{Letter}\\.\\+]+ %\\)"
#define REGEX_TAG_CONTENTS @"[\\p{Letter}\\.]+"
#define REGEX_TAG_PROCESSOR @"\\+[\\p{Letter}\\.]+"

@interface TemplateProcessor (PrivateMethods)

- (NSString *)toLink:(NSString *)link;
- (NSString *)processMarkup:(NSString *)input;

@end

@implementation TemplateProcessor

- (TemplateProcessor *)initWithTemplatePath:(NSString *)path content:(NSDictionary *)content {
	if (self = [super init]) {
		templatePath = path;
		templateContent = content;
    }
	
    return self;
}

- (NSString *)result {
	NSString *fileContent = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
	NSString *processed = [self processMarkup:fileContent];
	
	return processed;
}

- (NSString *)toLink:(NSString *)link {
	return [NSString stringWithFormat:@"<a onClick=\"window.TimelineController.openURL_('%@');\">%@</a>", link, link];
}

- (NSString *)processMarkup:(NSString *)input {
	NSString *processed = input;
	
	NSEnumerator *enumerator = [processed matchEnumeratorWithRegex:REGEX_TAG];
	NSString *tag;
	while ( tag = [enumerator nextObject] ) {
		NSString *tagContent = [tag stringByMatching:REGEX_TAG_CONTENTS];
		NSString *appendString = [templateContent valueForKey:tagContent];
		
		if (!appendString) {
			NSLog(@"Key not found, please check template.");
			processed = [processed stringByReplacingOccurrencesOfString:tag withString:@"KEY_NOT_FOUND"];
		} else {
			processed = [processed stringByReplacingOccurrencesOfString:tag withString:appendString];
			
			if ([tag stringByMatching:REGEX_TAG_PROCESSOR] && [[[tag stringByMatching:REGEX_TAG_PROCESSOR] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"+"]] isEqualToString:@"linkify"]) {
				AHHyperlinkScanner *hyperlinkScanner = [AHHyperlinkScanner hyperlinkScannerWithString:processed];
				NSArray *urls = [hyperlinkScanner allURIs];
				
				NSEnumerator *enumerator = [urls objectEnumerator];
				id url;
				while ( url = [enumerator nextObject] ) {
					NSString *foundURL = [[url URL] absoluteString];
					processed = [processed stringByReplacingOccurrencesOfString:foundURL withString:[self toLink:foundURL]];
				}
			}
		}
	}
	
	return processed;
}

@end
