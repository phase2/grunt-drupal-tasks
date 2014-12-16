module.exports = {

  expandUrls: function(baseUrl, paths) {
	return paths.map(function(value, index, arr) {
		return baseUrl + value;
  	});
  }

}
