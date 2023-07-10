import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: "Drag and Drop"

    function resetGridView() {
        for (var i = 0; i < gridView.count; i++) {
            gridView.itemAtIndex(i).color = "black"
        }
    }

    Item {
        width: parent.width
        height: parent.height

        MouseArea {
            z: 1
            id: mouseArea
            width: 64
            height: 64
            anchors.centerIn: parent
            drag.target: tile
            onReleased: {
                parent = tile.Drag.target !== null ? tile.Drag.target : gridView.dragTarget
                tile.Drag.drop()
            }

            Rectangle {
                id: tile

                width: gridView.cellWidth - 10
                height: gridView.cellHeight - 10
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                color: "green"
                Drag.active: mouseArea.drag.active
                Drag.hotSpot.x: 32
                Drag.hotSpot.y: 32

                states: State {
                    when: mouseArea.drag.active
                    AnchorChanges {
                        target: tile
                        anchors {
                            verticalCenter: undefined
                            horizontalCenter: undefined
                        }
                    }
                }
            }
        }

        GridView {
            id: gridView
            model: 100

            cellWidth: parent.width / 10
            cellHeight: parent.height / 10
            width: parent.width
            height: parent.height - 100

            delegate: Rectangle {
                id: dropRectangle
                color: "black"
                width: gridView.cellWidth - 10
                height: gridView.cellHeight - 10

                DropArea {
                    id: dragTarget
                    anchors.fill: parent
                    z: 1

                onEntered: {

                    var nextRowIndex = index + rowIndex.value;
                    var nextColIndex = index - 1 + colIndex.value * 10;
                    console.log(nextRowIndex);
                    var row = Math.floor(index / 10) + 1;
                    var col = index % 10 + 1;
                    console.log("row:", row, "col:", col);

                    if (hoverSwitch.checked) {

                        for (var a = index; a <= Math.min(nextColIndex, 99); a += 10) {
                            for (var b = a; b < Math.min(a + nextRowIndex - index, 100); b++) {
                                gridView.itemAtIndex(b).color = "green";
                                tile.color = "green"
                                if (b % 10 === 9) {
                                    break;
                                }
                            }
                            if (a % 10 === 9 || a === nextColIndex) {
                                break;
                            }
                        }
                        if (row != Math.floor((nextRowIndex - 1) / 10) + 1 || nextColIndex >= 100) {
                            for (var a = index; a <= nextColIndex && a < 100; a += 10) {
                                for (var b = a; b < Math.min(a + nextRowIndex - index, 100); b++) {
                                    gridView.itemAtIndex(b).color = "red";
                                    tile.color = "red"
                                    if (b % 10 === 9) {
                                        break;
                                    }
                                }
                                if (a % 10 === 9 || a === nextColIndex) {
                                    break;
                                }
                            }
                        }

                    }

                    else {
                        dropRectangle.color = "grey"
                    }
                }


                onExited: {

                    var nextRowIndex = index + rowIndex.value;
                    var nextColIndex = index - 1 + colIndex.value * 10;
                    console.log(nextRowIndex);
                    var row = Math.floor(index / 10) + 1;
                    var col = index % 10 + 1;
                    console.log("row:", row, "col:", col);

                    for (var a = index; a <= Math.min(nextColIndex, 99); a += 10) {
                        for (var b = a; b < Math.min(a + nextRowIndex - index, 100); b++) {
                            gridView.itemAtIndex(b).color = "black";
                            tile.color = "green"
                            if (b % 10 === 9) {
                                break;
                            }
                        }
                        if (a % 10 === 9 || a === nextColIndex) {
                            break;
                        }
                    }
                    if (row != Math.floor((nextRowIndex - 1) / 10) + 1 || nextColIndex >= 100) {
                        for (var a = index; a <= nextColIndex && a < 100; a += 10) {
                            for (var b = a; b < Math.min(a + nextRowIndex - index, 100); b++) {
                                gridView.itemAtIndex(b).color = "black";
                                tile.color = "green"
                                if (b % 10 === 9) {
                                    break;
                                }
                            }
                            if (a % 10 === 9 || a === nextColIndex) {
                                break;
                            }
                        }
                    }

                }

                onDropped: {
                    var nextRowIndex = index + rowIndex.value;
                    var nextColIndex = index - 1 + colIndex.value * 10;
                    console.log(nextRowIndex);
                    var row = Math.floor(index / 10) + 1;
                    var col = index % 10 + 1;
                    console.log("row:", row, "col:", col);

                    for (var a = index; a <= Math.min(nextColIndex, 99); a += 10) {
                        for (var b = a; b < Math.min(a + nextRowIndex - index, 100); b++) {
                            gridView.itemAtIndex(b).color = "green";
                            tile.color = "green"
                            if (b % 10 === 9) {
                                break;
                            }
                        }
                        if (a % 10 === 9 || a === nextColIndex) {
                            break;
                        }
                    }
                    if (row != Math.floor((nextRowIndex - 1) / 10) + 1 || nextColIndex >= 100) {
                        for (var a = index; a <= nextColIndex && a < 100; a += 10) {
                            for (var b = a; b < Math.min(a + nextRowIndex - index, 100); b++) {
                                gridView.itemAtIndex(b).color = "red";
                                tile.color = "red"
                                if (b % 10 === 9) {
                                    break;
                                }
                            }
                            if (a % 10 === 9 || a === nextColIndex) {
                                break;
                            }
                        }
                    }
                }
            }
        }
    }

        Row {
            id: rowLayout
            spacing: 5
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            SpinBox {
                id: rowIndex
                value: 5
                from: 0
                to: 9
                width: parent.width/4
            }

            SpinBox {
                id: colIndex
                value: 5
                from: 0
                to: 9
                width: parent.width/4
            }

            Button {
                text: "Reset"
                width: parent.width/4

                onClicked: {
                    resetGridView();
                }
            }

            Switch {
                id: hoverSwitch
                width: parent.width/4

                onToggled: {
                }
            }
        }
    }
}


