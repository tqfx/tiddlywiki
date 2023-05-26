/*\
title: $:/core/modules/widgets/code.js
type: application/javascript
module-type: widget

Code widget

\*/
(function() {

/*jslint node: true, browser: true */
/*global $tw: false */
"use strict";

var Widget = require("$:/core/modules/widgets/widget.js").widget;

var CodeWidget = function(parseTreeNode, options) {
	this.initialise(parseTreeNode, options);
};

/*
Inherit from the base widget class
*/
CodeWidget.prototype = new Widget();

/*
Render this widget into the DOM
*/
CodeWidget.prototype.render = function(parent, nextSibling) {
	this.parentDomNode = parent;
	this.computeAttributes();
	this.execute();
	this.renderChildren(parent, nextSibling);
};

/*
Compute the internal state of the widget
*/
CodeWidget.prototype.execute = function() {
	this.lang = this.getAttribute("lang");
	this.text = this.getAttribute("code");
	// Get the macro value
	var params = [{ name: "src", value: this.text }],
		variableInfo = this.getVariableInfo("copy-to-clipboard-above-right", { params: params });
	// Render the text
	variableInfo.text += "<$codeblock code=<<__src__>> language=<<__lang__>> />";
	variableInfo.params.push({ name: "lang", value: this.lang });
	var parser = this.wiki.parseText("text/vnd.tiddlywiki", variableInfo.text),
		parseTreeNodes = parser ? parser.tree : [];
	// Wrap the parse tree in a vars widget assigning the parameters to variables named "__paramname__"
	var attributes = {};
	$tw.utils.each(variableInfo.params, function(param) {
		var name = "__" + param.name + "__";
		attributes[name] = {
			name: name,
			type: "string",
			value: param.value
		};
	});
	parseTreeNodes = [{
		type: "vars",
		attributes: attributes,
		children: parseTreeNodes
	}];
	// Construct the child widgets
	this.makeChildWidgets(parseTreeNodes);
};

/*
Selectively refreshes the widget if needed. Returns true if the widget or any of its children needed re-rendering
*/
CodeWidget.prototype.refresh = function(changedTiddlers) {
	var changedAttributes = this.computeAttributes();
	if ($tw.utils.count(changedAttributes) > 0) {
		this.refreshSelf();
		return true;
	} else {
		return this.refreshChildren(changedTiddlers);
	}
};

exports.code = CodeWidget;

})();