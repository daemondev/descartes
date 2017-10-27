1.- Install NodeJS
2.- Install Gulp and Gulp-Tools
    npm install -g gulp
    npm install -g gulp-browser
    npm install -g gulp-size
    npm install -g del
    npm install -g reactify
3.- After install all, run this command in the root of project (./DESCARTES_20102017)
    npm link gulp gulp-browser gulp-size del reactify
4.- If display: 'Error ... "HTTP Error 403.14" ...', Run in IIS[Express] installed Directory
    appcmd set config /section:directoryBrowse /enabled:true
