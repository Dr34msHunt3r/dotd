# DEMO  
# Dish of The Day (tired of making decisions?)  

It's Mobile Application that in the basic version will contain the functionality of  
managing recipes. In the future, I intend to extend application for the possibility of drawing  
recipes and assigning them to a schedule to help undecided consumers choose what to eat :)  

## How do I run the application?
Requirements: Flutter 2.8.0 installed, Android Studio or any other preferred compilator  
which is able to run Flutter Project  
1) Set up Json Server:  
   follow instructions https://github.com/Dr34msHunt3r/dotd_js_server  
  
2) Run the project on the emulator:  
   -open terminal in project root folder and run command  
   for rest API source  
   flutter run --flavor app1 -t lib/main_app1.dart  
   for Moor source  
   flutter run --flavor app2 -t lib/main_app2.dart  
   
## What there is?  
   Custom Icon App  
   Feel free to add new recipes, update them, delete them, read them. Now you can also add ingredients collection together with new recipe!  
   Ingredients collection which you added with Recipe is available now to read in details screen  
   Ingredients collection can be edited for each recipe  
   Add new text field for incoming ingredients in add and edit recipe screen  
   Delete unnecessary ingredient from the text fields list by pushing delete button  
   User is not forced to delete empty fields for ingredients while in add/edit mode, empty fields just won't be added to the ingredients collection  
   Ingredients fields are not required  
   Recipe title and body is required, if empty it will show toast with error message  
   Data model has been changed from two to one, now recipes contains list of ingredients  
   Json serialization  
   Dio instead of http  
  
## What's new?  
   Flavors app1 and app2  
   
