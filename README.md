ui-leaflet-draw
==============

[![Dependencies](https://david-dm.org/angular-ui/ui-leaflet-draw.png)](https://david-dm.org/angular-ui/ui-leaflet-draw)&nbsp;
[![Dependencies](https://david-dm.org/angular-ui/ui-leaflet-draw.png)](https://david-dm.org/angular-ui/ui-leaflet-draw)&nbsp;
[![Build Status](https://travis-ci.org/angular-ui/ui-leaflet-draw.png?branch=master)](https://travis-ci.org/angular-ui/ui-leaflet-draw)


### Purpose:

To extend ui-leaflet directives to add [Leaflet.Draw](https://github.com/michaelguild13/Leaflet.draw).

### Basic use:

In general the main goal of this direcitve to bind an attribute `lf-draw` within the leaflet directive to a field which
represent [Leaflet.Draw options](https://github.com/michaelguild13/Leaflet.draw#options).

Follows the same event driven architecture of `leafletDirectiveDraw[someEvent]` being fired from root scope. The events are
[here](https://github.com/michaelguild13/Leaflet.draw#events).

### API

For basic use it is described in a enough extent in [Basic use](#basic-use).

### Unique Options

- **options.control** - (*note: this will probably go away infavor of leafletData*)

  - **promised(promise)**:
    - **promise**: **type:** Promise which resolves:
      - **type** object
        - **control:** drawControl leaflet object
        - **map:**: leaflet map instance

### Full Example
- [code](./index.html)
- [hosted](http://angular-ui.github.io/ui-leaflet-draw)
