var img2base64 = function(fileId, urlId, imgHerfId, imgBoxId) {
	this.fileId = fileId;
	this.urlId = urlId;
	this.imgHerfId = imgHerfId;
	this.imgBoxId = imgBoxId;

	var fileInput = document.getElementById(fileId);

	// 用于压缩图片的canvas
	var canvas = document.createElement("canvas");
	var ctx = canvas.getContext('2d');
	// 瓦片canvas
	var tCanvas = document.createElement("canvas");
	var tctx = tCanvas.getContext("2d");

	var maxsize = 500 * 1024;

	var imgs = [];

	if (fileInput) {
		fileInput.onchange = function() {
			if (!this.files.length)
				return;
			var files = Array.prototype.slice.call(this.files);
			if (!fileInput.multiple) {
				var file = files[0];
				var reader = new FileReader();
				reader.onload = function() {
					var result = this.result;
					var img = new Image();
					img.src = result;
					if (result.length <= maxsize) {
						img = null;
						updateImgUrl(result);
						return;
					}
					if (img.complete) {
						callback();
					} else {
						img.onload = callback;
					}
					function callback() {
						var data = compress(img);
						updateImgUrl(data);
						img = null;
					}
				}
				reader.readAsDataURL(file);
			} else {
				imgs = []
				$.each(files, function(i, file) {
					var reader = new FileReader();
					reader.onload = function() {
						var result = this.result;
						var img = new Image();
						img.src = result;
						if (result.length <= maxsize) {
							img = null;
							updateImgUrls(result);
							return;
						}
						if (img.complete) {
							callback();
						} else {
							img.onload = callback;
						}
						function callback() {
							var data = compress(img);
							updateImgUrls(data);
							img = null;
						}
					}
					reader.readAsDataURL(file);
				});
			}
		}
	}

	function compress(img) {
		var initSize = img.src.length;
		var width = img.width;
		var height = img.height;
		// 如果图片大于四百万像素，计算压缩比并将大小压至400万以下
		var ratio;
		if ((ratio = width * height / 4000000) > 1) {
			ratio = Math.sqrt(ratio);
			width /= ratio;
			height /= ratio;
		} else {
			ratio = 1;
		}
		canvas.width = width;
		canvas.height = height;
		// 铺底色
		ctx.fillStyle = "#fff";
		ctx.fillRect(0, 0, canvas.width, canvas.height);
		// 如果图片像素大于100万则使用瓦片绘制
		var count;
		if ((count = width * height / 1000000) > 1) {
			count = ~~(Math.sqrt(count) + 1); // 计算要分成多少块瓦片
			// 计算每块瓦片的宽和高
			var nw = ~~(width / count);
			var nh = ~~(height / count);
			tCanvas.width = nw;
			tCanvas.height = nh;
			for ( var i = 0; i < count; i++) {
				for ( var j = 0; j < count; j++) {
					tctx.drawImage(img, i * nw * ratio, j * nh * ratio, nw * ratio, nh * ratio, 0, 0, nw, nh);
					ctx.drawImage(tCanvas, i * nw, j * nh, nw, nh);
				}
			}
		} else {
			ctx.drawImage(img, 0, 0, width, height);
		}
		// 进行最小压缩
		var ndata = canvas.toDataURL('image/jpeg', 0.8);
		console.log('压缩前：' + initSize);
		console.log('压缩后：' + ndata.length);
		console.log('压缩率：' + ~~(100 * (initSize - ndata.length) / initSize) + "%");
		tCanvas.width = tCanvas.height = canvas.width = canvas.height = 0;
		return ndata;
	}

	function updateImgUrl(data) {
		$("#" + urlId).val(data);
		if ($("#" + imgHerfId).length > 0) {
			$("#" + imgBoxId).attr("href", data).show();
			$("#" + imgHerfId).attr("src", data);
		}
	}

	function updateImgUrls(data) {
		imgs.push(data);
		$("#" + urlId).val(imgs.join(";;"));
	}
}



