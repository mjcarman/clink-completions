-- argument completion for oh-my-posh
require("arghelper")

local file_matches = clink.argmatcher():addarg(clink.filematches)

local global_flags = ({
  { hide=true, "-h"                                                      },
  {            "--help",                             "help for command"  },
  { hide=true, "-c"       ..file_matches                                 },
  {            "--config" ..file_matches,  " <file>", "config file path" },
})


local cache_parser = clink.argmatcher()
  :_addexarg({
    { "path",  "list cache path"         },
    { "clear", "remove all cache values" },
    { "edit",  "edit cache values"       },
  })
  :_addexflags(global_flags)


local completion_parser = clink.argmatcher()
  :_addexarg({
    { "bash",       "Generate the autocompletion script for bash"       },
    { "fish",       "Generate the autocompletion script for fish"       },
    { "powershell", "Generate the autocompletion script for powershell" },
    { "zsh",        "Generate the autocompletion script for zsh"        },
  })
  :_addexflags(global_flags)


local config_parser = clink.argmatcher()
  :_addexarg({
    { "export",  "Export your config"  },
    { "migrate", "Migrate your config" },
  })
  :_addexflags(global_flags)


local debug_parser = clink.argmatcher()
  :_addexflags({
    global_flags,
    { "-p", hide=true },
    { "--plain",              "plain text output (no ANSI)" },
    { "--pwd",   " <string>", "current working directory"   },
    { "--shell", " <shell>",  "the shell to print for"      },
  })


local font_parser = clink.argmatcher()
  :addarg(
    "install",
    "configure")
  :_addexflags({
    global_flags,
    { "--user", "install font as user" },
  })


local get_parser = clink.argmatcher()
  :addarg(
    "shell",
    "millis",
    "accent",
    "toggles",
    "width")
  :_addexflags({
    global_flags,
    { "--shell", " <shell>", "the shell to print for" },
  })


local init_parser = clink.argmatcher()
  :addarg(
    "bash",
    "zsh",
    "fish",
    "powershell",
    "pwsh",
    "cmd",
    "nu")
  :_addexflags({
    global_flags,
    { "-m", hide=true }, {"--manual", "enable/disable manual mode" },
    { "-p", hide=true }, {"--print",  "print the init script"      },
    { "-s", hide=true }, {"--strict", "run in strict mode"         },
  })


local print_parser = clink.argmatcher()
  :addarg(
    "debug",
    "primary",
    "secondary",
    "transient",
    "right",
    "tooltip",
    "valid",
    "error")
  :_addexflags({
    global_flags,
                         { "--cleared",                     "do we have a clear terminal or not"                 },
                         { "--column",         " <int>",    "the column position of the cursor"                  },
                         { "--command",        " <string>", "tooltip command"                                    },
    { "-e", hide=true},  { "--error",          " <int>",    "last exit code"                                     },
                         { "--eval",                        "output the prompt for eval"                         },
                         { "--execution-time", " <float>",  "timing of the last command"                         },
                         { "--no-exit-code",                "no valid exit code (cancelled or no command yet)"   },
                         { "--no-status",                   "no valid status code (cancelled or no command yet)" },
                         { "--pipestatus",     " <string>", "the PIPESTATUS array"                               },
    { "-p", hide=true }, { "--plain",                       "plain text output (no ANSI)"                        },
                         { "--pswd",                        "current working directory (according to pwsh)"      },
                         { "--pwd",                         "current working directory"                          },
                         { "--shell",          " <string>", "the shell to print for"                             },
                         { "--shell-version",  " <string>", "the shell version"                                  },
    { "-s", hide=true},  { "--stack-count",    " <int>",    "number of locations on the stack"                   },
                         { "--status",         " <int>",    "last known status code"                             },
    { "-w", hide=true }, { "--terminal-width", " <int>",    "width of the terminal"                              },
  })


local prompt_parser = clink.argmatcher()
  :_addexarg({
    { "debug",                 "Print the prompt in debug mode"   },
    { "init",                  "Initialize your shell and config" },
    { "print" .. print_parser, "Print the prompt/context"         },
  })
  :_addexflags(global_flags)


local feature_parser = clink.argmatcher():addarg("notice")

local upgrade_parser = clink.argmatcher()
  :_addexflags({
    global_flags,
    { "-f", hide=true }, { "--force", "force the upgrade even if the version is up to date" },
  })


clink.argmatcher("oh-my-posh")
  :_addexarg({
    { "cache"      .. cache_parser,      "Interact with the oh-my-posh cache"                         },
    { "completion" .. completion_parser, "Generate the autocompletion script for the specified shell" },
    { "config"     .. config_parser,     "Interact with the config"                                   },
    { "debug"      .. debug_parser,      "Print the prompt in debug mode"                             },
    { "disable"    .. feature_parser,    "Disable a feature"                                          },
    { "enable"     .. feature_parser,    "Enable a feature"                                           },
    { "font"       .. font_parser,       "Manage fonts"                                               },
    { "get"        .. get_parser,        "Get a value from oh-my-posh"                                },
    { "help",                            "Help about any command"                                     },
    { "init"       .. init_parser,       "Initialize your shell and config"                           },
    { "print"      .. print_parser,      "Print the prompt/context"                                   },
    { "prompt"     .. prompt_parser,     "Set up the prompt for your shell (deprecated)"              },
    { "toggle",    " <flags>",           "Toggle a segment on/off on the fly"                         },
    { "upgrade"    .. upgrade_parser,    "Upgrade when a new version is available."                   },
    { "version",                         "Print the version"                                          },
  })
  :_addexflags({
    global_flags,
    { "-i", hide=true }, { "--init",               "init (deprecated)"   },
    { "-s", hide=true }, { "--shell",  " <shell>", "shell (deprecated)"  },
                         { "--version",            "version"             },
  })
