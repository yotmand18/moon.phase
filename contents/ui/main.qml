import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import "."

PlasmoidItem {
    id: root

    property var today: new Date()
    property var yesterday: { var d = new Date(); d.setDate(d.getDate() - 1); return d }
    property var tomorrow: { var d = new Date(); d.setDate(d.getDate() + 1); return d }

    property int moonPercent: getMoonPhase(today)

    preferredRepresentation: compactRepresentation
    compactRepresentation: CompactRepresentation {}
    fullRepresentation: Item {
    width: 200
    height: 100

    Column {
        anchors.centerIn: parent
        spacing: 5

        Text {
            text: "Yesterday: " + getMoonPhase(yesterday) + "%"
            color: "white"
        }
        Text {
            text: "Today: " + getMoonPhase(today) + "%"
            color: "white"
        }
        Text {
            text: "Tomorrow: " + getMoonPhase(tomorrow) + "%"
            color: "white"
        }
    }
}

    function getMoonPhase(date) {
        var known = new Date(2000, 0, 6)
        // var now = new Date()
        var diff = (date - known) / (1000 * 60 * 60 * 24)
        var cycle = diff % 29.53
        return Math.round((cycle / 29.53) * 100)
    }
}