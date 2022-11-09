-- argument completion for gmake
require("arghelper")

local file_matches = clink.argmatcher():addarg(clink.filematches)
local dir_matches  = clink.argmatcher():addarg(clink.dirmatches)
local eval_matches = clink.argmatcher():addarg({fromhistory=true})
local jobs_matches = clink.argmatcher():addarg({fromhistory=true})
local load_matches = clink.argmatcher():addarg({fromhistory=true})

local debug_parser = clink.argmatcher()
  :_addexarg({
    nosort=true,
    { "a", "(all)"      },
    { "b", "(basic)"    },
    { "v", "(verbose)"  },
    { "i", "(implicit)" },
    { "j", "(jobs)"     },
    { "m", "(makefile)" },
    { "p", "(print)"    },
    { "w", "(why)"      },
    { "n", "(none)"     },
  })

local sync_parser = clink.argmatcher()
  :addarg("target", "line", "recurse", "none")

clink.argmatcher("gmake")
  :_addexflags({
    { hide=true,             "-b",                                            "Ignored for compatibility." },
    { hide=true,             "-m",                                            "Ignored for compatibility." },
    { hide=true,             "-B",                                            "Unconditionally make all targets." },
    {                        "--always-make",                                 "Unconditionally make all targets." },
    { hide=true,             "-C"             .. dir_matches, " DIRECTORY",   "Change to DIRECTORY before doing anything." },
    {            opteq=true, "--directory"    .. dir_matches, "=DIRECTORY",   "Change to DIRECTORY before doing anything." },
    {                        "-d",                                            "Print lots of debugging information." },
    {            opteq=true, "--debug"        .. debug_parser, "[=FLAGS]",    "Print various types of debugging information." },
    { hide=true,             "-e",                                            "Environment variables override makefiles." },
    {                        "--environment-overrides",                       "Environment variables override makefiles." },
    {            opteq=true, "--eval"         .. eval_matches, "=STRING",     "Evaluate STRING as a makefile statement." },
    { hide=true,             "-f"             .. file_matches, " FILE",       "Read FILE as a makefile." },
    { hide=true, opteq=true, "--file"         .. file_matches, "=FILE",       "Read FILE as a makefile." },
    {            opteq=true, "--makefile"     .. file_matches, "=FILE",       "Read FILE as a makefile." },
    { hide=true,             "-h",                                            "Print help message and exit." },
    {                        "--help",                                        "Print help message and exit." },
    { hide=true,             "-i",                                            "Ignore errors from recipes." },
    {                        "--ignore-errors",                               "Ignore errors from recipes." },
    { hide=true,             "-I"             .. dir_matches,  " DIRECTORY",  "Search DIRECTORY for included makefiles." },
    {            opteq=true, "--include-dir"  .. dir_matches,  "=DIRECTORY",  "Search DIRECTORY for included makefiles." },
    { hide=true,             "-j"             .. jobs_matches, " [N]",        "Allow N jobs at once; infinite jobs with no arg." },
    {            opteq=true, "--jobs"         .. jobs_matches, "=[N]",        "Allow N jobs at once; infinite jobs with no arg." },
    { hide=true,             "-k",                                            "Keep going when some targets can't be made." },
    {                        "--keep-going",                                  "Keep going when some targets can't be made." },
    { hide=true,             "-l"             .. load_matches, " [N]",        "Don't start multiple jobs unless load is below N." },
    { hide=true, opteq=true, "--load-average" .. load_matches, "=[N]",        "Don't start multiple jobs unless load is below N." },
    {            opteq=true, "--max-load"     .. load_matches, "=[N]",        "Don't start multiple jobs unless load is below N." },
    { hide=true,             "-L",                                            "Use the latest mtime between symlinks and target." },
    {                        "--check-symlink-times",                         "Use the latest mtime between symlinks and target." },
    { hide=true,             "-n",                                            "Don't actually run any recipe; just print them." },
    { hide=true,             "--just-print",                                  "Don't actually run any recipe; just print them." },
    { hide=true,             "--recon",                                       "Don't actually run any recipe; just print them." },
    {                        "--dry-run",                                     "Don't actually run any recipe; just print them." },
    { hide=true,             "-o"             .. file_matches, " FILE",       "Consider FILE to be very old and don't remake it." },
    { hide=true, opteq=true, "--old-file"     .. file_matches, "=FILE",       "Consider FILE to be very old and don't remake it." },
    {            opteq=true, "--assume-old"   .. file_matches, "=FILE",       "Consider FILE to be very old and don't remake it." },
    { hide=true,             "-O"             .. sync_parser,  " TYPE",       "Synchronize output of parallel jobs by TYPE." },
    {            opteq=true, "--output-sync"  .. sync_parser,  "=TYPE",       "Synchronize output of parallel jobs by TYPE." },
    { hide=true,             "-p",                                            "Print make's internal database." },
    {                        "--print-data-base",                             "Print make's internal database." },
    { hide=true,             "-q",                                            "Run no recipe; exit status says if up to date." },
    {                        "--question",                                    "Run no recipe; exit status says if up to date." },
    { hide=true,             "-r",                                            "Disable the built-in implicit rules." },
    {                        "--no-builtin-rules",                            "Disable the built-in implicit rules." },
    { hide=true,             "-R",                                            "Disable the built-in variable settings." },
    {                        "--no-builtin-variables",                        "Disable the built-in variable settings." },
    { hide=true,             "-s",                                            "Don't echo recipes." },
    { hide=true,             "--silent",                                      "Don't echo recipes." },
    {                        "--quiet",                                       "Don't echo recipes." },
    { hide=true,             "-S",                                            "Turns off -k." },
    { hide=true,             "--no-keep-going",                               "Turns off -k." },
    {                        "--stop",                                        "Turns off -k." },
    { hide=true,             "-t",                                            "Touch targets instead of remaking them." },
    {                        "--touch",                                       "Touch targets instead of remaking them." },
    {                        "--trace",                                       "Print tracing information." },
    { hide=true,             "-v",                                            "Print the version number of make and exit." },
    {                        "--version",                                     "Print the version number of make and exit." },
    { hide=true,             "-w",                                            "Print the current directory." },
    {                        "--print-directory",                             "Print the current directory." },
    {                        "--no-print-directory",                          "Turn off '-w', even if it was turned on implicitly." },
    { hide=true,             "-W"             .. file_matches, " FILE",       "Consider FILE to be infinitely new." },
    { hide=true, opteq=true, "--what-if"      .. file_matches, "=FILE",       "Consider FILE to be infinitely new." },
    { hide=true, opteq=true, "--new-file"     .. file_matches, "=FILE",       "Consider FILE to be infinitely new." },
    {            opteq=true, "--assume-new"   .. file_matches, "=FILE",       "Consider FILE to be infinitely new." },
  })
  :nofiles()
