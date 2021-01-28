const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
    mode: 'development',
    entry: {
        site: ['./assets/javascripts/site.js'],
        particles: ['./assets/javascripts/particles.js'],
        style: ['./assets/stylesheets/site.css.scss'],
    },
    output: {
        path: path.resolve(__dirname, '.tmp/dist'),
        filename: '[name].min.js',
    },
    performance: {
        hints: false
    },
    module: {
        rules: [{
            test: /\.m?js$/,
            exclude: /(node_modules)/,
            loader: 'babel-loader'
        }, {
            test: /\.(sa|sc|c)ss$/,
            use: [
                MiniCssExtractPlugin.loader,
                'css-loader',
                'sass-loader',
                {
                    loader: "postcss-loader",
                    options: {
                        postcssOptions: {
                            plugins: [
                                [
                                    require('autoprefixer')
                                ],
                            ],
                        },
                    },
                },
            ],
        }]
    },
    plugins: [new MiniCssExtractPlugin()],
};