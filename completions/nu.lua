local arghelper = require("arghelper")

local file_matches   = clink.argmatcher():addarg(clink.filematches)
local level_matches  = clink.argmatcher():addarg("error", "warn", "info", "debug", "trace")
local target_matches = clink.argmatcher():addarg("stdout", "stderr", "mixed", "file")
local table_matches  = clink.argmatcher()
  :addarg(
    "basic",
    "compact",
    "compact_double",
    "default",
    "heavy",
    "light",
    "none",
    "reinforced",
    "rounded",
    "thin",
    "with_love")

clink.argmatcher("nu")
  :_addexflags({
    { hide=true, "-h"                                                                                                                                },
    {            "--help",                                         "Display the help message for this command"                                       },
    { hide=true, "-c"                                                                                                                                },
    {            "--commands",                        " <string>", "Run the given commands and then exit"                                            },
    { hide=true, "-e"                                                                                                                                },
    {            "--execute",                         " <string>", "Run the given commands and then enter an interactive shell"                      },
    { hide=true, "-i"                                                                                                                                },
    {            "--interactive",                                  "Start as an interactive shell"                                                   },
    { hide=true, "-l"                                                                                                                                },
    {            "--login",                                        "Start as a login shell"                                                          },
    { hide=true, "-m"              .. table_matches                                                                                                  },
    {            "--table-mode"    .. table_matches,  " <mode>",   "Table mode to use. rounded is default."                                          },
    { hide=true, "-t"                                                                                                                                },
    {            "--threads",                         " <int>",    "Threads to use for parallel commands"                                            },
    { hide=true, "-v"                                                                                                                                },
    {            "--version",                                      "Print the version"                                                               },
    {            "--config"        .. file_matches,   " <file>",   "Start with an alternate config file"                                             },
    {            "--env-config"    .. file_matches,   " <file>",   "Start with an alternate environment config file"                                 },
    {            "--plugin-config" .. file_matches,   " <file>",   "Start with an alternate plugin signature file"                                   },
    {            "--log-level"     .. level_matches,  " <level>",  "Log level for diagnostic logs (error, warn, info, debug, trace). Off by default" },
    {            "--log-target"    .. target_matches, " <target>", "Set the target for the log to output. stdout, stderr(default), mixed or file"    },
    {            "--stdin",                                        "Redirect standard input to a command (with `-c`) or a script file"               },
    {            "--testbin",                         " <string>", "Run internal test binary"                                                        },
  })
