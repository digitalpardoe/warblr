//
//  TemplateProcessor.h
//  Warblr
//
//  Created by Alex on 15/04/2009.
//  Copyright 2009 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TemplateProcessor : NSObject {
	NSString *templatePath;
	NSDictionary *templateContent;
}

- (TemplateProcessor *)initWithTemplatePath:(NSString *)templatePath content:(NSDictionary *)templateContent;

- (NSString *)result;

@end
