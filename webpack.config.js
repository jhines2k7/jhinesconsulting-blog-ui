const path = require('path');
const webpack = require("webpack");

module.exports = {
    entry: {
        'bundle.js': './.tmp/main.js'
    },
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: '[name]'
    },
    module: {
        noParse: /node_modules\/localforage\/dist\/localforage.js/,
        loaders: [{
            loader: "babel-loader",
            query: {
                presets: ["es2015-loose"]
            }
        }]
    },
    plugins: [
        new webpack.ProvidePlugin({
            riot: "riot/riot"
        })
    ],
    stats: {
        colors: true
    },
    devtool: 'source-map'
};