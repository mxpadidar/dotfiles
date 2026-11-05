.pragma library

function update(previous, percent, pluggedIn) {
    let low = previous.low;
    let critical = previous.critical;
    if (percent >= 25) {
        low = false;
        critical = false;
    }
    let alert = "";
    if (!pluggedIn) {
        if (percent <= 10 && !critical) {
            low = true;
            critical = true;
            alert = "critical";
        } else if (percent <= 20 && !low) {
            low = true;
            alert = "low";
        }
    }
    return { low: low, critical: critical, alert: alert };
}
