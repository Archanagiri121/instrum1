import QtQuick 2.15
import QtQuick.Controls 2.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import ICMain

Item {

    property var currentStartPoint: QtPositioning.coordinate(18.53262097340008, 73.87666927743692)
    property var endPoint: QtPositioning.coordinate(18.519346774874595, 73.8545525557375)
    property real radiusForTransparentRect: 60
    property real zoomLevelOfMap: 18
    property real tiltOfMap: 60
    property real widthAndHeightOfImage: 50
    property real widthOfRectOnMap: 350
    property real heightOfRectOnMap: 30
    property real radiusOfRectOnMap: 20
    property real currentSegmentIndex: 0
    property real currentCoordinateIndex: 0
    property var routeSegments: []
    property real totalRouteDistance: 0
    property real remainingDistance: 0
    property string currentManeuver: "Continue"
    property bool maneuverPassed : false
    property real islivespeed: speedoMeterComponent.currentSpeed


    Rectangle {
        id: transparentRect
        width: parent.width
        height: parent.height
        radius: radiusForTransparentRect
        border.color: Styles.redColor
        border.width: 2
        smooth: true
        visible: true
    }

    Rectangle {
        id: rectMap
        width: transparentRect.width
        height: transparentRect.height
        radius: transparentRect.radius
        anchors.centerIn: parent
        border.color: Styles.transparentColor
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: transparentRect
            source: rectMap
        }

        Plugin {
            id: mapPlugin
            name: "osm"
            PluginParameter {
                name: "osm.mapping.custom.host"
                value: "https://tile.openstreetmap.org/"
            }
        }

        RouteQuery {
            id: routeQuery
            waypoints: [
                currentStartPoint,
                endPoint
            ]
        }

        RouteModel {
            id: routeModel
            plugin: mapPlugin
            query: routeQuery
            autoUpdate: true

            onStatusChanged: {
                if (status === RouteModel.Ready) {
                    var route = routeModel.get(0);
                    var totalDistance = route.distance;
                    totalRouteDistance = totalDistance;
                    remainingDistance = totalDistance;
                    distanceText.text = "Total Distance: " + (remainingDistance / 1000).toFixed(2) + " km";
                    routeDetailsModel.clear();

                    startMarkerMovement(route.segments);
                }
            }
        }

        ListModel {
            id: routeDetailsModel
        }

        ListModel {
            id: routeSegmentsModel
        }

        Map {
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: startPointMarker.coordinate
            copyrightsVisible: false
            activeMapType: mapView.supportedMapTypes[mapView.supportedMapTypes.length - 1]
            zoomLevel: zoomLevelOfMap
            tilt: tiltOfMap
            bearing: 0

            PinchHandler {
                target: mapView
                onActiveChanged: if (active) {
                                     mapView.startCentroid = mapView.toCoordinate(pinch.centroid.position, false)
                                 }
                onScaleChanged: (delta) => {
                                    mapView.zoomLevel += Math.log2(delta);
                                    mapView.alignCoordinateToPoint(mapView.startCentroid, pinch.centroid.position);
                                }
                grabPermissions: PointerHandler.TakeOverForbidden
            }

            WheelHandler {
                target: mapView
                acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                                 ? PointerDevice.Mouse | PointerDevice.TouchPad
                                 : PointerDevice.Mouse
                rotationScale: 1 / 120
                property: "zoomLevel"
            }

            DragHandler {
                target: mapView
                onTranslationChanged: (delta) => mapView.pan(-delta.x, -delta.y)
            }

            MapItemView {
                model: routeSegmentsModel
                delegate: MapPolyline {
                    path: [
                        QtPositioning.coordinate(model.segmentStartLat, model.segmentStartLng),
                        QtPositioning.coordinate(model.segmentEndLat, model.segmentEndLng)
                    ]
                    line.width: 5
                    line.color: model.isTraversed ? Styles.grayColor : Styles.gradientBlue
                }
            }

            MapQuickItem {
                id: startPointMarker
                coordinate: currentStartPoint
                anchorPoint.x: carImg.width / 2
                anchorPoint.y: carImg.height
                sourceItem: Image {
                    id: carImg
                    source: "assets/Image/Car.png"
                    width: widthAndHeightOfImage
                    height: widthAndHeightOfImage
                }
            }

            MapQuickItem {
                id: endPointMarker
                coordinate: endPoint
                anchorPoint.x: endPointImg.width / 2
                anchorPoint.y: endPointImg.height
                sourceItem: Image {
                    id: endPointImg
                    source: "assets/Image/Pin.png"
                    width: widthAndHeightOfImage
                    height: widthAndHeightOfImage
                }
            }

            Component.onCompleted: {
                routeModel.update();
            }

            Rectangle {
                id: directionRect
                width: widthOfRectOnMap
                height: heightOfRectOnMap * 2
                radius: radiusOfRectOnMap
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { color: Styles.gradientMid; position: 0.30 }
                    GradientStop { color: Styles.gradientEnd; position: 0.45 }
                    GradientStop { color: Styles.gradientEnd; position: 0.55 }
                    GradientStop { color: Styles.gradientMid; position: 0.70 }
                }

                anchors.horizontalCenter: parent.horizontalCenter

                RowLayout {
                    id: directionImgAndText
                    anchors {
                        centerIn: parent
                        fill: parent
                        leftMargin: 10
                        rightMargin: 10

                    }
                    Rectangle{
                        id:directionImgRect
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: parent.height
                        color: Styles.transparentColor

                        Image {
                            id: directionImg
                            source: ""
                            anchors{
                                fill: parent
                                centerIn: parent
                            }
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                    Rectangle{
                        id: maneuverTextRect
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: Styles.transparentColor
                        Text {
                            id: maneuverText
                            color: Styles.whiteColor
                            text: "Calculating maneuver..."
                            font {
                                family: Styles.txtFontFamily
                                pixelSize: Math.min(parent.width, parent.height) * 0.24
                                bold: true
                            }
                            anchors.fill: parent
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            Rectangle {
                id: maneuverRect
                width: widthOfRectOnMap
                height: heightOfRectOnMap
                radius: radiusOfRectOnMap
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { color: Styles.gradientMid; position: 0.30 }
                    GradientStop { color: Styles.gradientEnd; position: 0.45 }
                    GradientStop { color: Styles.gradientEnd; position: 0.55 }
                    GradientStop { color: Styles.gradientMid; position: 0.70 }
                }

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                }

                RowLayout {
                    spacing: 20
                    anchors.fill: parent
                    anchors{
                        centerIn: parent
                        leftMargin: 10
                        rightMargin: 10
                    }
                    Rectangle{
                        id: distanceTextRect
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: Styles.transparentColor
                        Text {
                            id: distanceText
                            color: Styles.whiteColor
                            anchors{
                                fill: parent
                            }
                            font {
                                family: Styles.txtFontFamily
                                pixelSize: Math.min(parent.width, parent.height) * 0.47
                                bold: true
                            }
                            text: "Calculating distance..."
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle{
                        id: navImgRect
                        Layout.preferredWidth: 33
                        Layout.preferredHeight: parent.height
                        color: Styles.transparentColor
                        Image {
                            id: navImg
                            source: "assets/Image/NavIcon.png"
                            anchors{
                                fill: parent
                                centerIn: parent
                            }
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                    Rectangle{
                        id: distanceTimeRect
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: Styles.transparentColor
                        Text {
                            id: distanceTime
                            color: Styles.whiteColor
                            anchors{
                                fill: parent
                            }
                            font {
                                family: Styles.txtFontFamily
                                pixelSize: Math.min(parent.width, parent.height) * 0.47
                                bold: true
                            }
                            text: "Calculating Time..."
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
    }


    Timer {
        id: animationTimer
        interval: islivespeed <= 25 ? 800 : 420
        repeat: true
        running: islivespeed == 0 ? false : true
        onTriggered: updateMarkerPosition()
    }

    PropertyAnimation {
        id: bearingAnimation
        target: mapView
        property: "bearing"
        duration: 200
        easing.type: Easing.Linear
    }

    PropertyAnimation {
        id: coordinateAnimation
        target: startPointMarker
        property: "coordinate"
        duration: animationTimer.interval === 800 ? 740 : 390
        easing.type: Easing.Linear
    }


    function startMarkerMovement(segments) {
        currentSegmentIndex = 0;
        currentCoordinateIndex = 0;
        routeSegments = segments;
        routeSegmentsModel.clear();

        for (var i = 0; i < segments.length; i++) {
            for (var j = 0; j < segments[i].path.length - 1; j++) {
                var distanceToNextInstruction = j < segments[i].path.length - 1 ? segments[i].path[j + 1].distanceTo(segments[i].path[j]) : 0;
                routeSegmentsModel.append({
                                              segmentStartLat: segments[i].path[j].latitude,
                                              segmentStartLng: segments[i].path[j].longitude,
                                              segmentEndLat: segments[i].path[j + 1].latitude,
                                              segmentEndLng: segments[i].path[j + 1].longitude,
                                              isTraversed: false,
                                              maneuver: segments[i].maneuver
                                          });
            }
        }

        updateManeuverDetails();
        animationTimer.start();
    }

    function getModelIndexForCoordinates(segmentIndex, coordinateIndex) {
        var index = 0;
        for (var i = 0; i < segmentIndex; i++) {
            index += routeSegments[i].path.length - 1;
        }
        return index + coordinateIndex - 1;
    }

    function updateMarkerPosition() {
        if (currentSegmentIndex < routeSegments.length) {
            var segment = routeSegments[currentSegmentIndex];
            var path = segment.path;

            if (currentCoordinateIndex < path.length - 1) {
                currentCoordinateIndex++;
                var newCoordinate = path[currentCoordinateIndex];
                var previousCoordinate = path[currentCoordinateIndex - 1];

                // Update coordinate animation
                coordinateAnimation.from = previousCoordinate;
                coordinateAnimation.to = newCoordinate;
                coordinateAnimation.start();

                // Update bearing animation
                var newBearing = calculateBearing(previousCoordinate, newCoordinate);
                bearingAnimation.from = mapView.bearing;
                bearingAnimation.to = newBearing;
                bearingAnimation.start();

                var modelIndex = getModelIndexForCoordinates(currentSegmentIndex, currentCoordinateIndex);
                if (modelIndex >= 0) {
                    routeSegmentsModel.setProperty(modelIndex, "isTraversed", true);
                }

                // Calculate remaining distance
                var distanceChange = Math.abs(previousCoordinate.distanceTo(newCoordinate));
                remainingDistance -= distanceChange;
                distanceText.text = "Distance: " + Math.abs(remainingDistance / 1000).toFixed(2) + " km";

                if (segment.maneuver || currentCoordinateIndex === segment.maneuver.position) {
                    maneuverPassed = true; // Set the flag when passing the maneuver point
                }

                // Calculate estimated time
                var speedKmPerMin = 0.46;
                var timeMinutes = Math.abs(remainingDistance / (speedKmPerMin * 1000));
                if (timeMinutes < 60) {
                    distanceTime.text = "In Time: " + timeMinutes.toFixed(1) + " min";
                } else {
                    var hours = Math.floor(timeMinutes / 60);
                    var minutes = timeMinutes % 60;
                    distanceTime.text = "In: " + hours + " hr. " + minutes.toFixed(0) + " min";
                }

                updateManeuverDetails();

            } else {
                currentSegmentIndex++;
                currentCoordinateIndex = 0;
                maneuverPassed = false;
                updateManeuverDetails();
            }
        } else {
            animationTimer.stop();
            maneuverText.text = "Arrived at destination!";
        }
    }

    function updateManeuverDetails() {
        if (currentSegmentIndex < routeSegments.length) {
            var segment = routeSegments[currentSegmentIndex];
            if (segment.maneuver) {
                var distanceToNextInstruction = calculateDistanceToNextInstruction();
                if (maneuverPassed) {
                    maneuverText.text = "Continue straight. Next instruction in " + distanceToNextInstruction.value.toFixed(2) + " " + distanceToNextInstruction.unit;
                    directionImg.source = "assets/Image/Straight.png";
                } else {
                    currentManeuver = segment.maneuver.instructionText;
                    maneuverText.text = currentManeuver + " Next instruction in " + distanceToNextInstruction.value.toFixed(2) + " " + distanceToNextInstruction.unit;
                    directionImg.source = getDirectionImage(segment.maneuver.direction);
                }
            }
        } else {
            maneuverText.text = "Arrived at destination!";
            directionImg.source = "assets/Image/Straight.png";
        }
    }

    function calculateDistanceToNextInstruction() {
        var distanceToNextInstruction = 0;
        var segment = routeSegments[currentSegmentIndex];
        for (var i = currentCoordinateIndex; i < segment.path.length - 1; i++) {
            distanceToNextInstruction += segment.path[i].distanceTo(segment.path[i + 1]);
        }
        if (distanceToNextInstruction < 1000) {
            return { value: distanceToNextInstruction, unit: "meters" };
        } else {
            return { value: distanceToNextInstruction / 1000, unit: "kilometers" };
        }
    }


    function calculateBearing(start, end) {
        var startLat = start.latitude * Math.PI / 180.0;
        var startLng = start.longitude * Math.PI / 180.0;
        var endLat = end.latitude * Math.PI / 180.0;
        var endLng = end.longitude * Math.PI / 180.0;

        var dLng = endLng - startLng;

        var y = Math.sin(dLng) * Math.cos(endLat);
        var x = Math.cos(startLat) * Math.sin(endLat) - Math.sin(startLat) * Math.cos(endLat) * Math.cos(dLng);

        var bearing = Math.atan2(y, x);
        bearing = bearing * 180.0 / Math.PI;

        return (bearing + 360.0) % 360.0;
    }

    function calculateRemainingDistance(currentIndex, currentCoordinate) {
        var distance = 0;
        for (var i = currentIndex; i < routeSegmentsModel.count; i++) {
            var segment = routeSegmentsModel.get(i);
            var segmentStart = QtPositioning.coordinate(segment.segmentStartLat, segment.segmentStartLng);
            var segmentEnd = QtPositioning.coordinate(segment.segmentEndLat, segment.segmentEndLng);

            if (i === currentIndex) {
                distance += currentCoordinate.distanceTo(segmentEnd);
            } else {
                distance += segmentStart.distanceTo(segmentEnd);
            }
        }
        return distance;
    }

    function getDirectionImage(direction) {
        switch (direction) {
        case 0: return "assets/Image/Straight.png";
        case 1: return "assets/Image/Straight.png";
        case 2: return "assets/Image/slightRight.png";
        case 3: return "assets/Image/slightRight.png";
        case 4: return "assets/Image/turnRight.png";
        case 5: return "assets/Image/turnRight.png";
        case 6: return "assets/Image/uturnLeft.png";
        case 7: return "assets/Image/uturnRight.png";
        case 8: return "assets/Image/turnLeft.png";
        case 9: return "assets/Image/turnLeft.png";
        case 10: return "assets/Image/slightLeft.png";
        case 11: return "assets/Image/slightLeft.png";
        default: return "assets/Image/Straight.png";
        }
    }
}
