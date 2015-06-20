//  Created by Simon Toens on 19.06.15
//
//  iUAE is free software: you may copy, redistribute
//  and/or modify it under the terms of the GNU General Public License as
//  published by the Free Software Foundation, either version 2 of the
//  License, or (at your option) any later version.
//
//  This file is distributed in the hope that it will be useful, but
//  WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//  General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

#import "uae.h"
#import "sysconfig.h"
#import "sysdeps.h"
#import "options.h"

#import "DiskDriveService.h"

@implementation DiskDriveService

- (NSString *)getInsertedDiskForDrive:(int)driveNumber {
    NSAssert(driveNumber >= 0 && driveNumber <= NUM_DRIVES, @"Bad drive number");
    NSString *adfPath = [NSString stringWithCString:changed_df[driveNumber] encoding:[NSString defaultCStringEncoding]];
    return [adfPath length] == 0 ? nil : adfPath;
}

- (void)insertDisk:(NSString *)adfPath intoDrive:(int)driveNumber {
    NSAssert(driveNumber >= 0 && driveNumber <= NUM_DRIVES, @"Bad drive number");
    [adfPath getCString:changed_df[driveNumber] maxLength:256 encoding:[NSString defaultCStringEncoding]];
    real_changed_df[driveNumber] = 1;
}

- (void)insertDisks:(NSArray *)adfPaths {
    for (int driveNumber = 0; driveNumber < [adfPaths count]; driveNumber++)
    {
        if (driveNumber < NUM_DRIVES)
        {
            NSString *adfPath = [adfPaths objectAtIndex:driveNumber];
            if ([adfPath length] == 0) {
                continue; // placeholder item
            }
            if ([[NSFileManager defaultManager] fileExistsAtPath:adfPath isDirectory:NULL]) {
                // it is possible that the stored adf path is no longer valid - this often happens
                // during debugging.  If that's the case, don't even attempt to insert the floppy
                [self insertDisk:adfPath intoDrive:driveNumber];
            } else {
                NSLog(@"Adf does not exist: %@", adfPath);
            }
        }
        else
        {
            break;
        }
    }
}

@end