//
//  ViewController.h
//  AnimacionNave
//
//  Created by rml on 01/12/13.
//  Copyright (c) 2013 rml. All rights reserved.
//

//Añdimos para el sonido el delegate AVAudioPlayerDelegate
//Precisamos importar el framework AudioToolbox

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate> {
    SystemSoundID mySound;
}

// Creación capas

@property(nonatomic, strong) CALayer * orbita;    // órbita tierra
@property(nonatomic, strong) CALayer * tierra;    // tierra
@property(nonatomic, strong) CALayer * luna;      // luna
//@property(nonatomic, strong) CALayer * nave;      // nave

@property (nonatomic, weak) IBOutlet UIView *naveView;



// Acciones

- (IBAction)animar:(id)sender;


@end