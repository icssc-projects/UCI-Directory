# UCI-Directory

Demo app used in iOS Workshop on Nov 6, 2015 by Edward Xia.

# Download

``` sh
git clone --recursive https://github.com/ICSSC/UCI-Directory.git
```

If you forget "--recursive":

``` sh
git submodule sync
git submodule update --init
```

# Install Dependencies

NodeJS is required for the server app.

``` sh
cd Server
npm install
npm install coffee-script -g
```

# Start Server

``` sh
cd Server
coffee server.coffee
```

Note: server requires on campus network or UCI VPN.

# Build and Run the app

Open "UCI Directory.xcodeproj" and build.

# Play!

This app is build in a single afternoon, so code may be hacky.
