
# Flicker App

This application lets you search photos in Flicker, and displays them in a 3-column view


## Screenshots

![App Screenshot](https://i.ibb.co/6yCb153/screenshot.jpg|width=100))


## Architecture

The architecture used in the app is MVVM-C

![App Screenshot](https://i.ibb.co/L08y6XP/architecture.jpg|width=100)

- **Coordinator** - (PhotosSearchRouter) - this will control the flow of navigation in the app. This is where we instantiate the View Controller
- **DI / Dependency Injection / Assembler** - This is where assemble the contract + their instance.
   * Library Used: Swinject & SwinjectAutoRegistration
- **Model** - This represents the Photo data that we fetch from Flickr
- **ViewModel** - This holds the business logic in the app, in this case calling api to get data from interactor and pass it back to view controller.
- **Interactor** - This servers as the bridge from view model to datasource - can be from a repository or an api service
- **ViewController** - This is the layer that the user interacts with - when user types in the textfield + display the result


## What can be improved?
- Due to time constraints I have not added support for pagination + unit tests
- For Unit Tests - Cuckoo https://github.com/Brightify/Cuckoo is a good mocking library that I use to perform mocks and stubs
- Comments all throughout the app should be descriptive of what each functions does
- API service, Constants, etc can be further de-coupled for cleaner structure
