require("arghelper")

--------------------------------------------------------------------------------
-- It would have been great to simply use the "winget complete" command.
-- But it doesn't provide completions for lots of things.

--------------------------------------------------------------------------------
-- Helper functions.

local function winget_complete(command)
  local matches = {}
  local winget  = os.getenv("USERPROFILE")
  if winget then
    winget = '"'..path.join(winget, "AppData\\Local\\Microsoft\\WindowsApps\\winget.exe")..'"'
    local f = io.popen('2>nul '..winget..' complete --word="" --commandline="winget '..command..' " --position='..tostring(9 + #command)) -- luacheck: no max line length
    if f then
      for line in f:lines() do
        table.insert(matches, line)
      end
      f:close()
    end
  end
  return matches
end

local function complete_export_source()
  return winget_complete("export --source")
end

--------------------------------------------------------------------------------
-- Parsers for linking.

local add_source_matches   = clink.argmatcher():addarg()
local arch_matches         = clink.argmatcher():addarg({fromhistory=true})
local command_matches      = clink.argmatcher():addarg({fromhistory=true})
local count_matches        = clink.argmatcher():addarg({fromhistory=true, 10, 20, 40})
local file_matches         = clink.argmatcher():addarg(clink.filematches)
local header_matches       = clink.argmatcher():addarg({fromhistory=true})
local id_matches           = clink.argmatcher():addarg({fromhistory=true})
local locale_matches       = clink.argmatcher():addarg({fromhistory=true})
local location_matches     = clink.argmatcher():addarg(clink.dirmatches)
local moniker_matches      = clink.argmatcher():addarg({fromhistory=true})
local name_matches         = clink.argmatcher():addarg({fromhistory=true})
local override_matches     = clink.argmatcher():addarg({fromhistory=true})
local productcode_matches  = clink.argmatcher():addarg({fromhistory=true})
local query_matches        = clink.argmatcher():addarg({fromhistory=true})
local scope_matches        = clink.argmatcher():addarg({fromhistory=true})
local setting_name_matches = clink.argmatcher():addarg({fromhistory=true})
local source_matches       = clink.argmatcher():addarg({complete_export_source})
local tag_matches          = clink.argmatcher():addarg({fromhistory=true})
local type_matches         = clink.argmatcher():addarg({"Microsoft.PreIndexed.Package"})
local url_matches          = clink.argmatcher():addarg()
local version_matches      = clink.argmatcher():addarg()

--------------------------------------------------------------------------------
-- Factored flag definitions.

local common_flags = {
    { hide=true, "--verbose-logs" },
    { hide=true, "--no-vt"        },
    { hide=true, "--rainbow"      },
    { hide=true, "--retro"        },
    { hide=true, "-?"             }, { "--help" },
}

local query_flags = {
  { "-q"..query_matches,  hide=true }, { "--query"  ..query_matches,   " <query>",   "The query used to search for a package" },
                                       { "--id"     ..id_matches,      " <id>",      "Filter results by id"                   },
                                       { "--name"   ..name_matches,    " <name>",    "Filter results by name"                 },
                                       { "--moniker"..moniker_matches, " <moniker>", "Filter results by moniker"              },
                                       { "--tag"    ..tag_matches,     " <tag>",     "Filter results by tag"                  },
                                       { "--command"..command_matches, " <command>", "Filter results by command"              },
  { "-n"..count_matches,  hide=true }, { "--count"  ..count_matches,   " <count>",   "Show no more than specified number of results (between 1 and 1000)" },
  { "-e",                 hide=true }, { "--exact",                                  "Find package using exact match"         },
}

local source_flags = {
  { "-s"..source_matches, hide=true }, { "--source"..source_matches, " <source>", "Find package using the specified source" },
}

--------------------------------------------------------------------------------
-- Command parsers.

local export_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    source_flags,
    { "-o"..file_matches, hide=true }, { "--output"..file_matches, " <file>", "File where the result is to be written" },
                                       { "--include-versions",         hide=true },
                                       { "--accept-source-agreements", hide=true },
  })
  :addarg(clink.filematches)
  :nofiles()

local features_parser = clink.argmatcher()
  :_addexflags({common_flags})
  :nofiles()

local hash_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    { "-f"..file_matches, hide=true },  { "--file"..file_matches, " <file>", "File to be hashed" },
    { "-m",               hide=true },  { "--msix",                          "Input file will be treated as msix; signature hash will be provided if signed" },
    common_flags,
  })
  :addarg(clink.filematches)
  :nofiles()

local import_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    { "-i"..file_matches, hide=true }, { "--import-file" ..file_matches, " <file>", "File describing the packages to install" },
                                       { "--ignore-unavailable",                    "Ignore unavailable packages"             },
                                       { "--ignore-versions",                       "Ignore package versions in import file"  },
                                       { "--accept-package-agreements", hide=true },
                                       { "--accept-source-agreements",  hide=true },
  })
  :addarg(clink.filematches)
  :nofiles()

