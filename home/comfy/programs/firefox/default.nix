{
  pkgs,
  config,
  lib,
  inputs,
  inputs',
  ...
}: let
  inherit (lib) mkForce;
  inherit (lib.attrsets) genAttrs recursiveUpdate;
in {
  imports = [
    inputs.arkenfox.hmModules.arkenfox
    ./chrome
  ];

  programs.firefox = lib.custom.use {
    enable = true;
    arkenfox = {
      enable = true;
      version = "126.1";
    };
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
      DownloadDirectory = config.home.xdg.dirs.download;
    };
    profiles.${config.home.username} = {
      arkenfox = let
        enableSections = sections:
          genAttrs sections (_: {
            enable = true;
          });
      in
        recursiveUpdate
        {
          enable = true;
          "2600"."2651"."browser.download.useDownloadDir" = {
            enable = true;
            value = true;
          };
        } (enableSections
          ["0100" "0200" "0300" "0400" "0600" "0700" "0800" "0900" "1000" "1200" "1600" "1700" "2000" "2400" "2600" "2700" "2800" "4500"]);
      settings = let
        lock-false = mkForce {
          Value = false;
          Status = "locked";
        };
        lock-true = mkForce {
          Value = true;
          Status = "locked";
        };
      in {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "browser.startup.page" = mkForce 3; # restore session
        "layout.css.prefers-color-scheme.content-override" = 0; # prefer dark mode
        "font.name.monospace.x-western" = "Maple Mono NF";
        "font.name.serif.x-western" = "Maple Mono NF";
        "font.size.variable.x-western" = 13;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # disable general bloat
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;

        # disable newtabpage bloat
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

        "browser.startup.homepage" = mkForce "file:///home/comfy/dev/startpage/index.html";
        "browser.search.region" = "US";
        "browser.search.isUS" = true;
        "distribution.searchplugins.defaultLocale" = "en-US";
        "general.useragent.locale" = "en-US";
      };
      search.force = true;
      search.default = "brave";
      search.engines = {
        "brave" = {
          urls = [
            {
              template = "https://search.brave.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = "@brave";
        };
        "Nixpkgs" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@nixpkgs"];
        };
      };
      extensions = with inputs'.firefox-addons.packages; [
        stylus
        darkreader
        ublock-origin

        firefox-color
        sidebery
      ];
    };
  };
}
