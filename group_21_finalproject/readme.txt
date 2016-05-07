This program is called YouTook, a music oriented GUI project created by Ronly Leung, Sonik Jhang, and Tianhui Shen. Open the sketch and then install Minim and ControlP5 libraries(sketch, then adding library) to run it.

Open group21_finalproject.pde

This program has two modes: online and offline. On the starting page, click start to go to the menu page. 

On the offline mode, user can simply click on choose bottom to select local music file, the a music visualizer will pop up. Some music files are included in the data folder for you to try or try your own songs! Then user can choose different visualizations by pressing ‘c’, pause = ‘p’, resume  = ‘r’, and exit the visualizer mode = ‘x’. Clicking on the button “Choose” again you can change the song. There are 4 different visualizations and the one the travels in a circle interestingly affected the UI buttons. At first, our buttons merged into the frames and became a part of the visualization but using pushMatrix() and popMatrix() solved the problem.

On the online mode, type the artist name. A pop up of the results in the form of a drop down box will be displayed. The lyrics will show up on the right. The results will change to the name of the song. You can scroll to see the text further down. Click on this again if you want to select a different song. Once click on the YouTube button and a search query of the song will be generated in your browser. Sometimes the bar for the results will lock up. To solve this problem, click on the 
top bar to reset the functionality.

Classes: online gui, offline gui, ChartLyrics API, itunes API, YouTube, visualizations

We hope you enjoy our project!


