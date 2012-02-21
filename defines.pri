DESTDIR = $$PWD/bin
OBJECTS_DIR = $$PWD/build
MOC_DIR = $$PWD/build
RCC_DIR = $$PWD/build
UI_DIR = $$PWD/build
VERSION = 1.1.8

# Please read BUILD information #
#DEFINES += NO_SYSTEM_DATAPATH
#DEFINES += USE_WEBGL
#DEFINES += KDE
#DEFINES += PORTABLE_BUILD
win32 {
    DEFINES += W7API
    LIBS += User32.lib Ole32.lib Shell32.lib ShlWapi.lib Gdi32.lib ComCtl32.lib
}

DEFINES += QT_NO_URL_CAST_FROM_STRING

##It won't compile on windows with this define. Some bug in qtsingleapp / qvector template
!win32: !CONFIG(debug, debug|release): DEFINES += QT_NO_DEBUG_OUTPUT

d_no_system_datapath = $$(NO_SYSTEM_DATAPATH)
d_use_webgl = $$(USE_WEBGL)
d_w7api = $$(W7API)
d_kde = $$(KDE)
d_portable = $$(PORTABLE_BUILD)

equals(d_no_system_datapath, "true") { DEFINES += NO_SYSTEM_DATAPATH }
equals(d_use_webgl, "true") { DEFINES += USE_WEBGL }
equals(d_w7api, "true") { DEFINES += W7API }
equals(d_kde, "true") { DEFINES += KDE }
equals(d_portable, "true") { DEFINES += PORTABLE_BUILD }

!mac:unix {
    d_prefix = $$(QUPZILLA_PREFIX)
    binary_folder = /usr/bin
    library_folder = /usr/lib
    data_folder = /usr/share/qupzilla
    launcher_folder = /usr/share/applications
    icon_folder = /usr/share/pixmaps
    hicolor_folder = /usr/share/icons/hicolor

    !equals(d_prefix, "") {
        binary_folder = "$$d_prefix"bin
        library_folder = "$$d_prefix"lib
        data_folder = "$$d_prefix"share/qupzilla
        launcher_folder = "$$d_prefix"share/applications
        icon_folder = "$$d_prefix"share/pixmaps
        hicolor_folder = "$$d_prefix"share/icons/hicolor
    }

    DEFINES += USE_DATADIR=\\\"""$$data_folder/"\\\""

    #Git revision
    rev = $$system(sh $$PWD/scripts/getrevision.sh)
    !equals(rev, ""): DEFINES += GIT_REVISION=\\\"""$$rev"\\\""
}