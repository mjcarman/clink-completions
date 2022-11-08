-- argument completion for oh-my-posh
require("arghelper")

local global_flags = ({
  { "-h", hide=true }, { "--help",              "help for command"  },
  { "-c", hide=true }, { "--config", " <file>", "config (required)" },
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
    { "--pwd",               "current working directory" },
    { "--shell", " <shell>", "the shell to print for" },
  })


local font_parser = clink.argmatcher()
  :addarg(
    "install",
    "configure")
  :_addexflags(global_flags)


local get_parser = clink.argmatcher()
  :addarg(
    "shell",
    "millis",
    "accent")
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
                         { "--command",        "tooltip command"                               },
    { "-e", hide=true},  { "--error",          "last exit code"                                },
                         { "--eval",           "output the prompt for eval"                    },
                         { "--execution-time", "timing of the last command"                    },
    { "-p", hide=true }, { "--plain",          "plain text output (no ANSI)"                   },
                         { "--pswd",           "current working directory (according to pwsh)" },
                         { "--pwd",            "current working directory"                     },
                         { "--shell",          "the shell to print for"                        },
                         { "--shell-version",  "the shell version"                             },
    { "-s", hide=true},  { "--stack-count",    "number of locations on the stack"              },
    { "-w", hide=true }, { "--terminal-width", "width of the terminal"                         },
  })


local prompt_parser = clink.argmatcher()
  :_addexarg({
    { "debug",                 "Print the prompt in debug mode"   },
    { "init",                  "Initialize your shell and config" },
    { "print" .. print_parser, "Print the prompt/context"         },
  })
  :_addexflags(global_flags)



clink.argmatcher("oh-my-posh")
  :_addexarg({
    { "cache"      .. cache_parser,      "Interact with the oh-my-posh cache"                         },
    { "completion" .. completion_parser, "Generate the autocompletion script for the specified shell" },
    { "config"     .. config_parser,     "Interact with the config"                                   },
    { "debug"      .. debug_parser,      "Print the prompt in debug mode"                             },
    { "font"       .. font_parser,       "Manage fonts"                                               },
    { "get"        .. get_parser,        "Get a value from oh-my-posh"                                },
    { "help",                            "Help about any command"                                     },
    { "init"       .. init_parser,       "Initialize your shell and config"                           },
    { "print"      .. print_parser,      "Print the prompt/context"                                   },
    { "prompt"     .. prompt_parser,     "Set up the prompt for your shell (deprecated)"              },
    { "version",                         "Print the version"                                          },
  })
  :_addexflags({
    global_flags,
    { "-i", hide=true }, { "--init",               "init (deprecated)"   },
    { "-s", hide=true }, { "--shell",  " <shell>", "shell (deprecated)"  },
                         { "--version",            "version"             },
  })
