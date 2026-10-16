import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

// Ported from the old standalone Quickshell bar (config/quickshell/Windows.qml)
BarWidget {
  id: root
  moduleName: "pnr.windows"

  readonly property var sortedToplevels: {
    const list = [...Hyprland.toplevels.values];
    list.sort((a, b) => (a.workspace ? a.workspace.id : 0) - (b.workspace ? b.workspace.id : 0));
    return list;
  }

  implicitWidth: grid.implicitWidth
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    columns: root.vertical ? 1 : Math.max(1, root.sortedToplevels.length)
    columnSpacing: 4
    rowSpacing: 4

    Repeater {
      model: root.sortedToplevels

      delegate: GridLayout {
        id: entry
        required property HyprlandToplevel modelData
        required property int index

        readonly property var desktopEntry: modelData.wayland ? DesktopEntries.heuristicLookup(modelData.wayland.appId) : null
        readonly property string iconSource: desktopEntry ? Quickshell.iconPath(desktopEntry.icon, "") : ""

        columns: root.vertical ? 1 : 2
        columnSpacing: 4
        rowSpacing: 4
        Layout.alignment: Qt.AlignCenter

        // Separator between workspaces
        Rectangle {
          visible: entry.index > 0 && root.sortedToplevels[entry.index - 1].workspace !== entry.modelData.workspace
          Layout.preferredWidth: root.vertical ? 16 : 1
          Layout.preferredHeight: root.vertical ? 1 : 16
          Layout.alignment: Qt.AlignCenter
          color: Color.muted
        }

        MouseArea {
          Layout.preferredWidth: 24
          Layout.preferredHeight: 24
          Layout.alignment: Qt.AlignCenter
          hoverEnabled: true

          onClicked: if (root.bar)
            root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ window = \"address:0x" + entry.modelData.address + "\" })"))
          onEntered: if (root.bar) root.bar.showTooltip(this, entry.modelData.title)
          onExited: if (root.bar) root.bar.hideTooltip(this)

          Rectangle {
            anchors.fill: parent
            radius: 4
            color: entry.modelData.activated ? Color.accent : "transparent"
            opacity: 0.35
          }

          IconImage {
            visible: entry.iconSource !== ""
            anchors.centerIn: parent
            implicitSize: 16
            source: entry.iconSource
          }

          Text {
            visible: entry.iconSource === ""
            anchors.centerIn: parent
            text: entry.modelData.title.slice(0, 2)
            font.family: root.bar ? root.bar.fontFamily : "monospace"
            font.pixelSize: 11
            color: root.bar ? root.bar.foreground : Color.foreground
          }
        }
      }
    }
  }
}
