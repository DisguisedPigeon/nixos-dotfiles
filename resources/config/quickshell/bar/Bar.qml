import Quickshell
import QtQuick.Layouts

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    margins {
        top: 5
        left: 5
        right: 5
        bottom: 5
    }

    implicitHeight: 30

    // Left
    RowLayout {
        anchors.left: parent
        Workspaces {}
    }

    // Center
    RowLayout {
        anchors.centerIn: parent
        Clock {}
    }
    // Right
    RowLayout {
        anchors.right: parent
    }
}
