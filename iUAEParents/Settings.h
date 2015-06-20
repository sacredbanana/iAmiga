//
//  Settings.h
//  iUAE
//
//  Created by Urs on 08.03.15.
//
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

/**
 * Properties for common settings.
 */
@property (nonatomic, readwrite, assign) BOOL autoloadConfig;
@property (nonatomic, readwrite, assign) NSArray *insertedFloppies;
@property (nonatomic, readwrite, assign) BOOL ntsc;
@property (nonatomic, readwrite, assign) BOOL stretchScreen;
@property (nonatomic, readwrite, assign) BOOL showStatus;
@property (nonatomic, readwrite, assign) NSString *configurationName;
@property (nonatomic, readwrite, assign) NSArray *configurations;

/**
 * Returns YES if this is the very first time that the settings are initialized (the firs time the app runs).
 */
- (BOOL)initializeSettings;

- (void)setBool:(BOOL)value forKey:(NSString *)settingitemname;
- (void)setObject:(id)value forKey:(NSString *)settingitemname;
- (bool)boolForKey:(NSString *)settingitemname;
- (NSString *)stringForKey:(NSString *)settingitemname;
- (NSArray *)arrayForKey:(NSString *)settingitemname;
- (void)removeObjectForKey:(NSString *) settingitemname;
- (NSString *)configForDisk:(NSString *)diskName;
- (void) setConfig:(NSString *)configName forDisk:(NSString *)diskName;

@end