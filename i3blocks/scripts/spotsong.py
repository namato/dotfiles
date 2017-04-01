#!/usr/bin/env python

import dbus
session_bus = dbus.SessionBus()
spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify",
                                     "/org/mpris/MediaPlayer2")
spotify_properties = dbus.Interface(spotify_bus,
                                    "org.freedesktop.DBus.Properties")
metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")

print metadata['xesam:artist'][0], " - ", metadata['xesam:title']

# The property Metadata behaves like a python dict
#for key, value in metadata.items():
#    print key, value

# To just print the title
#print metadata['xesam:title']
