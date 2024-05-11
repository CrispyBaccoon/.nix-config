{...}: {
  name = "text";
  src = ./.;
  appendName = false;
  injectCss = true;
  replaceColors = true;
  overwriteAssets = true;
  sidebarConfig = true;

  patches = {
    "xpui.js_find_0880" = "COLLAPSED\?64:32";
    "xpui.js_repl_0880" = "COLLAPSED?32:32";
    "xpui.js_find_8008" = ",(\w+=)56,";
    "xpui.js_repl_8008" = ",\${1}32,";
  };
}
