-- argument completion for lazygit
require("arghelper")

local file_matches = clink.argmatcher():addarg(clink.filematches)
local dir_matches  = clink.argmatcher():addarg(clink.dirmatches)
local screen_modes = clink.argmatcher():addarg("normal", "half", "full")

clink.argmatcher("lazygit")
  :_addexflags({
    { hide=true, "-h"                   }, -- help
    { hide=true, "-p"   .. dir_matches  }, -- path
    { hide=true, "-f"                   }, -- filter
    { hide=true, "-v"                   }, -- version
    { hide=true, "-d"                   }, -- debug
    { hide=true, "-l"                   }, -- logs
    { hide=true, "-c"                   }, -- config
    { hide=true, "-cd"                  }, -- print-config-dir
    { hide=true, "-ucd" .. dir_matches  }, -- use-config-dir"
    { hide=true, "-w"                   }, -- work-tree
    { hide=true, "-g"   .. dir_matches  }, -- git-dir
    { hide=true, "-ucf" .. file_matches }, -- use-config-file
    { hide=true, "-sm"  .. screen_modes }, -- screen-mode

    { "--help",                            "Displays help with available flag, subcommand, and positional value parameters." },
    { "--path"            .. dir_matches,  "Path of git repo. (equivalent to --work-tree=<path> --git-dir=<path>/.git/)" },
    { "--filter",                          "Path to filter on in `git log -- <path>`. When in filter mode, the commits, reflog, and stash are filtered based on the given path, and some operations are restricted" },
    { "--version",                         "Print the current version" },
    { "--debug",                           "Run in debug mode with logging (see --logs flag below). Use the LOG_LEVEL env var to set the log level (debug/info/warn/error)" },
    { "--logs",                            "Tail lazygit logs (intended to be used when `lazygit --debug` is called in a separate terminal tab)" },
    { "--profile",                         "Start the profiler and serve it on http port 6060. See CONTRIBUTING.md for more info." },
    { "--config",                          "Print the default config" },
    { "--print-config-dir",                "Print the config directory" },
    { "--use-config-dir"  .. dir_matches,  "override default config directory with provided directory"},
    { "--work-tree",                       "equivalent of the --work-tree git argument" },
    { "--git-dir"         .. dir_matches,  "equivalent of the --git-dir git argument"},
    { "--use-config-file" .. file_matches, "Comma separated list to custom config file(s)"},
    { "--screen-mode"     .. screen_modes, "The initial screen-mode, which determines the size of the focused panel."},
  })
  :addarg("status", "branch", "log", "stash" )
  :nofiles()
