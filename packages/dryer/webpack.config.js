const path    = require("path")
const webpack = require("webpack")
const workspace = "dryer"

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: `../../app/javascript/${workspace}/application.js`
  },
  output: {
    filename: `${workspace}.js`,
    sourceMapFilename: `${workspace}.map`,
    path: path.resolve(__dirname, "../../app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
}
