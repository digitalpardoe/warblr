//
//  TemplateProcessor.m
//  Warblr
//
//  Created by Alex on 15/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import "TemplateProcessor.h"


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
	NSEnumerator *enumerator = [fileContent matchEnumeratorWithRegex:@"\\(% \\w+ %\\)"];
	NSString *tag;
	while ( tag = [enumerator nextObject] ) {
		NSString *appendString = [templateContent valueForKey:[tag stringByMatching:@"\\w+"]];
		if (!appendString) {
			NSLog(@"Key not found, please check template.");
			fileContent = [fileContent stringByReplacingOccurrencesOfString:tag withString:@"KEY_NOT_FOUND"];
		} else {
			fileContent = [fileContent stringByReplacingOccurrencesOfString:tag withString:appendString];
		}
	}
	
	return fileContent;
}

@end
