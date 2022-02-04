# Dish of The Day (tired of making decisions?)  

It's Mobile Application that in the basic version will contain the functionality of  
managing recipes. In the future, I intend to extend application for the possibility of drawing  
recipes and assigning them to a schedule to help undecided consumers choose what to eat :)  

## How do I run the application?
Requirements: Flutter 2.8.0 installed, Android Studio or any other preferred compilator  
which is able to run Flutter Project  
1) Set up Json Server: (required only if you want to use rest api source)  
   follow instructions https://github.com/Dr34msHunt3r/dotd_js_server  
  
2) Run the project on the emulator:  
   -open terminal in project root folder and run command  
   for rest API source  
   flutter run --flavor app1 -t lib/main_app1.dart  
   for Moor source  
   flutter run --flavor app2 -t lib/main_app2.dart  
   for Secure storage source  
   flutter run --flavor app3 -t lib/main_app3.dart  
   
## What there is?  
   Custom Icon App  
   BLoC  
   Recipe CRUD  
   User is not forced to delete empty fields for ingredients while in add/edit mode, empty fields just won't be added to the ingredients collection  
   Ingredients fields are not required  
   Recipe title and body is required, if empty it will show toast with error message  
   Json serialization  
   Dio instead of http for rest  API  
   Flavors app1, app2 and app3 for different data sources  
   Sqlite for app2 (drift package)  
   Secure storage source for app3  
  
## What's new?  
   Image picker allows to choose recipes image source (gallery/camera)  
   Changed app navigation to auto router with auto_route package  
   Changed bottom nav bar to salomon nav bar with salomon_bottom_bar package  
   New flavor with firebase realtime database source  