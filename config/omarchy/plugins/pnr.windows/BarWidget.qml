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

  readonly property color foreground: bar ? bar.foreground : Color.foreground
  readonly property string fontFamily: bar ? bar.fontFamily : Style.font.family

  // Right-click window menu. Delegates are rebuilt whenever the toplevel list
  // changes, which would strand the popup's anchor, so the menu closes then.
  property bool menuOpen: false
  property var menuToplevel: null
  property Item menuAnchor: null
  readonly property var menuIpc: menuToplevel ? menuToplevel.lastIpcObject : ({})
  readonly property int menuWorkspaceId: menuToplevel && menuToplevel.workspace ? menuToplevel.workspace.id : 0

  onSortedToplevelsChanged: close()

  function close() {
    menuOpen = false
  }

  function openMenu(toplevel, anchor) {
    if (menuOpen && menuToplevel === toplevel) {
      close();
      return;
    }
    Hyprland.refreshToplevels();
    menuToplevel = toplevel;
    menuAnchor = anchor;
    menuOpen = true;
  }

  function dispatch(dispatcher, args, toplevel) {
    const target = toplevel || menuToplevel;
    if (!bar || !target) return;
    const window = "window = \"address:0x" + target.address + "\"";
    bar.run("hyprctl dispatch " + Util.shellQuote(dispatcher + "({ " + (args ? args + ", " : "") + window + " })"));
    close();
  }

  // Same set the workspaces widget shows: 1-5 plus any occupied up to 10.
  function workspaceIds() {
    const ids = [1, 2, 3, 4, 5];
    for (const ws of Hyprland.workspaces.values)
      if (ws.id > 0 && ws.id <= 10 && ids.indexOf(ws.id) === -1) ids.push(ws.id);
    ids.sort((a, b) => a - b);
    return ids;
  }

  // Span the full bar thickness so clicks at the screen edge still land.
  implicitWidth: vertical ? barSize : grid.implicitWidth
  implicitHeight: vertical ? grid.implicitHeight : barSize

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

        // heuristicLookup isn't reactive: depend on the entry list so the lookup
        // reruns after the async initial scan and after rescans, which destroy
        // the old entry objects (nulling a cached reference).
        readonly property var desktopEntry: {
          DesktopEntries.applications.values;
          return modelData.wayland ? DesktopEntries.heuristicLookup(modelData.wayland.appId) : null;
        }
        readonly property string iconSource: desktopEntry ? Quickshell.iconPath(desktopEntry.icon, "") : ""

        columns: root.vertical ? 1 : 2
        columnSpacing: 4
        rowSpacing: 4
        Layout.alignment: Qt.AlignCenter
        Layout.fillWidth: root.vertical
        Layout.fillHeight: !root.vertical

        // Separator between workspaces
        Rectangle {
          visible: entry.index > 0 && root.sortedToplevels[entry.index - 1].workspace !== entry.modelData.workspace
          Layout.preferredWidth: root.vertical ? 16 : 1
          Layout.preferredHeight: root.vertical ? 1 : 16
          Layout.alignment: Qt.AlignCenter
          color: Color.muted
        }

        MouseArea {
          Layout.preferredWidth: root.vertical ? root.barSize : 24
          Layout.preferredHeight: root.vertical ? 24 : root.barSize
          Layout.alignment: Qt.AlignCenter
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          hoverEnabled: true

          onClicked: mouse => {
            if (root.bar) root.bar.hideTooltip(this);
            if (mouse.button === Qt.RightButton)
              root.openMenu(entry.modelData, this);
            else
              root.dispatch("hl.dsp.focus", "", entry.modelData);
          }
          onEntered: if (root.bar && !root.menuOpen) root.bar.showTooltip(this, entry.modelData.title)
          onExited: if (root.bar) root.bar.hideTooltip(this)

          Rectangle {
            anchors.centerIn: parent
            width: 24
            height: 24
            radius: 4
            color: entry.modelData.activated || (root.menuOpen && root.menuToplevel === entry.modelData) ? Color.accent : "transparent"
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
            font.family: root.fontFamily
            font.pixelSize: 11
            color: root.foreground
          }
        }
      }
    }
  }

  component MenuRow: Item {
    id: row
    property string text: ""
    property bool checked: false
    signal activated

    width: parent ? parent.width : 0
    implicitHeight: Style.space(30)

    Rectangle {
      anchors.fill: parent
      radius: Math.max(2, Style.cornerRadius)
      color: rowMouse.containsMouse ? Style.hoverFillFor(root.foreground, root.foreground) : "transparent"
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      width: Style.space(22)
      horizontalAlignment: Text.AlignHCenter
      text: row.checked ? "" : ""
      color: root.foreground
      font.family: root.fontFamily
      font.pixelSize: Style.font.bodySmall
    }

    Text {
      textFormat: Text.PlainText
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      anchors.leftMargin: Style.space(28)
      anchors.right: parent.right
      text: row.text
      elide: Text.ElideRight
      color: root.foreground
      font.family: root.fontFamily
      font.pixelSize: Style.font.bodySmall
    }

    MouseArea {
      id: rowMouse
      anchors.fill: parent
      hoverEnabled: true
      onClicked: row.activated()
    }
  }

  component MenuSeparator: Item {
    width: parent ? parent.width : 0
    implicitHeight: Style.space(11)

    Rectangle {
      anchors.left: parent.left
      anchors.leftMargin: Style.space(10)
      anchors.right: parent.right
      anchors.rightMargin: Style.space(10)
      anchors.verticalCenter: parent.verticalCenter
      height: 1
      color: Color.popups.border
      opacity: 0.45
    }
  }

  PopupCard {
    id: menuPopup
    anchorItem: root.menuAnchor || root
    owner: root
    bar: root.bar
    open: root.menuOpen && root.menuToplevel !== null
    padding: Style.space(8)
    borderColor: Qt.rgba(root.foreground.r, root.foreground.g, root.foreground.b, 0.45)
    contentWidth: menuPopup.fittedContentWidth(Style.space(232))
    contentHeight: menuPopup.fittedContentHeight(menuColumn.implicitHeight)

    Column {
      id: menuColumn
      anchors.fill: parent
      spacing: 0

      Text {
        textFormat: Text.PlainText
        width: parent.width
        leftPadding: Style.space(8)
        rightPadding: Style.space(8)
        topPadding: Style.space(4)
        bottomPadding: Style.space(4)
        text: root.menuToplevel ? root.menuToplevel.title : ""
        elide: Text.ElideRight
        color: root.foreground
        font.family: root.fontFamily
        font.pixelSize: Style.font.bodySmall
        font.bold: true
      }

      MenuSeparator {}

      Text {
        textFormat: Text.PlainText
        leftPadding: Style.space(8)
        bottomPadding: Style.space(4)
        text: "Move to workspace"
        color: Qt.darker(root.foreground, 1.4)
        font.family: root.fontFamily
        font.pixelSize: Style.font.caption
      }

      Flow {
        width: parent.width
        leftPadding: Style.space(6)
        bottomPadding: Style.space(4)
        spacing: Style.space(4)

        Repeater {
          model: root.menuOpen ? root.workspaceIds().concat(["new"]) : []

          delegate: Item {
            id: wsButton
            required property var modelData
            readonly property bool current: modelData === root.menuWorkspaceId

            width: Style.space(26)
            height: Style.space(26)

            Rectangle {
              anchors.fill: parent
              radius: Math.max(2, Style.cornerRadius)
              color: wsButton.current ? Color.accent
                : wsMouse.containsMouse ? Style.hoverFillFor(root.foreground, root.foreground) : "transparent"
              opacity: wsButton.current ? 0.35 : 1
              border.width: 1
              border.color: Qt.rgba(root.foreground.r, root.foreground.g, root.foreground.b, 0.25)
            }

            Text {
              anchors.centerIn: parent
              text: wsButton.modelData === "new" ? "+" : (wsButton.modelData === 10 ? "0" : String(wsButton.modelData))
              color: root.foreground
              font.family: root.fontFamily
              font.pixelSize: Style.font.bodySmall
            }

            MouseArea {
              id: wsMouse
              anchors.fill: parent
              hoverEnabled: true
              enabled: !wsButton.current
              onClicked: root.dispatch("hl.dsp.window.move", "workspace = \"" + (wsButton.modelData === "new" ? "empty" : wsButton.modelData) + "\", follow = false")
            }
          }
        }
      }

      MenuSeparator {}

      MenuRow {
        text: "Floating"
        checked: root.menuIpc.floating === true
        onActivated: root.dispatch("hl.dsp.window.float", "action = \"toggle\"")
      }

      MenuRow {
        // Hyprland only pins floating windows.
        visible: root.menuIpc.floating === true
        height: visible ? implicitHeight : 0
        text: "Pinned"
        checked: root.menuIpc.pinned === true
        onActivated: root.dispatch("hl.dsp.window.pin", "")
      }

      MenuRow {
        text: "Maximized"
        checked: root.menuIpc.fullscreen === 1
        onActivated: root.dispatch("hl.dsp.window.fullscreen", "mode = \"maximized\"")
      }

      MenuRow {
        text: "Fullscreen"
        checked: root.menuIpc.fullscreen === 2
        onActivated: root.dispatch("hl.dsp.window.fullscreen", "mode = \"fullscreen\"")
      }

      MenuSeparator {}

      MenuRow {
        text: "Close"
        onActivated: root.dispatch("hl.dsp.window.close", "")
      }
    }
  }
}
