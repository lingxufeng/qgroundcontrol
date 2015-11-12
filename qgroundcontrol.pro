# -------------------------------------------------
# QGroundControl - Micro Air Vehicle Groundstation
# Please see our website at <http://qgroundcontrol.org>
# Maintainer:
# Lorenz Meier <lm@inf.ethz.ch>
# (c) 2009-2015 QGroundControl Developers
# This file is part of the open groundstation project
# QGroundControl is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# QGroundControl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with QGroundControl. If not, see <http://www.gnu.org/licenses/>.
# -------------------------------------------------

exists($${OUT_PWD}/qgroundcontrol.pro) {
    error("You must use shadow build.")
}

message(Qt version $$[QT_VERSION])

!equals(QT_MAJOR_VERSION, 5) | !greaterThan(QT_MINOR_VERSION, 3) {
    error("Unsupported Qt version, 5.4+ is required")
}

ios {
    #-- Qmake can't handle a project within a project when generating
    #   an Xcode project. You end up with one project for the app and
    #   nothing for the location plugin.
    include($$PWD/src/QtLocationPlugin/QGCLocationPlugin.pro)
    include($$PWD/QGCApplication.pro)
} else {
    #-- The rest (make files or Visual Studio projects) works. Note
    #   that by default, we're using make files for Mac OS too. If
    #   you want an Xcode project, the same above applies.
    TEMPLATE =  subdirs
    SUBDIRS  =  ./src/QtLocationPlugin/QGCLocationPlugin.pro
    SUBDIRS +=  ./QGCApplication.pro
    QGCApplication.depends = QGCLocationPlugin
}
