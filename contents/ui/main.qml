import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import "."

PlasmoidItem {
    id: root

    property bool isWaning: ifWaning(todayPercent, yesterdayPercent)

    property var today: {        var d = new Date(); d.setHours(0,0,0,0); return d }
    property var yesterday: { var d = new Date(); d.setDate(d.getDate() - 1); d.setHours(0,0,0,0); return d }
    property var tomorrow: { var d = new Date(); d.setDate(d.getDate() + 1); d.setHours(0,0,0,0); return d }


    property var yesterdayPercent: getMoonPercent(yesterday)
    property var todayPercent: getMoonPercent(today)
    property var tomorrowPercent: getMoonPercent(tomorrow)
    

    // property int moonPercent: getMoonPercent(today)

    preferredRepresentation: compactRepresentation
    compactRepresentation: CompactRepresentation {}
    fullRepresentation: Item {
        width: 200
        height: 100

        Column {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "Yesterday: " + yesterdayPercent + "%"
                color: "white"
            }
            Text {
                text: "Today: " + todayPercent + "%"
                color: "white"
            }
            Text {
                text: "Tomorrow: " + tomorrowPercent + "%"
                color: "white"
            }
        }
    }

    function getMoonPercent(date) {
        var known = new Date(2024, 5, 6)
        var diff = (date - known) / (1000 * 60 * 60 * 24)
        var cycle = diff % 29.53

        if (cycle <= 14.765) {
            // waxing: 0% to 100%
            return Math.round((cycle / 14.765) * 100)
        } else {
            // waning: 100% back to 0%
            return Math.round(((29.53 - cycle) / 14.765) * 100)
        }
    }

    function ifWaning(todayPercent, yesterdayPercent) {
        if(todayPercent < yesterdayPercent) 
            return true
        else
            return false
    }

}
