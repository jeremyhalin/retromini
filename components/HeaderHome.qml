import QtQuick 2.12

Rectangle {
    property var focused_link: {
        if (currentHomeIndex == 0) {
            return title_systems
        } else if (currentHomeIndex == 1) {
            return title_favorites
        } else if (currentHomeIndex == 2) {
            return title_apps
        } else {
            return title_recent
        }
    } 

    property var anyFocused: {
        return title_systems.activeFocus || title_favorites.activeFocus || title_recent.activeFocus || title_apps.activeFocus
    }

    property var light: false

    id: home_header
    color: "transparent"
    width: parent.width
    height: layoutHeader.height
    anchors.top: parent.top      


    // CustomBorder {
    //     leftMargin: 22
    //     rightMargin: 22
    //     width: parent.width 
    //     height: parent.height
    //     lBorderwidth: 0
    //     rBorderwidth: 0
    //     tBorderwidth: 0
    //     bBorderwidth: 1
    //     //color: theme.background
    //     color: "transparent"
    //     borderColor: "#e3e3e3"
    // }  

    Rectangle {
        anchors.leftMargin: 22
        anchors.rightMargin: 22
        anchors.left: parent.left
        anchors.right: parent.right
        color: light ? "#00ffffff" : "#20000000"
        anchors.bottom: parent.bottom
        height: 1
    }

    HeaderLink {
        id: title_systems
        title: "Systems"
        index: 0
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.leftMargin: 32
        lightText: light
        KeyNavigation.down: mainFocus
        KeyNavigation.right: title_favorites    
    }

    HeaderLink {
        id: title_favorites
        title: "Favorites"
        index: 1
        anchors.left: title_systems.right
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.leftMargin: 24
        lightText: light
        KeyNavigation.down: mainFocus    
        KeyNavigation.right: title_recent           
    }

    HeaderLink {
        id: title_recent
        title: "Recent"
        index: 2
        anchors.left: title_favorites.right
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.leftMargin: 24
        lightText: light
        KeyNavigation.down: mainFocus     
        KeyNavigation.right: title_apps                                
    }           
     
    HeaderLink {
        id: title_apps
        title: "Apps"
        index: 3
        anchors.left: title_recent.right
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.leftMargin: 24
        lightText: light
        KeyNavigation.down: mainFocus                  
    }       

    Text {
        id: header_time
        text: Qt.formatTime(new Date(), "hh:mm")          
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.rightMargin: 32
        color: "#9B9B9B"
        font.pixelSize: 18
        font.letterSpacing: -0.3
        font.bold: true              
    }      
    
}