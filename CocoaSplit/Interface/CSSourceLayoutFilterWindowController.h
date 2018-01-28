//
//  CSSourceLayoutFilterWindowController.h
//  CocoaSplit
//
//  Created by Zakk on 1/28/18.

//

#import <Cocoa/Cocoa.h>
#import "SourceLayout.h"

@interface CSSourceLayoutFilterWindowController : NSWindowController <NSWindowDelegate>

@property (strong) SourceLayout *layout;
@property (weak) IBOutlet NSTableView *filterListTable;
@property (strong) NSWindow *userFilterWindow;

- (IBAction)filterControlAction:(NSSegmentedControl *)sender;


@end
