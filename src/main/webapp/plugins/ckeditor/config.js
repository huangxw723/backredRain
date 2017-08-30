/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights
 *          reserved. For licensing, see LICENSE.md or
 *          http://ckeditor.com/license
 */
 


CKEDITOR.editorConfig = function(config) {
	
	serverHost = '';
	imgApi = 'yp/admin/message/convertImg.do';
	$.ajax({
		url:"yp/admin/message/getServerHost.do",
		dataType:'json',
		complete:function(data){
			serverHost = data.responseText;
			config.filebrowserImageUploadUrl = serverHost + imgApi;
		}
	})
	
	config.filebrowserImageUploadUrl = serverHost + imgApi;
	config.image_previewText = ' ';
	config.width = 500;
	config.height = 400;
	config.toolbarCanCollapse = true;
	config.toolbarGroups = [ {
		name : 'document',
		groups : [ 'mode', 'document', 'doctools' ]
	}, {
		name : 'clipboard',
		groups : [ 'clipboard', 'undo' ]
	}, {
		name : 'editing',
		groups : [ 'find', 'selection', 'spellchecker', 'editing' ]
	}, {
		name : 'forms',
		groups : [ 'forms' ]
	}, {
		name : 'basicstyles',
		groups : [ 'basicstyles', 'cleanup' ]
	}, {
		name : 'paragraph',
		groups : [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ]
	}, {
		name : 'links',
		groups : [ 'links' ]
	}, {
		name : 'insert',
		groups : [ 'insert' ]
	}, {
		name : 'styles',
		groups : [ 'styles' ]
	}, {
		name : 'colors',
		groups : [ 'colors' ]
	}, {
		name : 'tools',
		groups : [ 'tools' ]
	}, {
		name : 'others',
		groups : [ 'others' ]
	}, {
		name : 'about',
		groups : [ 'about' ]
	} ];
	config.removeButtons = 'Print,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Blockquote,CreateDiv,About,Language,BidiLtr,BidiRtl,Anchor,Unlink,Link,Flash,PageBreak,Iframe';
};
