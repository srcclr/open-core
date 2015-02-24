export default {
  get: function(url, params) {
    if (params) {
      var keys = Object.keys(params),
      encoded = [];

      keys.forEach(function(p) {
        var value = params[p];

        if (typeof value !== 'undefined') {
          encoded.push(p + "=" + value);
        }
      });

      if (encoded.length > 0) {
        url += "?" + encoded.join('&');
      }
    }

    return url;
  }
};
