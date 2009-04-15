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
	return @"";
}

@end