local install_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    query_matches,
    source_flags,
    { "-m" ..file_matches,     hide=true }, { "--manifest"     ..file_matches,    " <file>",      "The path to the manifest of the package"                    },
    { "-v" ..version_matches,  hide=true }, { "--version"      ..version_matches, " <version>",   "Use the specified version; default is the latest version"   },
                                            { "--scope"        ..scope_matches,   " <scope>",     "Select install scope (user or machine)"                     },
    { "-a" ..arch_matches,     hide=true }, { "--architecture" ..arch_matches,    " <arch>",      "Select the architecture to install"                         },
    { "-i",                    hide=true }, { "--interactive",                                    "Request interactive installation; user input may be needed" },
    { "-h",                    hide=true }, { "--silent",                                         "Request silent installation"                                },
                                            { "--locale"       ..locale_matches,   " <locale>",   "Locale to use (BCP47 format)"                               },
    { "-o" ..file_matches,     hide=true }, { "--log"          ..file_matches,     " <file>",     "Log location (if supported)"                                },
                                            { "--override"     ..override_matches, " <string>",   "Override arguments to be passed on to the installer"        },
    { "-l" ..location_matches, hide=true }, { "--location"     ..location_matches, " <location>", "Location to install to (if supported)"                      },
                                            { "--force",                                          "Override the installer hash check"                          },
                                            { "--accept-package-agreements",                      "Accept all license agreements for packages"                 },
                                            { "--accept-source-agreements",                       "Accept all source agreements during source operations"      },
                                            { "--header"       ..header_matches,   " <header>",   "Optional Windows-Package-Manager REST source HTTP header"   },
    { "-r" ..file_matches,     hide=true }, { "--rename"       ..file_matches,     " <file>",     "The value to rename the executable file (portable)"         },
  })
  :addarg(query_matches)
  :nofiles()

local list_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    query_flags,
    source_flags,
    { "--accept-source-agreements", hide=true },
    { "--header"..header_matches,   " <header>", "Optional Windows-Package-Manager REST source HTTP header" },
  })
  :addarg(query_matches)
  :nofiles()

local search_parser = list_parser

local settings_parser = clink.argmatcher()
  :_addexflags({
    { "--enable" ..setting_name_matches, " <setting>", "Enables the specific administrator setting"  },
    { "--disable"..setting_name_matches, " <setting>", "Disables the specific administrator setting" },
  })
  :addarg(setting_name_matches)
  :nofiles()

local show_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    query_flags,
    source_flags,
    { "-m"..file_matches,    hide=true }, { "--manifest"..file_matches,    " <file>",    "The path to the manifest of the package"                  },
    { "-v"..version_matches, hide=true }, { "--version" ..version_matches, " <version>", "Use the specified version; default is the latest version" },
                                          { "--versions",                                "Show available versions of the package"                   },
                                          { "--header"  ..header_matches,  " <header>",  "Optional Windows-Package-Manager REST source HTTP header" },
                                          { "--accept-source-agreements",                "Accept all source agreements during source operations"    },
  })
  :addarg(query_matches)
  :nofiles()

local source_add_parser = clink.argmatcher()
  :_addexflags({
    common_flags,
    { "-n"..add_source_matches, hide=true }, { "--name"..add_source_matches, " <name>", "Name of the source"           },
    { "-a"..url_matches,        hide=true }, { "--arg" ..url_matches,        " <url>",  "Argument given to the source" },
    { "-t"..type_matches,       hide=true }, { "--type"..type_matches,       " <type>", "Type of the source"           },
  })
  :addarg(name_matches)
  :nofiles()

local source_list_parser = clink.argmatcher()
  :_addexflags({
    common_flags,
    { "-n"..source_matches, hide=true }, { "--name"..source_matches, " <name>", "Name of the source" },
  })
  :addarg(name_matches)
  :nofiles()

local source_update_parser = clink.argmatcher()
  :_addexflags({
    common_flags,
    { "-n"..source_matches, hide=true }, { "--name"..source_matches, " <name>", "Name of the source" },
  })
  :addarg(name_matches)
  :nofiles()

local source_remove_parser = clink.argmatcher()
  :_addexflags({
    common_flags,
    { "-n" ..source_matches, hide=true }, { "--name"..source_matches, " <name>", "Name of the source" },
  })
  :addarg(name_matches)
  :nofiles()

local source_reset_parser = clink.argmatcher()
  :_addexflags({
    common_flags,
    { "--force", "Forces the reset of the sources" },
  })
  :nofiles()

local source_export_parser = clink.argmatcher()
  :_addexflags({common_flags})
  :addarg(source_matches)
  :nofiles()

