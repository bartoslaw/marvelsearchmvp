# marvelsearchmvp
Marvel Search MVP

#### Instructions for running the project:
1. Clone this repository
2. This project uses CocoaPods so you need to run **pod install** before you start working on it, if you don't have pods installed here is the instruction [Using CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)
3. From now on please remember to use **MarvelApp.xcworkspace** instaed of **MarvelApp.xcodeproj** (IMPORTANT!)
4. In order to run the app just press cmd+r, in order to run tests cmd+u (they will require running simulator/phone)

#### Architecture and project description:
This small project is written in the MVP pattern

![image example](https://upload.wikimedia.org/wikipedia/commons/d/dc/Model_View_Presenter_GUI_Design_Pattern.png)

I decided to go with this particular pattern because it makes view somewhat "dumb" which is what we should always go for, also I didn't want to over engineer something rather simple (not a big fan of doing that).

I also didn't want to pollute the app with too much Rx (and enlarge possibility of memory leaks) with some other subscriber observer pattern (like MVVM).

VIPER crossed my mind, but sheer amount of boilerplate needed to be written put me off.

As for the pattern used, all "concrete" classes, like views and presenters are derived from generic protocol, which makes it extremely easy
to switch them around. 

Also because of that presenters and views don't care in which ViewController they are used which makes them extremely reusable.

To make sure there is no tight coupling in the app I used dependency injection pattern, which is carried out by [Swinject](https://github.com/Swinject/Swinject)
with Swinject Storyboard extension which again, makes changing implementations of given class members very easy.

API communication is done by **ApiService** which is again injected into the presenter. 
API requests are wrapped with **Single** traits so if needed it will be easier to chain them as kind of synchronous methods, which would be cumbersome with regular callbacks.

All API requests are done by [Alamofire](https://github.com/Alamofire/Alamofire) networking library, which is a pretty expendable tool if needed (but also a simple one if not).
All models are parsed by [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)

This project doesn't include any kind of cache (except for images, which is done by [SDWebImage](https://github.com/SDWebImage/SDWebImage) library) because I didn't think this project justified it.

Although if I were to add cache, I'd rename **ApiService** to some kind of **DataRepository** and I'd have two implementations, one for the API calls and one for database access.
Switching them would be very simple, as they follow the same protocol.

As for the tests, just to keep things simple I used native XCTest framework. 
There are currently 11 Unit tests (focused on presenter and service) and 0 UI tests.

Approach to tests was to mock UI and networking paths and check whether functions to what is expected of them and checking states.

That's about it - some additional usability things were to debounce search text field, so it doesn't ask presenter with every written letter.


Also empty states and error states are handled in the app.


There's pagination both for general results and search results.
