pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string datetime_format: "d/M/yyyy - hh:mm"
  readonly property string time: {
    Qt.formatDateTime(clock.date, datetime_format)
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

}
