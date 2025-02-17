JsOsaDAS1.001.00bplist00�Vscript_�ObjC.import('stdlib')

var app = Application.currentApplication()
app.includeStandardAdditions = true


function updateBundleIDs() {

class TargetEntry {
  constructor(target, prefix, postfix) {
    this.target = target;
    this.prefix = prefix;
	this.postfix = postfix;
  }
  write(name) {
	var xcode = Application('Xcode');
	var projectFile = xcode.project({name: "./Provenance.xcodeproj"});
	var bundleID = project.target.buildConfiguration({"name" : "PRODUCT_BUNDLE_IDENTIFIER"})
	bundleID.value = this.prefix + "." + name + "." + this.postfix; 
  }
}

  var iosPlist = new TargetEntry("Provenance", "com", "provenance");
  var tvosPlist = new TargetEntry("ProvenanceTV", "com", "provenancetv");
  var spotlightPlist = new TargetEntry("Spotlight", "com", "provenancetv.topshelf");
  var topshelfPlist = new TargetEntry("TopShelf", "com", "provenance.Spotlight");

  var plists = [iosPlist, tvosPlist, topshelfPlist, spotlightPlist];

  var response = app.displayDialog("What's your developer name", {
      defaultAnswer: "provenance-emu",
      withIcon: "note",
      buttons: ["Cancel", "Continue"],
      defaultButton: "Continue"
  });

	var noError = true;
  plists.forEach (function(plist) {
  	var success = plist.write();
  	if (success == false) {
  		var dialogText = "Failed to save " + plist.path + " .";
  		app.displayDialog(dialogText, {withIcon: "error"});
		noError = false;
  	}
  })
  
  if (noError == true) {
  	app.displayDialog("Updated plist bundle ids", {buttons: "OK"});
  }
}

function build() {
	var scheme = app.chooseFromList(['iOS Debug', 'iOS', 'tvOS Debug', 'tvOS'], { withPrompt: 'What would you like to build' });
	
}

updateBundleIDs();
                              � jscr  ��ޭ