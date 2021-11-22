# Dish of The Day (tired of making decisions?)

It's Mobile Application that in the basic version will contain the functionality of 
managing recipes. In the future, I intend to extend application for the possibility of drawing 
recipes and assigning them to a schedule to help undecided consumers choose what to eat :)

## How do I run the application?
Requirements: Flutter installed on the device, Android Studio or any other preffered compilator 
which is able to run Flutter Project
1) Set up Json Server:  
   -install nodejs latest stable version from https://nodejs.org/en/,  
   -open terminal and install json server with command: npm install json-server -g (-g means global installation for json server),  
   -download the project,  
   -open terminal in project folder dotd and run command: json-server --watch db.json.

2) Run the project on the emulator:  
   -open project in Android Studio,  
   -turn on device emulator from AVD Manager,  
   -run application by pushing button(green arrow) Run 'main.dart'  
## Up to date  
Very basic version is ready to use. Now you can add recipes, update them, delete and read!  
  
### My Plan (TODO)

1. Add a photo of meals to recipe,  
2. Add ingridients list (nested data),  
3. Add empty recipeList view.  
