
(function () {

// Remove all elements after "pre"
var elements = [];
var after_pre = false;
for (var name in jsToolBar.prototype.elements) {
  if (name === "pre") {
    after_pre = true;
  } else if (after_pre) {
    elements.push({
      name: name,
      value: jsToolBar.prototype.elements[name]
    });
    delete(jsToolBar.prototype.elements[name]);
  }
}

for(var i = 0; i < pre_code_block.length; i++) {
	var name = pre_code_block[i];
	jsToolBar.prototype.elements["pre_" + name] = {
	  type: 'button',
	  title: 'Code block in ' + name,
	  fn: {wiki: function() { this.encloseLineSelection('<pre><code class="' + name + '">\n', '\n</code></pre>') }}
	}
}

// Re-insert all elements after "pre"
for (var i = 0; i < elements.length; i++) {
  jsToolBar.prototype.elements[elements[i].name] = elements[i].value;
}

})();

