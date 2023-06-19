module.exports = {
  multipass: true,
  plugins: [
    // remove DOCTYPE declaration
    'removeDoctype',
    // remove XML processing instructions
    'removeXMLProcInst',
    // remove comments
    'removeComments',
    // remove <metadata>
    'removeMetadata',
    // remove editors namespaces, elements and attributes
    'removeEditorsNSData',
    {
      // sort element attributes for epic readability
      name: 'sortAttrs',
      params: {
        order: [
          'id',
          'fill', 'stroke', 'opacity',
          'style', 'class',
          'width', 'height',
          'x', 'x1', 'x2',
          'y', 'y1', 'y2',
          'cx', 'cy',
          'rx', 'ry', 'r',
          'transform',
          'marker',
          'points',
          'd',
        ]
      }
    },
    // cleanup attributes values from newlines, trailing and repeating spaces
    'cleanupAttrs',
    /**
     * {
     *   // remove unused IDs
     *   name: 'cleanupIDs',
     *   params: {
     *     minify: false,
     *     preserve: ['current-color-scheme']
     *   }
     * },
     */
    // remove raster images references in <image>
    'removeRasterImages',
    // remove elements in <defs> without id
    'removeUselessDefs',
    {
      // round numeric values to the fixed precision
      // remove default 'px' units
      // y="749.936002px" --> y="749.936"
      name: 'cleanupNumericValues',
      params: { convertToPx: false }
    },
    {
      // round list of values to the fixed precision
      // viewBox="0 0 16px 16px" --> viewBox="0 0 16 16"
      name: 'cleanupListOfValues',
      params: {
        floatPrecision: 2,
        leadingZero: true,
        defaultPx: true,
        convertToPx: false,
      }
    },
    {
      // convert different colors formats to #rrggbb
      name: 'convertColors',
      params: {
        shorthex: false,
        shortname: false,
      }
    },
    /**
     * {
     *   // remove unknown elements content and attributes
     *   // don't touch attributes with default values
     *   name: 'removeUnknownsAndDefaults',
     *   params: { defaultAttrs: false }
     * },
     */
    // remove viewBox attr which coincides with a width/height box
    'removeViewBox',
    // remove or cleanup enable-background attribute when possible
    'cleanupEnableBackground',
    {
      // remove hidden elements (zero sized, with absent attributes)
      name: 'removeHiddenElems',
      params: { opacity0: false }
    },
    // remove empty <text/>, <tspan/>, and <tref xlink:href=""/> elements
    'removeEmptyText',
    // convert non-eccentric <ellipse> to <circle>
    'convertEllipseToCircle',
    // remove attributes with empty values
    'removeEmptyAttrs',
    // remove empty containers
    'removeEmptyContainers',
    // remove unused namespaces declaration
    'removeUnusedNS',
    // remove <title>
    'removeTitle',
    // remove <desc>
    'removeDesc',
    // remove elements that are drawn outside of the viewbox
    // 'removeOffCanvasPaths',
  ],

  // configure the indent (default 4 spaces) used by `--pretty` here:
  // @see https://github.com/svg/svgo/blob/master/lib/svgo/js2svg.js#L6 for more config options
  js2svg: {
    pretty: true,
    indent: 1
  }
}
