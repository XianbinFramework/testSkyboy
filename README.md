# testSkyboy

## Quick start
The test has been tested on :
- iPhone7
- iOS 10.3.1 (deployment for iOS ~> 9.0).
- swift 3.1

Please open the project with **testSkyboy.xcworkspace**

When run the project, if you have compilation error about Apple Certificate, please :

> Go to [project_name] -> General -> Signing
> change the Signing Certificate to yours

and redo cocoaPods install in the project root in Terminal.

> cd projet_root

> pod install


-----------------------------------------

## Choice between MVC and MVVM

##### Architecture
When I started the project, I think MVC is enough for a small application, but in the middle of development, I want to change MVVM because the TableView could present 2 types of elements : **channel** and **spot**. Then the final architecture is a kind of something between MVC and MVVM.

##### Custom Views
In order to avoid a big ViewController file, I always prefer to do my custom views and let each view to handle the delegate methods in its single file.

##### VIPer
The VIper architecture is too heavy for small project.

##### ReactSwfit (RxSwift)
It's possible.

##### ViewController Coordinator

Only one viewController in this application, no need coordinator for viewController.

----------------------------------------

## Choice between SwiftyJSON and JSONSerialization
SwiftyJSON is better than JSONSerialization, so I choose SwiftyJSON.

---------------------------------------

## Choice between MapKit and Google Map SDK

I choose MapKit because the application only show elements on the map, there isn't navigation or pathfinding. So use MapKit can reduce the final binary file size.

But I think the choice of MapKit is a mistake. MapKit take time more than Google Map SDK for development and I got a big **warning** in Xcode 8.3 and swift 3.1. Lots of people talk about the problem with MapKit in swift 3.1 in [Apple Forum](https://forums.developer.apple.com/thread/72286) .

-------------------------------------------

## Difficult part : where I have spent my time

The first part is how to organizer the data source for tableView.

step 1:

I create 2 arrays,
- a channel array for channel list
- a spot array for spot list
Then I recognize that I can use one array to store both channel and spot element with Protocol. Then I switch to step 2.

step 2:

I tried to create a protocol listElementProtocol then both channel and spot expend listElementProtocol, but there is only one common property 'id' in channel and spot. I think it's not necessary to have this protocol. Then I pass to step 3.

step 3 :
I create a ElementModelView struct which has 2 init function for channel and spot separated.

--------------------------

The second part is the MapKit problem

I have tried MapKit before, but I am familiar with Google Map SDK, and I spent lots of time to search  the big **warning** issue.

----------------------------------------


## Estimation

The application works, I think 80% is achieved.

The rest thing TODO :

##### Json data analyze

- rest time : 1h

For this version, all json data accepted, example :

- if there isn't a "id" key in the json data, I put a empty string "".
- if there isn't a number for a key , I set the value to 0

But I think it's betther to choose which key can't be empty.

For example the "video_url" key is empty, it's better to reject this json data and do not show it to users. because it's not good to show something doesn't exist to screen.

##### Tap on an annotation

- rest time : < 30 mins depends on action

Add an action to annotation when users tap on them.

##### Graph design

- rest time : 1h - 3h
