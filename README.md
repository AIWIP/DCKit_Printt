# DCKit #

### Summary ###

Our set of utilities and components developed by DECODE that makes development faster and easier.

It is a collection of methods and extensions that replace the longer implementations you would otherwise need to use, including UIColor hex converters, UIView frame manipulations, adding/removing of child View controllers, a great range of NSDate extensions and more.

DCKit also includes:

* __DCRevealVC__: A controller for a vertical sliding drawer menu.

* __VC Custom Transitioning__: A set of custom view controller transitions.

DCKit is fully unit tested.

### Version ###

The master branch is written for Swift 3.0, with branch for Swift 2.3. 


### How do I get set up? ###

The suggested way to integrate DCKit to your project is using Cocoapods. It is not a public Cocoapod (please note that there is a public cocoapod with the same name), so please link to it in Your Podfile using:

`pod 'DCKit', :git => 'https://bitbucket.org/decodehq/dckit.git', :branch => 'maste'` 

for Swift 2.2.

For Swift 2.3, please target the following branch:

`:branch => 'swift-2.3’`

Alternatively, You can just clone the repository and drag` DCKit.xcodepr`oj into your project and link against the `DCKit.framework` in target dependencies, or just drag&drop individual `.swift` files into Your project.

### License ###

This project is licensed under the terms of the MIT license.

### Who do I talk to? ###

If you have any questions, feel free to contact us at info@decode.agency.