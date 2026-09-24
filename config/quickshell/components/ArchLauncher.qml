import Quickshell
import QtQuick
import QtQuick.Controls

Item {
    id: archLauncher

    // ============================================================
    // CONEXÃO COM A BARRA
    // ============================================================

    property var barWindow

    // ============================================================
    // FONTES
    // ============================================================

    readonly property string fontFamily:
        "sans-serif"

    readonly property string iconFontFamily:
        "JetBrainsMono Nerd Font"

    // ============================================================
    // CORES — BOTÃO ARCH
    // ============================================================

    readonly property color launcherButtonBackground:
        "#000000"

    readonly property color launcherButtonBackgroundHover:
        "#25232b"

    readonly property color launcherButtonBorder:
        "#18161c"

    readonly property color launcherButtonBorderHover:
        "#3a3542"

    readonly property color launcherButtonIcon:
        "#4da6ff"

    readonly property color launcherButtonIconHover:
        "#7dd6ff"

    // ============================================================
    // CORES — POPUP
    // ============================================================

    readonly property color popupBackground:
        "#111014"

    readonly property color popupBorder:
        "#302b38"

    readonly property color popupSearchBackground:
        "#1b1920"

    readonly property color popupSearchBorder:
        "#29252f"

    readonly property color popupSearchBorderFocus:
        "#4d4658"

    // ============================================================
    // CORES — TEXTO
    // ============================================================

    readonly property color searchIconColor:
        "#8b8b92"

    readonly property color searchTextColor:
        "#eeeeef"

    readonly property color applicationTextColor:
        "#eeeeef"

    // ============================================================
    // CORES — SELEÇÃO
    // ============================================================

    readonly property color applicationHoverBackground:
        "#211e27"

    readonly property color applicationSelectedBackground:
        "#25212d"

    readonly property color applicationSelectedBorder:
        "#4a4058"

    // ============================================================
    // TRANSPARÊNCIA
    // ============================================================

    readonly property real popupOpacity:
        0.96

    // ============================================================
    // TAMANHO DO BOTÃO ARCH
    // ============================================================

    readonly property int launcherButtonWidth:
        50

    readonly property int launcherButtonHeight:
        32

    readonly property int launcherButtonRadius:
        16

    readonly property int launcherIconSize:
        19

    // ============================================================
    // TAMANHO DA POPUP
    // ============================================================

    readonly property int popupWidth:
        650
        //720

    readonly property int popupHeight:
        620

    readonly property int popupRadius:
        7

    readonly property int popupBorderWidth:
        1

    // ============================================================
    // BUSCA
    // ============================================================

    readonly property int searchHeight:
        50

    readonly property int searchRadius:
        14

    readonly property int searchHorizontalMargin:
        16

    readonly property int searchTopMargin:
        16

    readonly property int searchIconSize:
        17

    readonly property int searchFontSize:
        15

    readonly property int searchSpacing:
        11

    // ============================================================
    // GRADE
    // ============================================================

    readonly property int gridTopMargin:
        16

    readonly property int gridHorizontalMargin:
        18

    readonly property int gridBottomMargin:
        16

    readonly property int gridSpacingHorizontal:
        8

    readonly property int gridSpacingVertical:
        12

    readonly property int gridItemWidth:
        112

    readonly property int gridItemHeight:
        104

    readonly property int applicationIconSize:
        52

    readonly property int applicationNameFontSize:
        13

    readonly property int applicationNameMaximumWidth:
        100

    readonly property int applicationIconTextSpacing:
        7

    readonly property int selectedBorderWidth:
        1

    // ============================================================
    // TAMANHO DO BOTÃO
    // ============================================================

    implicitWidth:
        launcherButtonWidth

    implicitHeight:
        launcherButtonHeight

    // ============================================================
    // BOTÃO ARCH
    // ============================================================

    Rectangle {
        id: launcherButton

        anchors.fill:
            parent

        radius:
            archLauncher.launcherButtonRadius

        color:
            launcherMouseArea.containsMouse
            ? archLauncher.launcherButtonBackgroundHover
            : archLauncher.launcherButtonBackground

        border.width:
            1

        border.color:
            launcherMouseArea.containsMouse
            ? archLauncher.launcherButtonBorderHover
            : archLauncher.launcherButtonBorder

        Text {
            anchors.centerIn:
                parent

            text:
                ""

            font.family:
                archLauncher.iconFontFamily

            font.pixelSize:
                archLauncher.launcherIconSize

            color:
                launcherMouseArea.containsMouse
                ? archLauncher.launcherButtonIconHover
                : archLauncher.launcherButtonIcon
        }

        MouseArea {
            id: launcherMouseArea

            anchors.fill:
                parent

            hoverEnabled:
                true

            onClicked:
                launcher.toggle()
        }
    }

    // ============================================================
    // POPUP
    // ============================================================

    PopupWindow {
        id: launcher

        visible:
            false

        grabFocus:
            true

        anchor.window:
            archLauncher.barWindow

        anchor.rect.x:
            (barWindow.width - implicitWidth) / 2

        anchor.rect.y:
            48 + 12

        implicitWidth:
            archLauncher.popupWidth

        implicitHeight:
            archLauncher.popupHeight

        color:
            "transparent"

        // ========================================================
        // ESTADO
        // ========================================================

        property string searchText:
            ""

        property int selectedIndex:
            0

        property int gridColumns:
            Math.max(
                1,
                Math.floor(
                    (
                        archLauncher.popupWidth -
                        archLauncher.gridHorizontalMargin * 2 +
                        archLauncher.gridSpacingHorizontal
                    ) /
                    (
                        archLauncher.gridItemWidth +
                        archLauncher.gridSpacingHorizontal
                    )
                )
            )

        // ========================================================
        // NORMALIZAÇÃO
        // ========================================================

        function normalize(text) {

            return String(text || "")
                .toLowerCase()
                .normalize("NFD")
                .replace(
                    /[\u0300-\u036f]/g,
                    ""
                )
        }

        // ========================================================
        // LEVENSHTEIN
        // ========================================================

        function levenshtein(a, b) {

            a =
                normalize(a)

            b =
                normalize(b)

            if (a === b)
                return 0

            if (a.length === 0)
                return b.length

            if (b.length === 0)
                return a.length

            var previous = []

            for (
                var i = 0;
                i <= b.length;
                i++
            ) {
                previous[i] =
                    i
            }

            for (
                var row = 1;
                row <= a.length;
                row++
            ) {

                var current =
                    [row]

                for (
                    var column = 1;
                    column <= b.length;
                    column++
                ) {

                    var insertCost =
                        current[column - 1] + 1

                    var deleteCost =
                        previous[column] + 1

                    var replaceCost =
                        previous[column - 1] +
                        (
                            a.charAt(row - 1) ===
                            b.charAt(column - 1)
                            ? 0
                            : 1
                        )

                    current[column] =
                        Math.min(
                            insertCost,
                            deleteCost,
                            replaceCost
                        )
                }

                previous =
                    current
            }

            return previous[b.length]
        }

        // ========================================================
        // PONTUAÇÃO DE CAMPO
        // ========================================================

        function scoreField(text, query) {

            var value =
                normalize(text)

            if (
                !value ||
                !query
            ) {
                return 0
            }

            if (value === query)
                return 1000

            if (value.startsWith(query))
                return 800 - value.length

            if (value.includes(query))
                return 600 - value.length

            var words =
                value.split(
                    /[\s\-_.:/]+/
                )

            var best =
                0

            for (
                var i = 0;
                i < words.length;
                i++
            ) {

                var word =
                    words[i]

                if (!word)
                    continue

                if (word === query) {

                    best =
                        Math.max(
                            best,
                            1000
                        )

                    continue
                }

                if (word.startsWith(query)) {

                    best =
                        Math.max(
                            best,
                            850 - word.length
                        )

                    continue
                }

                if (word.includes(query)) {

                    best =
                        Math.max(
                            best,
                            650 - word.length
                        )

                    continue
                }

                if (query.length >= 4) {

                    var distance =
                        launcher.levenshtein(
                            word,
                            query
                        )

                    var allowed =
                        query.length <= 5
                        ? 1
                        : query.length <= 8
                        ? 2
                        : 3

                    if (
                        distance <=
                        allowed
                    ) {

                        best =
                            Math.max(
                                best,
                                500 -
                                distance * 80
                            )
                    }
                }
            }

            return best
        }

        // ========================================================
        // PONTUAÇÃO DA APLICAÇÃO
        // ========================================================

        function applicationScore(
            app,
            query
        ) {

            if (!query)
                return 1

            var tokens =
                normalize(query)
                    .split(/\s+/)

            var total =
                0

            for (
                var i = 0;
                i < tokens.length;
                i++
            ) {

                var token =
                    tokens[i]

                if (!token)
                    continue

                var best =
                    scoreField(
                        app.name,
                        token
                    ) * 4

                best =
                    Math.max(
                        best,
                        scoreField(
                            app.genericName,
                            token
                        ) * 2
                    )

                best =
                    Math.max(
                        best,
                        scoreField(
                            app.comment,
                            token
                        )
                    )

                var keywords =
                    app.keywords || []

                for (
                    var k = 0;
                    k < keywords.length;
                    k++
                ) {

                    best =
                        Math.max(
                            best,
                            scoreField(
                                keywords[k],
                                token
                            ) * 2
                        )
                }

                if (best <= 0)
                    return 0

                total +=
                    best
            }

            return total
        }

        // ========================================================
        // APLICAÇÕES FILTRADAS
        // ========================================================

        function filteredApplications() {

            var applications =
                DesktopEntries
                    .applications
                    .values

            var query =
                normalize(
                    searchText
                ).trim()

            var results =
                []

            for (
                var i = 0;
                i < applications.length;
                i++
            ) {

                var app =
                    applications[i]

                if (
                    !app ||
                    app.noDisplay
                ) {
                    continue
                }

                var score =
                    applicationScore(
                        app,
                        query
                    )

                if (score > 0) {

                    results.push({
                        app: app,
                        score: score
                    })
                }
            }

            results.sort(
                function(a, b) {

                    if (
                        b.score !==
                        a.score
                    ) {

                        return (
                            b.score -
                            a.score
                        )
                    }

                    return String(
                        a.app.name
                    ).localeCompare(
                        String(
                            b.app.name
                        )
                    )
                }
            )

            var output =
                []

            for (
                var j = 0;
                j < results.length;
                j++
            ) {

                output.push(
                    results[j].app
                )
            }

            return output
        }

        // ========================================================
        // EXECUTAR APLICAÇÃO
        // ========================================================

        function launch(index) {

            var applications =
                filteredApplications()

            if (
                index < 0 ||
                index >= applications.length
            ) {
                return
            }

            var app =
                applications[index]

            visible =
                false

            app.execute()
        }

        // ========================================================
        // ABRIR / FECHAR
        // ========================================================

        function toggle() {

            visible =
                !visible

            if (visible) {

                searchText =
                    ""

                selectedIndex =
                    0

                Qt.callLater(
                    function() {

                        searchInput.text =
                            ""

                        searchInput.forceActiveFocus()
                    }
                )
            }
        }

        // ========================================================
        // MODELO
        // ========================================================

        ScriptModel {
            id: applicationModel

            values:
                launcher.filteredApplications()
        }

        // ========================================================
        // FUNDO DA POPUP
        // ========================================================

        Rectangle {
            anchors.fill:
                parent

            radius:
                archLauncher.popupRadius

            color:
                Qt.rgba(
                    archLauncher.popupBackground.r,
                    archLauncher.popupBackground.g,
                    archLauncher.popupBackground.b,
                    archLauncher.popupOpacity
                )

            border.width:
                archLauncher.popupBorderWidth

            border.color:
                archLauncher.popupBorder
        }

        // ========================================================
        // CAMPO DE BUSCA
        // ========================================================

        Rectangle {
            id: searchBox

            x:
                archLauncher.searchHorizontalMargin

            y:
                archLauncher.searchTopMargin

            width:
                parent.width -
                archLauncher.searchHorizontalMargin * 2

            height:
                archLauncher.searchHeight

            radius:
                archLauncher.searchRadius

            color:
                archLauncher.popupSearchBackground

            border.width:
                1

            border.color:
                searchInput.activeFocus
                ? archLauncher.popupSearchBorderFocus
                : archLauncher.popupSearchBorder

            Row {
                anchors.fill:
                    parent

                anchors.leftMargin:
                    15

                anchors.rightMargin:
                    14

                spacing:
                    archLauncher.searchSpacing

                Text {
                    anchors.verticalCenter:
                        parent.verticalCenter

                    text:
                        ""

                    font.family:
                        archLauncher.iconFontFamily

                    font.pixelSize:
                        archLauncher.searchIconSize

                    color:
                        archLauncher.searchIconColor
                }

                TextInput {
                    id: searchInput

                    width:
                        parent.width - 30

                    height:
                        parent.height

                    anchors.verticalCenter:
                        parent.verticalCenter

                    verticalAlignment:
                        Text.AlignVCenter

                    color:
                        archLauncher.searchTextColor

                    font.family:
                        archLauncher.fontFamily

                    font.pixelSize:
                        archLauncher.searchFontSize

                    clip:
                        true

                    text:
                        launcher.searchText

                    onTextChanged: {

                        launcher.searchText =
                            text

                        launcher.selectedIndex =
                            0

                        applicationGrid.positionViewAtIndex(
                            0,
                            GridView.Beginning
                        )
                    }

                    // =================================================
                    // BAIXO
                    // =================================================

                    Keys.onDownPressed: {

                        if (
                            applicationGrid.count <= 0
                        ) {
                            return
                        }

                        launcher.selectedIndex =
                            Math.min(
                                launcher.selectedIndex +
                                launcher.gridColumns,
                                applicationGrid.count - 1
                            )

                        applicationGrid.positionViewAtIndex(
                            launcher.selectedIndex,
                            GridView.Contain
                        )
                    }

                    // =================================================
                    // CIMA
                    // =================================================

                    Keys.onUpPressed: {

                        if (
                            applicationGrid.count <= 0
                        ) {
                            return
                        }

                        launcher.selectedIndex =
                            Math.max(
                                launcher.selectedIndex -
                                launcher.gridColumns,
                                0
                            )

                        applicationGrid.positionViewAtIndex(
                            launcher.selectedIndex,
                            GridView.Contain
                        )
                    }

                    // =================================================
                    // DIREITA
                    // =================================================

                    Keys.onRightPressed: {

                        if (
                            applicationGrid.count <= 0
                        ) {
                            return
                        }

                        launcher.selectedIndex =
                            Math.min(
                                launcher.selectedIndex + 1,
                                applicationGrid.count - 1
                            )

                        applicationGrid.positionViewAtIndex(
                            launcher.selectedIndex,
                            GridView.Contain
                        )
                    }

                    // =================================================
                    // ESQUERDA
                    // =================================================

                    Keys.onLeftPressed: {

                        if (
                            applicationGrid.count <= 0
                        ) {
                            return
                        }

                        launcher.selectedIndex =
                            Math.max(
                                launcher.selectedIndex - 1,
                                0
                            )

                        applicationGrid.positionViewAtIndex(
                            launcher.selectedIndex,
                            GridView.Contain
                        )
                    }

                    // =================================================
                    // ENTER
                    // =================================================

                    Keys.onReturnPressed:
                        launcher.launch(
                            launcher.selectedIndex
                        )

                    Keys.onEnterPressed:
                        launcher.launch(
                            launcher.selectedIndex
                        )

                    // =================================================
                    // ESC
                    // =================================================

                    Keys.onEscapePressed:
                        launcher.visible = false
                }
            }
        }

        // ========================================================
        // GRADE DE APLICAÇÕES
        // ========================================================

        GridView {
            id: applicationGrid

            x:
                archLauncher.gridHorizontalMargin

            y:
                searchBox.y +
                searchBox.height +
                archLauncher.gridTopMargin

            width:
                parent.width -
                archLauncher.gridHorizontalMargin * 2

            height:
                parent.height -
                y -
                archLauncher.gridBottomMargin

            clip:
                true

            cellWidth:
                archLauncher.gridItemWidth +
                archLauncher.gridSpacingHorizontal

            cellHeight:
                archLauncher.gridItemHeight +
                archLauncher.gridSpacingVertical

            model:
                applicationModel

            ScrollBar.vertical:
                ScrollBar {
                    policy:
                        ScrollBar.AsNeeded
                }

            delegate:
                Item {

                    width:
                        applicationGrid.cellWidth

                    height:
                        applicationGrid.cellHeight

                    property int modelIndex:
                        index

                    Rectangle {
                        anchors.centerIn:
                            parent

                        width:
                            archLauncher.gridItemWidth

                        height:
                            archLauncher.gridItemHeight

                        radius:
                            12

                        color:
                            modelIndex ===
                            launcher.selectedIndex
                            ? archLauncher.applicationSelectedBackground
                            : itemMouseArea.containsMouse
                            ? archLauncher.applicationHoverBackground
                            : "transparent"

                        border.width:
                            modelIndex ===
                            launcher.selectedIndex
                            ? archLauncher.selectedBorderWidth
                            : 0

                        border.color:
                            archLauncher.applicationSelectedBorder

                        Behavior on color {
                            ColorAnimation {
                                duration:
                                    90
                            }
                        }

                        Column {
                            anchors.centerIn:
                                parent

                            spacing:
                                archLauncher.applicationIconTextSpacing

                            Image {
                                width:
                                    archLauncher.applicationIconSize

                                height:
                                    archLauncher.applicationIconSize

                                anchors.horizontalCenter:
                                    parent.horizontalCenter

                                source:
                                    Quickshell.iconPath(
                                        modelData.icon,
                                        ""
                                    )

                                fillMode:
                                    Image.PreserveAspectFit

                                smooth:
                                    true
                            }

                            Text {
                                width:
                                    archLauncher.applicationNameMaximumWidth

                                horizontalAlignment:
                                    Text.AlignHCenter

                                text:
                                    modelData.name

                                color:
                                    archLauncher.applicationTextColor

                                font.family:
                                    archLauncher.fontFamily

                                font.pixelSize:
                                    archLauncher.applicationNameFontSize

                                elide:
                                    Text.ElideRight

                                maximumLineCount:
                                    1
                            }
                        }

                        // =================================================
                        // MOUSE
                        // =================================================

                        MouseArea {
                            id: itemMouseArea

                            anchors.fill:
                                parent

                            hoverEnabled:
                                true

                            acceptedButtons:
                                Qt.LeftButton

                            onEntered: {

                                launcher.selectedIndex =
                                    modelIndex
                            }

                            onClicked: {

                                launcher.selectedIndex =
                                    modelIndex

                                launcher.visible =
                                    false

                                modelData.execute()
                            }
                        }
                    }
                }
        }

        // ========================================================
        // LIMPEZA DO FOCO
        // ========================================================

        onVisibleChanged: {

            if (!visible) {

                searchInput.clearFocus()
            }
        }
    }
}
