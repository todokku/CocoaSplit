//
//  CSInputLibraryItem.m
//  CocoaSplit
//
//  Created by Zakk on 10/18/15.
//  Copyright © 2015 Zakk. All rights reserved.
//

#import "CSInputLibraryItem.h"

@implementation CSInputLibraryItem


-(instancetype) initWithInput:(InputSource *)input
{
    if (self = [super init])
    {
        NSString *inputType = @"None";
        NSString *inputName = @"No Name";
        
        if (input.videoInput)
        {
            inputType = [input.videoInput.class label];
            NSImage *img = [input.videoInput libraryImage];
            if (img)
            {
                NSImage *thumb = [[NSImage alloc] initWithSize:NSMakeSize(32, 32)];
                NSRect fromRect = NSMakeRect(0, 0, img.size.width, img.size.height);
                [thumb lockFocus];
                [img drawInRect:NSMakeRect(0, 0, 32, 32) fromRect:fromRect operation:NSCompositeCopy fraction:1.0f];
                [thumb unlockFocus];
                self.inputImage = thumb;
            }
        }
        
        if (input.name)
        {
            inputName = input.name;
        }
        
        self.name = [NSString stringWithFormat:@"%@ %@", inputType, inputName];
        NSMutableData *saveData = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
        [archiver encodeObject:input forKey:@"root"];
        [archiver finishEncoding];
        self.inputData = saveData;
        if (!self.inputImage)
        {
            self.inputImage = [NSImage imageNamed:NSImageNameUser];
        }
    }
    
    return self;
}


-(instancetype) init
{
    if (self = [super init])
    {
        self.inputImage = [NSImage imageNamed:NSImageNameUser];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.inputImage forKey:@"inputImage"];
    [aCoder encodeObject:self.inputData forKey:@"inputData"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _inputData = [aDecoder decodeObjectForKey:@"inputData"];
        _inputImage = [aDecoder decodeObjectForKey:@"inputImage"];
    }
    
    return self;
}


-(id)initWithPasteboardPropertyList:(id)propertyList ofType:(NSString *)type
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:propertyList];
}

+(NSArray *)readableTypesForPasteboard:(NSPasteboard *)pasteboard
{
    return @[@"cocoasplit.library.item"];
}

- (NSArray *)writableTypesForPasteboard:(NSPasteboard *)pasteboard
{
    return @[@"cocoasplit.library.item"];
}

-(id)pasteboardPropertyListForType:(NSString *)type
{
    if (![type isEqualToString:@"cocoasplit.library.item"])
    {
        return nil;
    }
    
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}


@end