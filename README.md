# DEMO  
# Dish of The Day (tired of making decisions?)  

It's Mobile Application that in the basic version will contain the functionality of  
managing recipes. In the future, I intend to extend application for the possibility of drawing  
recipes and assigning them to a schedule to help undecided consumers choose what to eat :)  

## How do I run the application?
Requirements: Flutter installed on the device, Android Studio or any other preffered compilator  
which is able to run Flutter Project  
1) Set up Json Server: (OUT OF DATE! project can run only with custom server)  
   -install nodejs latest stable version from https://nodejs.org/en/,  
   -open terminal and install json server with command: npm install json-server -g (-g means global installation for json server),  
   -download the project,  
   -open terminal in project folder dotd and run command: json-server --watch db.json.  
  
2) Run the project on the emulator:  
   -open project in Android Studio,  
   -turn on device emulator from AVD Manager,  
   -run application by pushing button(green arrow) Run 'main.dart'  
     
## What's new?  
   New Icon App  
   Feel free to add new recipes, update them, delete them, read them. Now you can also add ingredients collection together with new recipe!  
   Ingredients collection which you added with Recipe is available now to read in details screen  
