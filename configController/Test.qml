
import QtQuick 2.6
import QtQuick.Controls 2.1
ApplicationWindow {
    id: configWindow
    width: 900
    height: 600
    visible: true
    title: "Configurar Mando"
    color: "black"
Page {
    id: page
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Repeater {
            model: 3
            Pane {
                width: swipeView.width
                height: swipeView.height
                Column {
                    spacing: 40
                    width: parent.width
                    Label {
                        width: parent.width
                        wrapMode: Label.Wrap
                        horizontalAlignment: Qt.AlignHCenter
                        text: "TabBar is a bar with icons or text which allows the user"
                              + "to switch between different subtasks, views, or modes."
                    }
                }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton { text: "First" }
        TabButton { text: "Second" }
        TabButton { text: "Third"  }
    }
}
}