local source_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
  })
  :_addexarg({
    { "add"   ..source_add_parser,    "Add a new source"       },
    { "list"  ..source_list_parser,   "List current sources"   },
    { "update"..source_update_parser, "Update current sources" },
    { "remove"..source_remove_parser, "Remove current sources" },
    { "reset" ..source_reset_parser,  "Reset sources"          },
    { "export"..source_export_parser, "Export current sources" },
  })
  :nofiles()

local uninstall_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    query_flags,
    { "-m"..file_matches,    hide=true }, { "--manifest"    ..file_matches,        " <file>",    "The path to the manifest of the package"                               },
                                          { "--product-code"..productcode_matches, " <code>",    "Filters using the product code"                                        },
    { "-v"..version_matches, hide=true }, { "--version"     ..version_matches,     " <version>", "Use the specified version; default is the latest version"              },
    { "-i",                  hide=true }, { "--interactive",                                     "Request interactive installation; user input may be needed"            },
    { "-h",                  hide=true }, { "--silent",                                          "Request silent uninstallation"                                         },
                                          { "--purge",                                           "Deletes all files and directories in the package directory (portable)" },
                                          { "--preserve",                                        "Retains all files and directories created by the package (portable)"   },
    { "-o"..file_matches,    hide=true }, { "--log"         ..file_matches,        " <file>",    "Log location (if supported)"                                           },
                                          { "--accept-source-agreements",                        "Accept all source agreements during source operations"                 },
                                          { "--header"      ..header_matches,      " <header>",  "Optional Windows-Package-Manager REST source HTTP header"              },
  })
  :addarg(query_matches)
  :nofiles()

local upgrade_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    query_flags,
    { "-m"..file_matches,     hide=true }, { "--manifest" ..file_matches,    " <file>",      "The path to the manifest of the package"                               },
    { "-v"..version_matches,  hide=true }, { "--version"  ..version_matches, " <version>",   "Use the specified version; default is the latest version"              },
    { "-i",                   hide=true }, { "--interactive",                                "Request interactive installation; user input may be needed"            },
    { "-h",                   hide=true }, { "--silent",                                     "Request silent installation"                                           },
                                           { "--purge" ,                                     "Deletes all files and directories in the package directory (portable)" },
    { "-o"..file_matches,     hide=true }, { "--log"      ..file_matches,     " <file>",     "Log location (if supported)"                                           },
                                           { "--override" ..override_matches, " <string>",   "Override arguments to be passed on to the installer"                   },
    { "-l"..location_matches, hide=true }, { "--location" ..location_matches, " <location>", "Location to install to (if supported)"                                 },
                                           { "--force",                                      "Override the installer hash check"                                     },
                                           { "--accept-package-agreements",                  "Accept all license agreements for packages"                            },
                                           { "--accept-source-agreements",                   "Accept all source agreements during source operations"                 },
                                           { "--header"   ..header_matches,   " <header>",   "Optional Windows-Package-Manager REST source HTTP header"              },
                                           { "--all",                                        "Update all installed packages to latest if available"                  },
                                           { "--include-unknown",                            "Upgrade packages even if their current version cannot be determined"   },
  })
  :addarg(query_matches)
  :nofiles()

local validate_parser = clink.argmatcher()
  :_addexflags({
    opteq=true,
    common_flags,
    { "--manifest"..file_matches, " <file>", "The path to the manifest to be validated" },
  })
  :addarg(clink.filematches)
  :nofiles()


--------------------------------------------------------------------------------
-- Define the winget argmatcher.

clink.argmatcher("winget")
  :_addexarg({
    { "install"  .. install_parser,    "Installs the given package"                  },
    { "show"     .. show_parser,       "Shows information about a package"           },
    { "source"   .. source_parser,     "Manage sources of packages"                  },
    { "search"   .. search_parser,     "Find and show basic info of packages"        },
    { "list"     .. list_parser,       "Display installed packages"                  },
    { "upgrade"  .. upgrade_parser,    "Shows and performs available upgrades"       },
    { "uninstall".. uninstall_parser,  "Uninstalls the given package"                },
    { "hash"     .. hash_parser,       "Helper to hash installer files"              },
    { "validate" .. validate_parser,   "Validates a manifest file"                   },
    { "settings" .. settings_parser,   "Open settings or set administrator settings" },
    { "features" .. features_parser,   "Shows the status of experimental features"   },
    { "export"   .. export_parser,     "Exports a list of the installed packages"    },
    { "import"   .. import_parser,     "Installs all the packages in a file"         },
  })
  :_addexflags({
    { "-v", hide=true }, { "--version", "Display the version of the tool"  },
                         { "--info",    "Display general info of the tool" },
                         { "--help"},
  })
