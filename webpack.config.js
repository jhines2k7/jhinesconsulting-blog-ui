const path = require('path');
const webpack = require("webpack");

module.exports = {
    context: path.resolve(__dirname, "src"),
    entry: './main.js',
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: 'bundle.js'
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