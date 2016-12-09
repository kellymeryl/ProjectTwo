# Project 2
## Feedr Reader

This application is an application that allows a user to choose from a list of news sources, load those news source articles, search through the articles, and load them.

In the first view controller, the user has the ability to view the articles from The Wall Street Journal (the default news source).  The user can click on an article table view cell to load the article, the user can press the "Browse" button to sort the articles by category, or the user can press the "Menu" button to see all of the available news sources and click on alternate news sources.  

If a user presses the "Menu" button, the news source tableview loads as a drawer slider menu.  The user can click an alternate news source which closes the slider drawer menu and reloads the table view of articles on the first view controller.  At the bottom of the list in the "Menu" drawer table view is a "Search All" table view cell.  When a user chooses this cell, all of the news sources append to one array and the user has the ability to search through and sort all of the articles from every news sources at once.

If a user presses the "Browse" button, a picker view menu appears at the bottom of the view controller.  The picker view dislays a menu of all available categories a user can search through.  When a user chooses a category, the articles reload in the image view with the chosen category inserted in the API. The default category that loads if a user doesn't pick a category from the picker view is "General".  When a user presses the "Done" button, the picker view disappears and the "Browse" button reappears.

If a user presses the news article's cell, the news article pushes a Safari View controller and loads the article itself.

If a user types in the search bar, a new array titled "Filtered Results" becomes the table view output.  The search bar filters results by searching through each article title.  As a user begins to type, the results automatically begin to filter (for example, as a user types "Trump", when the user types "T", all of the articles with a title that begins with "T" appear immediately).

![](https://github.com/kellymeryl/ProjectTwo/blob/develop/ProjectTwoKellyMcNevin/Images/homeScreen.png?raw=true)    ![](https://github.com/kellymeryl/ProjectTwo/blob/develop/ProjectTwoKellyMcNevin/Images/page2.png?raw=true)  ![](https://github.com/kellymeryl/ProjectTwo/blob/develop/ProjectTwoKellyMcNevin/Images/page3.png?raw=true)  

![](https://github.com/kellymeryl/ProjectTwo/blob/develop/ProjectTwoKellyMcNevin/Images/page4.png?raw=true)  ![](https://github.com/kellymeryl/ProjectTwo/blob/develop/ProjectTwoKellyMcNevin/Images/pickerViewScreen.png?raw=true) ![](https://github.com/kellymeryl/ProjectTwo/blob/develop/ProjectTwoKellyMcNevin/Images/SafariView.png?raw=true)