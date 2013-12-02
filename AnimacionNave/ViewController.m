//
//  ViewController.m
//  AnimacionNave
//
//  Created by rml on 01/12/13.
//  Copyright (c) 2013 rml. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize orbita, tierra, luna;

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Creación capas  *******************************************
    
    orbita = [CALayer layer];
    orbita.bounds = CGRectMake(0, 0, 200, 200);       // límites de la capa
    orbita.position = self.view.center;               // centrado en la capa
    // orbita.backgroundColor = [UIColor whiteColor].CGColor;   *** No necesaria
    orbita.cornerRadius = 100;                        // forma de circulo a capa
    orbita.borderColor = [UIColor whiteColor].CGColor;
    orbita.borderWidth = 1.5;

    tierra = [CALayer layer];
    tierra.bounds = CGRectMake(0, 0, 40, 40);
    tierra.position = CGPointMake(100, 0);        // centrado en la capa "capa"
    tierra.cornerRadius = 20;
    tierra.backgroundColor = [UIColor blueColor].CGColor;
    tierra.borderColor = [UIColor blueColor].CGColor;
    tierra.borderWidth = 1.5;
    
    luna = [CALayer layer];           // creada capa sin declarado en .h
    luna.bounds = CGRectMake(0, 0, 10, 10);     // vemos que el objeto se visualiza
    luna.position = CGPointMake(5, -20);        // blanco
    luna.cornerRadius = 5;
    luna.backgroundColor = [UIColor grayColor].CGColor;
    luna.borderColor = [UIColor grayColor].CGColor;
    luna.borderWidth = 1.5;
    
    // Fin Creación capas  ****************************************
    
    // Visualización inicial capas
    [self.view.layer addSublayer:orbita];     // añadir orbita a vista principal
    [orbita addSublayer:tierra];             // añadir tierra a orbita
    [tierra addSublayer:luna];               // añadir luna a tierra
    
    
    // Sonido animación  *******************************************
    
    if (self) {
        //Obtenemos ruta completa del archivo de sonido
        NSString* soundPath = [[NSBundle mainBundle] pathForResource:@"sonido10" ofType:@"wav"];
        NSLog(@"la ruta fichero sonido es.... %@", soundPath);
        
        //Si el archivo de sonido está en nuestro paquete
        if (soundPath) {
            //Creamos el fichero URL con el path
            NSURL* soundURL = [NSURL fileURLWithPath:soundPath];
            
            //Registro de archivos de sonido ubicado en esa URL como un sonido del sistema
            OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &mySound);
            
            if (err != kAudioServicesNoError) {
                NSLog(@"No se ha podido cargar... %@, código error: %ld", soundURL, err);
            }
        }
    }
    return ;

    // FIN Sonido animación  ****************************************
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Animación

- (IBAction)animar:(id)sender {
    

// Capas animación
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    float angulo = 3*360*M_PI/180;
    rotationAnimation.toValue = [NSNumber numberWithFloat:angulo];
    rotationAnimation.duration = 10.0;
    [orbita addAnimation:rotationAnimation forKey:@"animacion"];
    [tierra addAnimation:rotationAnimation forKey:@"animacion"];
    

// Sonido animación
    AudioServicesPlaySystemSound(mySound);
    
 // Nave creación y animación  ***************************************
    
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(-100, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 400)
                  controlPoint1:CGPointMake(75, 0)
                  controlPoint2:CGPointMake(200, 200)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.naveView.layer addSublayer:pathLayer];
    
    
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(-25, 100);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship.png"].CGImage;
    [self.naveView.layer addSublayer:shipLayer];
    
    [self.view.layer addSublayer:shipLayer];             // añadir shipLayer a vista principal
    
    
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 9.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
 
    
// FIN Nave creación y animación  ***************************************
    
    
    
    

    
    
    
    
    
    
    
}
@end
