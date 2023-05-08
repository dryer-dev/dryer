const path      = require("path")
const webpack   = require("webpack")
const workspace = "dryer"

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: `../../app/javascript/${workspace}/application.js`
  },
  output: {
    filename: `app.js`,
    sourceMapFilename: `app.map`,
    path: path.resolve(__dirname, `../../app/assets/builds/${workspace}`),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
}
