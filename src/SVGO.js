var SVGO = require('svgo');

exports.svgo_ = function(config) {
  return new SVGO(config);
}

exports.optimize_ = function(source, svgo) {
  return svgo.optimize(source).then(function(res) {
    return res.data;
  });
}
