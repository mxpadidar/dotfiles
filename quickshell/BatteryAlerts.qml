import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "BatteryAlerts.js" as Alerts

QtObject {
    id: root
    readonly property var battery: UPower.displayDevice
    readonly property real percent: battery.percentage * 100
    readonly property bool pluggedIn: !UPower.onBattery
    readonly property bool ready: battery.ready && battery.isLaptopBattery && battery.isPresent
    property var warnings: ({ low: false, critical: false })

    function check() {
        if (!ready || !warnings || !Number.isFinite(percent)) return;
        const next = Alerts.update(warnings, percent, pluggedIn);
        warnings = { low: next.low, critical: next.critical };
        if (!next.alert) return;
        const critical = next.alert === "critical";
        Quickshell.execDetached([
            "notify-send", "--app-name=Battery", "--icon=battery-caution",
            critical ? "--urgency=critical" : "--urgency=normal",
            critical ? "Battery critically low" : "Battery low",
            Math.round(percent) + "% remaining. Connect your charger."
        ]);
        if (critical)
            Quickshell.execDetached(["pw-play", "/usr/share/sounds/freedesktop/stereo/dialog-warning.oga"]);
    }
    onPercentChanged: check()
    onPluggedInChanged: check()
    onReadyChanged: check()
    Component.onCompleted: check()
}
