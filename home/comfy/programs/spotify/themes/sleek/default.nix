{inputs, ...}: {
  name = "sleek";
  src = inputs.spicetify-sleek;
  appendName = false;
  injectCss = true;
  replaceColors = true;
  overwriteAssets = true;
  sidebarConfig = true;
}
