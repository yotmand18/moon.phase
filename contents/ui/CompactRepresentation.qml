// CompactRepresentation.qml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import Qt5Compat.GraphicalEffects
import org.kde.plasma.plasma5support as Plasma5Support

Item {
    Layout.preferredWidth: 240
    Layout.preferredHeight: 32
    
    Rectangle {
        width: 240
        height: 32
        color: "black"
        opacity: 0.2
        radius: 32
        anchors.verticalCenter: parent.verticalCenter
    }

    property string dataPath: Qt.resolvedUrl("../data/panel_schedule.py").toString().replace("file://", "")

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: [dataPath]
        onNewData: function(source, data) {
            scheduleText = data["stdout"].trim()
        }
    }

    property string scheduleText: ""

    property string textColor: {
        if (scheduleText === "Studying")
            return "#ff8c81"
        else if (scheduleText === "Chilling")
            return "#8067ff"
        else if (scheduleText == "Spanko")
            return "#1d2cff"
        else
            return "white"
    }

    Timer {
        interval: 60000  // 60 seconds in milliseconds
        running: true
        repeat: true
        onTriggered: executable.connectedSources = [dataPath]
    }

    Text {
        width: 180

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        color: textColor
        font.family: "Inter Black"
        font.pixelSize: 26
        font.weight: Font.Black


        text: scheduleText

    }



    Item {
        id: innerItem
        width: 32
        height: 32
        clip: true
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 15



        property int frameIndex: {
            var a = root.isWaning

            var p = root.todayPercent

            if (p <= 6)     return 0
            if (p <= 14)    return (1 + (a * 12) )
            if (p <= 22)    return (2 + (a * 12) )
            if (p <= 30)    return (3 + (a * 12) )
            if (p <= 38)    return (4 + (a * 12) )
            if (p <= 46)    return (5 + (a * 12) )
            if (p <= 54)    return (6 + (a * 12) )
            if (p <= 62)    return (7 + (a * 12) )
            if (p <= 70)    return (8 + (a * 12) )
            if (p <= 78)    return (9 + (a * 12) )
            if (p <= 86)    return (10 + (a * 12) )
            if (p <= 94)    return (11 + (a * 12) )
                            return 12
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
