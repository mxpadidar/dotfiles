import QtQuick
import Quickshell.Services.UPower

BarButton {
    id: batteryButton
    readonly property var battery: UPower.displayDevice
    readonly property int percent: Math.round(Math.max(0, Math.min(1, battery.percentage)) * 100)
    readonly property bool pluggedIn: !UPower.onBattery
    readonly property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property bool full: battery.state === UPowerDeviceState.FullyCharged || percent === 100
    readonly property string levelIcon: percent <= 10 ? "\uf244"
        : percent <= 35 ? "\uf243"
        : percent <= 60 ? "\uf242"
        : percent <= 85 ? "\uf241" : "\uf240"

    visible: battery.ready && battery.isLaptopBattery && battery.isPresent
    interactive: false
    width: pluggedIn ? 92 : 76
    glyph: (pluggedIn ? (charging ? "\uf0e7 " : "\uf1e6 ") : "") + levelIcon
    text: percent + "%"
    foreground: full ? "#41a6b5"
        : charging ? "#7dcfff"
        : pluggedIn ? "#bb9af7"
        : percent <= 10 ? "#f7768e"
        : percent <= 20 ? "#e0af68" : "#a9b1d6"
    tooltip: (full ? "Fully charged" : charging ? "Charging"
        : pluggedIn ? "Plugged in — not charging" : "Running on battery") + " · " + percent + "%"
}
