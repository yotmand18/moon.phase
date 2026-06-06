// CompactRepresentation.qml
import QtQuick
import org.kde.plasma.plasmoid
import Qt5Compat.GraphicalEffects

Item {
    
    
    Item {
        id: innerItem
        width: 32
        height: 32
        clip: true
        anchors.centerIn: parent

        property int frameIndex: {
            var p = root.moonPercent
            if (p >= 90) return 0
            if (p >= 60) return 1
            if (p >= 35) return 2
            if (p >= 15) return 3
            if (p > 0)   return 4
            return 5
        }

        Image {
            id: moonImage

            source: Qt.resolvedUrl("../images/moon-strip.png")
            // width: 242
            // height: 22
            // fillMode: Image.Pad
            x: -innerItem.frameIndex * 32
            y: 0

            
        }

        // DropShadow {
        //     anchors.fill: moonImage
        //     source: moonImage
        //     radius: 2
        //     color: "white"
        //     spread: 0.2
        // }
    }

    

    MouseArea {
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded
    }


    // Text {
    //     id: label
    //     text: "🌙 " + root.moonPercent + "%"
    //     anchors.centerIn: parent
    //     color: "white"
    // }
}