var img2base64MutiImg = function(fileId, urlId, imgHerfId, imgBoxId) {
	this.fileId = fileId;
	this.urlId = urlId;
	this.imgHerfId = imgHerfId;
	this.imgBoxId = imgBoxId;

	var fileInput = document.getElementById(fileId);

	// 用于压缩图片的canvas
	var canvas = document.createElement("canvas");
	var ctx = canvas.getContext('2d');
	// 瓦片canvas
	var tCanvas = document.createElement("canvas");
	var tctx = tCanvas.getContext("2d");

	var maxsize = 500 * 1024;

	var imgs = [];

	if (fileInput) {
		fileInput.onchange = function() {
			if (!this.files.length)
				return;
			var files = Array.prototype.slice.call(this.files);
			if (!fileInput.multiple) {
				var file = files[0];
				var reader = new FileReader();
				reader.onload = function() {
					var result = this.result;
					var img = new Image();
					img.src = result;
					if (result.length <= maxsize) {
						img = null;
						updateImgUrl(result);
						return;
					}
					if (img.complete) {
						callback();
					} else {
						img.onload = callback;
					}
					function callback() {
						var data = compress(img);
						updateImgUrl(data);
						img = null;
					}
				}
				reader.readAsDataURL(file);
			} else {
				imgs = []
				$.each(files, function(i, file) {
					var reader = new FileReader();
					reader.onload = function() {
						var result = this.result;
						var img = new Image();
						img.src = result;
						if (result.length <= maxsize) {
							img = null;
							updateImgUrls(result);
							return;
						}
						if (img.complete) {
							callback();
						} else {
							img.onload = callback;
						}
						function callback() {
							var data = compress(img);
							updateImgUrls(data);
							img = null;
						}
					}
					reader.readAsDataURL(file);
				});
			}
		}
	}

	function compress(img) {
		var initSize = img.src.length;
		var width = img.width;
		var height = img.height;
		// 如果图片大于四百万像素，计算压缩比并将大小压至400万以下
		var ratio;
		if ((ratio = width * height / 4000000) > 1) {
			ratio = Math.sqrt(ratio);
			width /= ratio;
			height /= ratio;
		} else {
			ratio = 1;
		}
		canvas.width = width;
		canvas.height = height;
		// 铺底色
		ctx.fillStyle = "#fff";
		ctx.fillRect(0, 0, canvas.width, canvas.height);
		// 如果图片像素大于100万则使用瓦片绘制
		var count;
		if ((count = width * height / 1000000) > 1) {
			count = ~~(Math.sqrt(count) + 1); // 计算要分成多少块瓦片
			// 计算每块瓦片的宽和高
			var nw = ~~(width / count);
			var nh = ~~(height / count);
			tCanvas.width = nw;
			tCanvas.height = nh;
			for ( var i = 0; i < count; i++) {
				for ( var j = 0; j < count; j++) {
					tctx.drawImage(img, i * nw * ratio, j * nh * ratio, nw * ratio, nh * ratio, 0, 0, nw, nh);
					ctx.drawImage(tCanvas, i * nw, j * nh, nw, nh);
				}
			}
		} else {
			ctx.drawImage(img, 0, 0, width, height);
		}
		// 进行最小压缩
		var ndata = canvas.toDataURL('image/jpeg', 0.8);
		console.log('压缩前：' + initSize);
		console.log('压缩后：' + ndata.length);
		console.log('压缩率：' + ~~(100 * (initSize - ndata.length) / initSize) + "%");
		tCanvas.width = tCanvas.height = canvas.width = canvas.height = 0;
		return ndata;
	}

	function updateImgUrl(data) {
		$(urlId).val(data);
		if ($(imgHerfId).length > 0) {
			$(imgBoxId).attr("href", data).show();
			$(imgHerfId).attr("src", data);
		}
	}

	function updateImgUrls(data) {
		imgs.push(data);
		$(urlId).val(imgs.join(";;"));
	}
}
