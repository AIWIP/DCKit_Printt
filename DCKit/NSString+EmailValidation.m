//
//  NSString+EmailValidation.m
//
//  Created by Marko Strizic on 3/1/13.
//  Copyright (c) 2013 Marko Strizic. All rights reserved.
//

#import "NSString+EmailValidation.h"

@implementation NSString (EmailValidation)


-(BOOL) dc_isValidEmail
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
