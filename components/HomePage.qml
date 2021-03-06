import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: homepage  
    width: parent.width
    height: parent.height
    
    property var footerTitle: {
        switch (currentHomeIndex) {
        case 0: 
            return systemsListView.footerTitle
        case 1:
            return favoriteView.footerTitle
        case 2: 
            return recentsView.footerTitle
        case 3:
            return appsView.footerTitle
        default: 
            return ""
        }
    }

    Keys.onPressed: {                                            

        // Prev
        if (api.keys.isPageUp(event)) {
            event.accepted = true
            setHomeIndex(Math.max(currentHomeIndex - 1,0))
            navSound.play()
            return
        }  
        
        // Next
        if (api.keys.isPageDown(event)) {
            event.accepted = true;
            setHomeIndex(Math.min(currentHomeIndex + 1,3))
            navSound.play();
            return;
        }  

    }  

    Rectangle {
        id: rect
        anchors.fill: parent
        color: currentHomeIndex == 0 ? "#FEFEFE" : "transparent"
    }

    HeaderHome {
        id: header
        z: 1000
        light: (currentHomeIndex == 0 && currentPage === "HomePage")
    }

    Footer {
        id: footer
        title: footerTitle
        light: (currentHomeIndex == 0 && currentPage === "HomePage")
        anchors.bottom: homepage.bottom
        visible: true
        z: 1000
    }


    FocusScope {
        id: mainFocus
        focus: currentPage === "HomePage" ? true : false ;

        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: footer.top
        }

        Keys.onPressed: {                                            
            // Back to Home            
            if (api.keys.isCancel(event)) {
                header.focused_link.forceActiveFocus()
                event.accepted = true;                    
            } else {
                event.accepted = false;                
            }
        }

        Rectangle {
            id: main
            color: "transparent"
            anchors {
                fill: parent
            }
                        
            Rectangle {
                id: main_content
                color: "transparent"
                anchors {
                    fill: parent
                }

                // Systems        
                SystemsListLarge {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    //anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: parent.width
                    visible: currentHomeIndex == 0
                    focus: currentHomeIndex == 0
                    headerFocused: header.anyFocused
                    id: systemsListView
                }
                
                // Favourites
                GamesList {
                    id: favoriteView
                    width: parent.width
                    height: parent.height
                    items: allFavorites      
                    visible: currentHomeIndex == 1
                    focus: currentHomeIndex == 1
                    hideFavoriteIcon: true
                }

                // Recents
                GamesList {
                    id: recentsView
                    width: parent.width
                    height: parent.height
                    items: allRecentlyPlayed      
                    visible: currentHomeIndex == 2
                    focus: currentHomeIndex == 2
                }

                // Apps
                GamesList {
                    id: appsView
                    width: parent.width
                    height: parent.height
                    items: androidCollection.games      
                    visible: currentHomeIndex == 3
                    focus: currentHomeIndex == 3
                }          
            } 
        }  
    }
}