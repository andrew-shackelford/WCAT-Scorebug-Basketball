//
//  AppDelegate.h
//  Football Scorebug
//
//  Created by Andrew Shackelford on 5/9/15.
//  Copyright (c) 2015 Andrew Shackelford. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSWindow *controlWindow;

- (IBAction)awayPlusSix:(id)sender;
- (IBAction)awayPlusThree:(id)sender;
- (IBAction)awayPlusOne:(id)sender;
- (IBAction)awayMinusOne:(id)sender;

- (IBAction)homePlusSix:(id)sender;
- (IBAction)homePlusThree:(id)sender;
- (IBAction)homePlusOne:(id)sender;
- (IBAction)homeMinusOne:(id)sender;

- (IBAction)minusOneSecond:(id)sender;
- (IBAction)minusTenSeconds:(id)sender;
- (IBAction)minusOneMinute:(id)sender;

- (IBAction)plusOneSecond:(id)sender;
- (IBAction)plusTenSeconds:(id)sender;
- (IBAction)plusOneMinute:(id)sender;

- (IBAction)minusQuarter:(id)sender;
- (IBAction)plusQuarter:(id)sender;

- (IBAction)showTimeout:(id)sender;
- (IBAction)showFlag:(id)sender;
- (IBAction)showTouchdown:(id)sender;

- (IBAction)startClock:(id)sender;
- (IBAction)resetClock:(id)sender;

- (IBAction)showReplay:(id)sender;
- (IBAction)hideClock:(id)sender;
- (IBAction)hideScorebug:(id)sender;
- (IBAction)hideDown:(id)sender;

- (IBAction)plusDown:(id)sender;
- (IBAction)minusDown:(id)sender;
- (IBAction)plusDistance:(id)sender;
- (IBAction)minusDistance:(id)sender;

- (IBAction)resetDown:(id)sender;
- (IBAction)justDown:(id)sender;
- (IBAction)updateDown:(id)sender;
- (IBAction)andGoal:(id)sender;

@property (weak) IBOutlet NSButton *clockButton;
@property (weak) IBOutlet NSButton *scorebugButton;
@property (weak) IBOutlet NSButton *downButton;
@property (weak) IBOutlet NSButton *replayButton;

@property (weak) IBOutlet NSButton *timeoutButton;
@property (weak) IBOutlet NSButton *flagButton;
@property (weak) IBOutlet NSButton *touchdownButton;


@property (weak) IBOutlet NSTextField *awayScoreControl;
@property (weak) IBOutlet NSTextField *homeScoreControl;
@property (weak) IBOutlet NSTextField *clockControl;
@property (weak) IBOutlet NSTextField *quarterControl;
@property (weak) IBOutlet NSTextField *downAndDistanceControl;
@property (weak) IBOutlet NSTextField *downControl;
@property (weak) IBOutlet NSTextField *distanceControl;

@property (weak) IBOutlet NSTextField *timeoutControl;
@property (weak) IBOutlet NSTextField *touchdownControl;
@property (weak) IBOutlet NSTextField *flagControl;
@property (weak) IBOutlet NSTextField *replayControl;
@property (weak) IBOutlet NSTextField *clockShowingControl;
@property (weak) IBOutlet NSTextField *downShowingControl;
@property (weak) IBOutlet NSTextField *scorebugShowingControl;

@property (weak) IBOutlet NSButton *showLocatorButton;
@property (weak) IBOutlet NSButton *showScoreboardButton;
@property (weak) IBOutlet NSTextField *scoreboardShowingControl;
@property (weak) IBOutlet NSTextField *locatorShowingControl;

- (IBAction)showLocator:(id)sender;
- (IBAction)showScoreboard:(id)sender;


@property (weak) IBOutlet NSWindow *displayWindow;

@property (weak) IBOutlet NSButtonCell *displayFullScreenButton;
- (IBAction)displayEnterFullScreen:(id)sender;

@property (weak) IBOutlet NSTextField *awayNameDisplay;
@property (weak) IBOutlet NSTextField *awayScoreDisplay;
@property (weak) IBOutlet NSTextField *homeNameDisplay;
@property (weak) IBOutlet NSTextField *homeScoreDisplay;
@property (weak) IBOutlet NSTextField *downDisplay;
@property (weak) IBOutlet NSTextField *quarterDisplay;
@property (weak) IBOutlet NSTextField *clockDisplay;

@property (weak) IBOutlet NSTextField *locatorAwayName;
@property (weak) IBOutlet NSTextField *locatorAwayScore;
@property (weak) IBOutlet NSTextField *locatorHomeName;
@property (weak) IBOutlet NSTextField *locatorHomeScore;
@property (weak) IBOutlet NSTextField *locatorQuarter;

@property (weak) IBOutlet NSImageView *scoreboardBackground;
@property (weak) IBOutlet NSImageView *scorebugBackground;

@property (weak) IBOutlet NSImageView *replayImage;

@property (weak) IBOutlet NSTextField *awaySeed;
@property (weak) IBOutlet NSTextField *homeSeed;

@property (weak) IBOutlet NSTextField *location;
@property (weak) IBOutlet NSTextField *date;


@property (weak) IBOutlet NSTextField *locatorHomeSeed;
@property (weak) IBOutlet NSTextField *locatorAwaySeed;

@property (weak) IBOutlet NSImageView *flagImage;


@property (weak) IBOutlet AVPlayerView *animationView;

@property (weak) IBOutlet NSColorWell *colorScorebug;

@property (weak) IBOutlet AVPlayerView *animationTwoView;


@property (weak) IBOutlet NSTextField *optText;

@property (weak) IBOutlet NSImageView *optTextBackground;


@end

