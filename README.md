# Dish of The Day (tired of making decisions?)  

It's Mobile Application that in the basic version will contain the functionality of managing recipes. In the future, I intend to extend application for the possibility of drawing recipes and assigning them to a schedule to help undecided consumers choose what to eat :)  

## How do I run the application?  
Requirements: Flutter installed on the device, Android Studio or any other preffered compilator which is able to run Flutter Project  
1) Set up Json Server:  
    -install nodejs latest stable version from https://nodejs.org/en/,  
    -open terminal and install json server with command: npm install json-server -g (-g means global installation for json server),  
    -download the project,  
    -open terminal in project folder dotd and run command: json-server --watch db.json.  

2) Run the project on the emulator:  
    -open project in Adnroid Studio,  
    -turn on device emulator from AVD Manager,  
    -run application by pushing button(green arrow) Run 'main.dart'  

### Structure Plan (TODO)  

1. Main screens:  
    a) Home screen with recipeList home.dart,  
    b) Details screen after tap on recipe from the list details.dart,  
    c) Edit recipe screen accessible from Details screen (contains delete option),  
    d) Add recipe screen accessible from home.dart from adding card,  
    e) Settings screen accessible from home.dart screen from AppBar.  
